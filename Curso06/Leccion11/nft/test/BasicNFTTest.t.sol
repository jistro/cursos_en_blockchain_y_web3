// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Test } from "forge-std/Test.sol";
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { DeployBasicNFT } from "../script/DeployBasicNFT.s.sol";
import { BasicNFT } from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    string constant DONA_METADATA = "https://ipfs.io/ipfs/QmZjp13pA4kTdjPtksxhF94f22EbAsLyKbi7NaCC4KpJVm";

    address public USER01 = makeAddr("user01");
    
    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Donas";
        string memory actualName = basicNFT.name();
        // volvemos hash el string para poder comparar
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testSymbolIsCorrect() public view {
        string memory expectedSymbol = "DONA";
        string memory actualSymbol = basicNFT.symbol();
        // volvemos hash el string para poder comparar
        assert(keccak256(abi.encodePacked(expectedSymbol)) == keccak256(abi.encodePacked(actualSymbol)));
    }

    function testCanMintAndHaveAbalance() public {
        vm.startPrank(USER01);
            basicNFT.mintNFT(DONA_METADATA);
        vm.stopPrank();
        assert(basicNFT.balanceOf(USER01) == 1);
        assert(keccak256(abi.encodePacked(basicNFT.tokenURI(0))) == keccak256(abi.encodePacked(DONA_METADATA)));
    }

    
}