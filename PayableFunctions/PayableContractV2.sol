// Licencia
// SPDX-License-Identifier: GPL-3.0

// Versión Solidity
pragma solidity 0.8.24;

contract PayableContractV2 {
    
    // 1 ether = 1*10^18 wei
    // palabra (function) + nombre + argumentos + visibilidad + payable? + modificadores + valores devueltos

    function sendEther() public payable {}

    function withdrawEther(uint256 amount) public {

        // Tenemos 3 opciones:
            // - Send: Devuelve un booleano sobre el resultado exitoso o no de la transferencia (puede que la cuenta de destino no pueda recibir)
            // - Transfer: No sabremos si la transferencia ha fallado
            // Las dos anteriores están "capadas" a 2300 de gas, por lo que se recomienda usar el tercer tipo
            // Función call
            // recipient + call + {valor ether} + (datos)
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}