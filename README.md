# 🔢 Sumador – Sistema modular de suma con delegación de resultado en Solidity

[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)

## 📌 Descripción

Este repositorio contiene un sistema de contratos inteligentes en Solidity diseñado con una arquitectura modular basada en separación de responsabilidades:

- **`Sumador.sol`**: realiza la suma de dos enteros (`uint256`) y delega el almacenamiento del resultado.
- **`Resultado.sol`**: contrato simple que almacena un resultado y permite consultarlo públicamente.
- **`interfaces/IResultado.sol`**: interfaz usada por `Sumador` para interactuar con `Resultado` sin acoplamiento directo.

Este diseño favorece la extensibilidad, reutilización de componentes y pruebas unitarias más sencillas.

---

## 📁 Estructura del repositorio

```
├── interfaces/
│   └── IResultado.sol      # Interfaz del contrato de resultado
├── Resultado.sol           # Contrato de almacenamiento
└── Sumador.sol             # Contrato que ejecuta la lógica de suma
```

---

## 🧱 Componentes

### `IResultado.sol`

Interfaz para contratos que gestionan resultados:

```solidity
// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.24;

interface IResultado {
    function setResultado(uint256 num_) external;
}
```

### `Resultado.sol`

Contrato que almacena un único valor `uint256`:

```solidity
// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.24;

contract Resultado {
    uint256 public resultado;

    function setResultado(uint256 num_) external {
        resultado = num_;
    }
}
```

### `Sumador.sol`

Contrato que realiza la suma y delega el resultado a un contrato externo:

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
}
```

---

## 🛠️ Requisitos

- Solidity `^0.8.24`
- [Hardhat](https://hardhat.org/), [Foundry](https://book.getfoundry.sh/), Remix, etc.

---

## 🚀 Despliegue y uso

### 1. Desplegar `Resultado.sol`

Este contrato actuará como destino de los resultados calculados.

### 2. Desplegar `Sumador.sol`

Pasa la dirección del contrato `Resultado` como parámetro del constructor.

```solidity
Sumador sumador = new Sumador(address(resultado));
```

### 3. Realizar una operación

```solidity
sumador.addition(42, 58); // Resultado: 100
```

### 4. Consultar el resultado

```solidity
uint256 valor = resultado.resultado(); // valor = 100
```

## 📄 Licencia

Este proyecto está licenciado bajo la **GNU Lesser General Public License v3.0** – ver el archivo [`LICENSE`](./LICENSE) para más detalles.

---

## 📬 Contacto

Para dudas técnicas, sugerencias o mejoras, puedes abrir un _issue_ o un _pull request_.
