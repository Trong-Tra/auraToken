// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RolexGMTMasterII is Ownable, ERC721 {
    /**
     * @dev error
     */
    error NFTAlreadyMinted();
    error InsufficientAllowance();
    error TransferFailed();

    /**
     * @dev contract variables
     */
    IERC20 public paymentToken;
    uint256 public mint_price;
    bool private _minted;

    constructor(
        address _paymentToken,
        uint256 _mintPrice
    ) ERC721("Rolex GMT-Master II", "") Ownable(msg.sender) {
        paymentToken = IERC20(_paymentToken);
        mint_price = _mintPrice;
    }

    /**
     * @dev function allow user to mint NFT, restricted 1 NFT per address
     */
    function mint() public onlyOwner returns (uint256) {
        if (_minted) revert NFTAlreadyMinted();

        uint256 allowance = paymentToken.allowance(msg.sender, address(this));
        if (allowance < mint_price) revert InsufficientAllowance();

        bool success = paymentToken.transferFrom(
            msg.sender,
            address(this),
            mint_price
        );
        if (!success) revert TransferFailed();

        _safeMint(owner(), 0);
        _minted = true;
        return 0;
    }
}