// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract auraToken is ERC20 {
    /**
     * @dev init constructor
     *
     */

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 mintedToken_
    ) ERC20(name_, symbol_) {
        _mint(msg.sender, mintedToken_);
    }
}
