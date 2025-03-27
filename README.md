# 🔢 Sumador – Modular Addition System with Delegated Result Handling in Solidity

![Solidity](https://img.shields.io/badge/Solidity-0.8.24-blue?style=flat&logo=solidity)
![License](https://img.shields.io/badge/License-LGPL--3.0--only-green?style=flat)
![ERC20](https://img.shields.io/badge/Standard-ERC20-orange?style=flat)

## 📌 Description

This repository contains a modular smart contract system in Solidity focused on separating concerns between computation and state management:

- **`Sumador.sol`**: performs addition of two unsigned integers and delegates result storage and fee configuration.
- **`Resultado.sol`**: manages persistent storage of a result and a configurable fee, protected by an admin.
- **`interfaces/IResultado.sol`**: interface used by `Sumador` to interact with `Resultado`.

This design improves modularity, reusability, and testability of each component.

---

## 📁 Repository Structure

```
├── interfaces/
│   └── IResultado.sol      # Interface for result-handling contract
├── Resultado.sol           # Storage contract with admin-protected config
└── Sumador.sol             # Logic contract for addition and config delegation
```

---

## 🧱 Components

### `IResultado.sol`

Interface for contracts that manage results and configuration:

```solidity
// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.24;

interface IResultado {
    function setResultado(uint256 num_) external;
    function setFee(uint256 newFee_) external;
}
```

### `Resultado.sol`

Stores a result and allows admin-controlled fee configuration:

```solidity
// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.24;

contract Resultado {
    uint256 public resultado;
    address public admin;
    uint256 public fee;

    constructor(address admin_) {
        admin = admin_;
        fee = 5;
    }

    function setResultado(uint256 num_) external {
        resultado = num_;
    }

    function setFee(uint256 newFee_) external {
        if (tx.origin != admin) revert();
        fee = newFee_;
    }
}
```

### `Sumador.sol`

Performs addition and delegates operations to `Resultado`:

```solidity
// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.24;

import "./interfaces/IResultado.sol";

contract Sumador {
    address public resultado;

    constructor(address resultado_) {
        resultado = resultado_;
    }

    function addition(uint256 num1_, uint256 num2_) external {
        uint256 resultado_ = num1_ + num2_;
        IResultado(resultado).setResultado(resultado_);
    }

    function setFee(uint256 newFee_) external {
        IResultado(resultado).setFee(newFee_);
    }
}
```

---

## 🛠️ Requirements

- Solidity `^0.8.24`
- [Hardhat](https://hardhat.org/), [Foundry](https://book.getfoundry.sh/), Remix, etc.

---

## 🚀 Deployment and Usage

### 1. Deploy `Resultado.sol`

Provide an `admin` address. This contract stores results and allows only the admin to modify the fee.

### 2. Deploy `Sumador.sol`

Pass the deployed `Resultado` contract address to the constructor.

```solidity
Sumador sumador = new Sumador(address(resultado));
```

### 3. Perform addition

```solidity
sumador.addition(10, 15); // Result stored as 25
```

### 4. Change fee (admin-only)

```solidity
sumador.setFee(7); // Delegated call to Resultado.setFee(7)
```

### 5. Query stored result or fee

```solidity
resultado.resultado(); // e.g., 25
resultado.fee();       // e.g., 7
```

---

## 📄 License

This project is licensed under the **GNU Lesser General Public License v3.0** – see the [`LICENSE`](./LICENSE) file for details.

---

## 📬 Contact

For technical questions, suggestions, or improvements, feel free to open an _issue_ or a _pull request_.
