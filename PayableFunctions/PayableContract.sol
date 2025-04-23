// Licencia
// SPDX-License-Identifier: GPL-3.0

// Versión Solidity
pragma solidity 0.8.24;

contract PayableContract {
    
    // 1 ether = 1*10^18 wei
    // palabra (function) + nombre + argumentos + visibilidad + payable? + modificadores + valores devueltos

    function sendEther() public payable {}

}