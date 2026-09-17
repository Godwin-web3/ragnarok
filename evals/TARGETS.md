# Broken systems

Pinned public targets. Educational or historical. Not live exploitation.

| ID | System | Why it belongs | Expected class | Status |
| :--- | :--- | :--- | :--- | :--- |
| dvd-unstoppable | Damn Vulnerable DeFi — Unstoppable | Two representations of vault backing. Token balance vs share accounting. Flash loan path asserts they match. | GRIEF | queued |
| dvd-side-entrance | Damn Vulnerable DeFi — Side Entrance | Flash-loan repayment vs deposit ledger. Same fact, two books. | EXTRACT | queued |
| dvd-puppet | Damn Vulnerable DeFi — Puppet | Spot DEX price used as solvency. Price vs collateral. | EXTRACT | queued |
| dvd-truster | Damn Vulnerable DeFi — Truster | Authorization separated from execution. Target executes arbitrary call during a loan. | EXTRACT | queued |

Source pin for DVD targets: [theredguild/damn-vulnerable-defi](https://github.com/theredguild/damn-vulnerable-defi).

Add a row only when the target has public source and a known broken invariant. Do not add live bounty programs here.
