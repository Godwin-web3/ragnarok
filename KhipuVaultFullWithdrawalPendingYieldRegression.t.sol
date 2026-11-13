// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {IndividualPoolV3} from "../src/pools/v3/IndividualPoolV3.sol";
import {YieldAggregatorV3} from "../src/integrations/v3/YieldAggregatorV3.sol";
import {IYieldAggregator} from "../src/interfaces/IYieldAggregator.sol";
import {UUPSProxy} from "../src/proxy/UUPSProxy.sol";
import {MockMUSD} from "./mocks/MockMUSD.sol";

/// @notice Regression tests for the full-withdrawal amount mismatch at the pool/aggregator boundary.
/// @dev This file is copied into KhipuVault's packages/contracts/test directory by the CI workflow.
contract KhipuVaultFullWithdrawalPendingYieldRegression is Test {
    MockMUSD internal musd;
    YieldAggregatorV3 internal aggregator;
    IndividualPoolV3 internal pool;

    address internal constant USER = address(0xA11CE);
    address internal constant TEST_VAULT = address(0xBEEF);
    uint256 internal constant PRINCIPAL = 1_000 ether;

    function setUp() public {
        musd = new MockMUSD();

        YieldAggregatorV3 aggregatorImplementation = new YieldAggregatorV3();
        UUPSProxy aggregatorProxy = new UUPSProxy(
            address(aggregatorImplementation),
            abi.encodeCall(YieldAggregatorV3.initialize, (address(musd)))
        );
        aggregator = YieldAggregatorV3(address(aggregatorProxy));

        aggregator.addVault(TEST_VAULT, IYieldAggregator.YieldStrategy.AAVE, 600);

        // The testnet strategy simulates yield without generating external assets.
        // Prefund the aggregator so the claim-then-withdraw control has a reserve.
        musd.mint(address(aggregatorProxy), 100 ether);

        IndividualPoolV3 poolImplementation = new IndividualPoolV3();
        UUPSProxy poolProxy = new UUPSProxy(address(poolImplementation), bytes(""));
        pool = IndividualPoolV3(address(poolProxy));
        pool.initialize(
            address(musd),
            address(aggregator),
            address(this),
            0,
            1 ether,
            100_000 ether,
            1 ether
        );

        aggregator.setAuthorizedCaller(address(pool), true);
        pool.setEmergencyMode(true);

        musd.mint(USER, PRINCIPAL);
        vm.prank(USER);
        musd.approve(address(pool), type(uint256).max);
    }

    function test_fullWithdrawalSucceedsBeforeYieldAccrues() public {
        vm.prank(USER);
        pool.deposit(PRINCIPAL);

        (uint256 principal, uint256 netYield) = _withdrawAsUser();

        assertEq(principal, PRINCIPAL);
        assertEq(netYield, 0);
        assertEq(musd.balanceOf(USER), PRINCIPAL);
    }

    function test_fullWithdrawalRevertsWhenPendingYieldIsPositive() public {
        vm.prank(USER);
        pool.deposit(PRINCIPAL);

        vm.warp(block.timestamp + 30 days);

        uint256 pendingYield = aggregator.getPendingYield(address(pool));
        assertGt(pendingYield, 0, "precondition: aggregator must report positive pending yield");
        assertEq(
            aggregator.userTotalDeposited(address(pool)),
            PRINCIPAL,
            "aggregator accounting should still record principal only"
        );

        // Pool passes principal + yield to withdraw(), while the aggregator's
        // amount guard only permits amount <= userTotalDeposited (principal).
        vm.expectRevert(YieldAggregatorV3.InvalidAmount.selector);
        vm.prank(USER);
        pool.withdraw();

        // The revert must be atomic: the user's pool position and aggregator
        // principal accounting remain intact after the failed combined exit.
        (uint256 poolPrincipal,,,,,) = pool.getUserInfo(USER);
        assertEq(poolPrincipal, PRINCIPAL);
        assertEq(aggregator.userTotalDeposited(address(pool)), PRINCIPAL);
    }

    function test_claimYieldFirstAllowsPrincipalWithdrawal() public {
        vm.prank(USER);
        pool.deposit(PRINCIPAL);

        vm.warp(block.timestamp + 30 days);
        uint256 pendingYield = aggregator.getPendingYield(address(pool));
        assertGt(pendingYield, 0);

        vm.prank(USER);
        pool.claimYield();

        assertEq(aggregator.getPendingYield(address(pool)), 0);

        (uint256 principal, uint256 netYield) = _withdrawAsUser();
        assertEq(principal, PRINCIPAL);
        assertEq(netYield, 0);
        assertEq(musd.balanceOf(USER), PRINCIPAL + pendingYield);
    }

    function _withdrawAsUser() internal returns (uint256 principal, uint256 netYield) {
        vm.prank(USER);
        return pool.withdraw();
    }
}
