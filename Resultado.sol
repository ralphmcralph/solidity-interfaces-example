// Licencia
// SPDX-License-Identifier: LGPL-3.0-only

// Versión solidity
pragma solidity 0.8.24;

// Contrato

contract Resultado {

    uint256 public resultado;

    // function + nombre + argumentos + visibilidad + modificadores + valor devuelto
    function setResultado(uint256 num_) external {
        resultado = num_;
    }

}