// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract auraToken is ERC20 {
    /**
     * @dev contract variables
     */
    uint256 public constant BURN_PERCENTAGE = 1; // 0.1% || we will handle this in transfer function
    address public constant BURN_ADDRESS = 0x86FC854bd2ADA85C398e8aA3085D1a5069Ba738D; // my dev address, you can change this to your appropriate burn adr
    /**
     * @dev init constructor
     * @param name_ token name
     * @param symbol_ token symbol
     * @param mintedToken_ token supply (mint to deployer address)
     */

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 mintedToken_
    ) ERC20(name_, symbol_) {
        _mint(msg.sender, mintedToken_);
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override{
        uint256 burnAmount = amount * BURN_PERCENTAGE / 1000; // this handle .1%
        super._transfer(sender, recipient, amount);
        super._transfer(sender, BURN_ADDRESS, burnAmount);
    }
}
