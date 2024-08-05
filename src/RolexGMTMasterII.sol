// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract RolexGMTMasterII is Ownable, ERC721 {
    error NFTAlreadyMinted();

    /**
     * @dev contract variables
     */
    bool private _minted;

    constructor() ERC721("Rolex GMT-Master II", "") Ownable(msg.sender) {}

    function mint() public onlyOwner returns (uint256) {
        if (_minted) revert NFTAlreadyMinted();
        _safeMint(owner(), 0);
        _minted = true;
        return 0;
    }
}
