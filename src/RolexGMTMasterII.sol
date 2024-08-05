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
    error NoFund();
    error mintLimitReached();

    /**
     * @dev contract variables
     */
    IERC20 public paymentToken;
    uint256 public mint_price;
    uint256 public supply;
    uint256 public tokenID;

    mapping(address => bool) private _minted;

    /**
     * @param _paymentToken payment token address
     * @param _mintPrice price to mint NFT
     * @param _supply NFT supply
     */
    constructor(
        address _paymentToken,
        uint256 _mintPrice,
        uint256 _supply
    ) ERC721("Rolex GMT-Master II", "") Ownable(msg.sender) {
        paymentToken = IERC20(_paymentToken);
        mint_price = _mintPrice;
        supply = _supply;
        tokenID = 0;
    }

    /**
     * @dev this function allow to mint NFT, restricted 1 NFT per address
     */
    function mint() public {
        if (supply <= 0) revert mintLimitReached();
        if (_minted[msg.sender]) revert NFTAlreadyMinted();

        uint256 allowance = paymentToken.allowance(msg.sender, address(this));
        if (allowance < mint_price) revert InsufficientAllowance();

        bool success = paymentToken.transferFrom(
            msg.sender,
            address(this),
            mint_price
        );
        if (!success) revert TransferFailed();

        _safeMint(msg.sender, tokenID);
        supply--;
        tokenID++;
        _minted[msg.sender] = true;
    }

    /**
     * @dev this function allow contract deployer to withdraw from contract
     */
    function withdraw() public onlyOwner {
        uint256 balance = paymentToken.balanceOf(address(this));
        if (balance == 0) revert NoFund();
        paymentToken.transfer(owner(), balance);
    }
}

// helper command to check git pushing problem
