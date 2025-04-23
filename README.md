# 🔢 Sumador – Modular Addition & Payment System in Solidity

![Solidity](https://img.shields.io/badge/Solidity-0.8.24-blue?style=flat&logo=solidity)
![License](https://img.shields.io/badge/License-LGPL--3.0--only-green?style=flat)
![ERC20](https://img.shields.io/badge/Standard-ERC20-orange?style=flat)

## 📌 Description

This repository presents a modular architecture for Solidity smart contracts focusing on two main domains:

1. **Arithmetic Logic with Delegated Storage**
2. **Ether Transfer Handling (payable functions)**

Key modules:

- **`Sumador.sol`**: performs addition and delegates result storage and fee updates.
- **`Resultado.sol`**: holds persistent result and admin-configured fee.
- **`interfaces/IResultado.sol`**: interface implemented by `Resultado`.
- **`PayableContractV2.sol`**: demonstrates ether sending using low-level calls with proper error handling.

This separation of concerns enhances reusability, testability, and security.

---

## 📁 Repository Structure

```
├── PayableFunctions/
│   ├── PayableContract.sol      # Original payable example (legacy)
│   └── PayableContractV2.sol    # Enhanced ether transfer logic
├── interfaces/
│   └── IResultado.sol           # Interface for Resultado contract
├── Resultado.sol                # Storage contract with admin protection
├── Sumador.sol                  # Logic contract for addition & delegation
├── RequireTest.sol              # Possibly for testing 'require' behavior
```

---

## 🧱 Components

### `IResultado.sol`

Defines the expected interface for result storage contracts:

```solidity
interface IResultado {
    function setResultado(uint256 num_) external;
    function setFee(uint256 newFee_) external;
}
```

### `Resultado.sol`

Stores a numerical result and allows only the `admin` to change the `fee`.

```solidity
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

Handles logic and delegates persistence and config:

```solidity
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

### `PayableContractV2.sol`

Demonstrates secure value transfer using `call`:

```solidity
function withdrawEther(uint256 amount) public {
    (bool success,) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
}
```

Includes notes on the 2300 gas stipend limitation and best practices for ETH transfers.

---

## 🛠️ Requirements

- Solidity `^0.8.24`
- Compatible with [Hardhat](https://hardhat.org/), [Foundry](https://book.getfoundry.sh/), or Remix IDE

---

## 🚀 Deployment & Usage

### 1. Deploy `Resultado.sol`
Supply the admin address in constructor.

### 2. Deploy `Sumador.sol`
Pass the `Resultado` contract address.

```solidity
Sumador sumador = new Sumador(address(resultado));
```

### 3. Use `addition()`
Adds two numbers and stores the result.

### 4. Admin updates the fee

```solidity
sumador.setFee(10);
```

### 5. Handle Ether transfers
Use `PayableContractV2`'s `withdrawEther()` to safely transfer ETH.

---

## 📄 License

Licensed under the **GNU Lesser General Public License v3.0** – see the [`LICENSE`](./LICENSE) file.

---

## 📬 Contact

Feel free to open an issue or pull request for feedback, bugs, or improvements.
