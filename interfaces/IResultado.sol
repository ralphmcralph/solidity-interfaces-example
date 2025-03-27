// Licencia
// SPDX-License-Identifier: LGPL-3.0-only

// Versión solidity
pragma solidity 0.8.24;

// function + nombre + argumentos + visibilidad + modificadores + valor devuelto

interface IResultado {
    function setResultado(uint256 num_) external;
    function setFee(uint256 newFee_) external;
}