// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;

    constructor(

    ) ERC721("Donas", "DONA") {
        s_tokenCounter = 0;
    }

    function mintNFT() public {
        
    }
}