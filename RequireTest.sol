// Licencia
// SPDX-License-Identifier: LGPL-3.0-only

// Versión solidity
pragma solidity 0.8.24;

// Custom errors

error SenderNotAdmin(address);

// Contrato

contract RequireTest {
    address public admin;

    constructor (address admin_) {
        admin = admin_;
    }

    //Function + if check: msg.sender igual a admin
    function checkAdmin() public view {
        if (msg.sender != admin) revert();
    }

    function checkAdminRequire() public view {
        require(msg.sender == admin, "Msg.sender is not admin");
    }

    function checkAdminCustomError() public view {
        if(msg.sender != admin) revert SenderNotAdmin(msg.sender);
    }
} 