// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import { Test, console } from "forge-std/Test.sol";
import { NoggleNFT } from "../src/NoggleNFT.sol";

contract NogglesNFTTest is Test {
    NoggleNFT noggleNFT;
    string public constant CLASIC_NOGGLE_IMAGE_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYwIiBoZWlnaHQ9IjYwIiB2aWV3Qm94PSIwIDAgMTYwIDYwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHNoYXBlLXJlbmRlcmluZz0iY3Jpc3BFZGdlcyI+CjxwYXRoIGQ9Ik05MCAwSDMwVjEwSDkwVjBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik0xNjAgMEgxMDBWMTBIMTYwVjBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik00MCAxMEgzMFYyMEg0MFYxMFoiIGZpbGw9IiNENTNDNUUiLz4KPHBhdGggZD0iTTYwIDEwSDQwVjIwSDYwVjEwWiIgZmlsbD0id2hpdGUiLz4KPHBhdGggZD0iTTgwIDEwSDYwVjIwSDgwVjEwWiIgZmlsbD0iYmxhY2siLz4KPHBhdGggZD0iTTkwIDEwSDgwVjIwSDkwVjEwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8cGF0aCBkPSJNMTEwIDEwSDEwMFYyMEgxMTBWMTBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik0xMzAgMTBIMTEwVjIwSDEzMFYxMFoiIGZpbGw9IndoaXRlIi8+CjxwYXRoIGQ9Ik0xNTAgMTBIMTMwVjIwSDE1MFYxMFoiIGZpbGw9ImJsYWNrIi8+CjxwYXRoIGQ9Ik0xNjAgMTBIMTUwVjIwSDE2MFYxMFoiIGZpbGw9IiNENTNDNUUiLz4KPHBhdGggZD0iTTQwIDIwSDBWMzBINDBWMjBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik02MCAyMEg0MFYzMEg2MFYyMFoiIGZpbGw9IndoaXRlIi8+CjxwYXRoIGQ9Ik04MCAyMEg2MFYzMEg4MFYyMFoiIGZpbGw9ImJsYWNrIi8+CjxwYXRoIGQ9Ik0xMTAgMjBIODBWMzBIMTEwVjIwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8cGF0aCBkPSJNMTMwIDIwSDExMFYzMEgxMzBWMjBaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNMTUwIDIwSDEzMFYzMEgxNTBWMjBaIiBmaWxsPSJibGFjayIvPgo8cGF0aCBkPSJNMTYwIDIwSDE1MFYzMEgxNjBWMjBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik0xMCAzMEgwVjQwSDEwVjMwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8cGF0aCBkPSJNNDAgMzBIMzBWNDBINDBWMzBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik02MCAzMEg0MFY0MEg2MFYzMFoiIGZpbGw9IndoaXRlIi8+CjxwYXRoIGQ9Ik04MCAzMEg2MFY0MEg4MFYzMFoiIGZpbGw9ImJsYWNrIi8+CjxwYXRoIGQ9Ik05MCAzMEg4MFY0MEg5MFYzMFoiIGZpbGw9IiNENTNDNUUiLz4KPHBhdGggZD0iTTExMCAzMEgxMDBWNDBIMTEwVjMwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8cGF0aCBkPSJNMTMwIDMwSDExMFY0MEgxMzBWMzBaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNMTUwIDMwSDEzMFY0MEgxNTBWMzBaIiBmaWxsPSJibGFjayIvPgo8cGF0aCBkPSJNMTYwIDMwSDE1MFY0MEgxNjBWMzBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik0xMCA0MEgwVjUwSDEwVjQwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8cGF0aCBkPSJNNDAgNDBIMzBWNTBINDBWNDBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik02MCA0MEg0MFY1MEg2MFY0MFoiIGZpbGw9IndoaXRlIi8+CjxwYXRoIGQ9Ik04MCA0MEg2MFY1MEg4MFY0MFoiIGZpbGw9ImJsYWNrIi8+CjxwYXRoIGQ9Ik05MCA0MEg4MFY1MEg5MFY0MFoiIGZpbGw9IiNENTNDNUUiLz4KPHBhdGggZD0iTTExMCA0MEgxMDBWNTBIMTEwVjQwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8cGF0aCBkPSJNMTMwIDQwSDExMFY1MEgxMzBWNDBaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNMTUwIDQwSDEzMFY1MEgxNTBWNDBaIiBmaWxsPSJibGFjayIvPgo8cGF0aCBkPSJNMTYwIDQwSDE1MFY1MEgxNjBWNDBaIiBmaWxsPSIjRDUzQzVFIi8+CjxwYXRoIGQ9Ik05MCA1MEgzMFY2MEg5MFY1MFoiIGZpbGw9IiNENTNDNUUiLz4KPHBhdGggZD0iTTE2MCA1MEgxMDBWNjBIMTYwVjUwWiIgZmlsbD0iI0Q1M0M1RSIvPgo8L3N2Zz4=";
    string public constant PURPLE_NOGGLE_IMAGE_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYwIiBoZWlnaHQ9IjYwIiB2aWV3Qm94PSIwIDAgMTYwIDYwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHNoYXBlLXJlbmRlcmluZz0iY3Jpc3BFZGdlcyI+CjxwYXRoIGQ9Ik05MCAwSDMwVjEwSDkwVjBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTE2MCAwSDEwMFYxMEgxNjBWMFoiIGZpbGw9InB1cnBsZSIvPgo8cGF0aCBkPSJNNDAgMTBIMzBWMjBINDBWMTBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTYwIDEwSDQwVjIwSDYwVjEwWiIgZmlsbD0id2hpdGUiLz4KPHBhdGggZD0iTTgwIDEwSDYwVjIwSDgwVjEwWiIgZmlsbD0iYmxhY2siLz4KPHBhdGggZD0iTTkwIDEwSDgwVjIwSDkwVjEwWiIgZmlsbD0icHVycGxlIi8+CjxwYXRoIGQ9Ik0xMTAgMTBIMTAwVjIwSDExMFYxMFoiIGZpbGw9InB1cnBsZSIvPgo8cGF0aCBkPSJNMTMwIDEwSDExMFYyMEgxMzBWMTBaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNMTUwIDEwSDEzMFYyMEgxNTBWMTBaIiBmaWxsPSJibGFjayIvPgo8cGF0aCBkPSJNMTYwIDEwSDE1MFYyMEgxNjBWMTBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTQwIDIwSDBWMzBINDBWMjBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTYwIDIwSDQwVjMwSDYwVjIwWiIgZmlsbD0id2hpdGUiLz4KPHBhdGggZD0iTTgwIDIwSDYwVjMwSDgwVjIwWiIgZmlsbD0iYmxhY2siLz4KPHBhdGggZD0iTTExMCAyMEg4MFYzMEgxMTBWMjBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTEzMCAyMEgxMTBWMzBIMTMwVjIwWiIgZmlsbD0id2hpdGUiLz4KPHBhdGggZD0iTTE1MCAyMEgxMzBWMzBIMTUwVjIwWiIgZmlsbD0iYmxhY2siLz4KPHBhdGggZD0iTTE2MCAyMEgxNTBWMzBIMTYwVjIwWiIgZmlsbD0icHVycGxlIi8+CjxwYXRoIGQ9Ik0xMCAzMEgwVjQwSDEwVjMwWiIgZmlsbD0icHVycGxlIi8+CjxwYXRoIGQ9Ik00MCAzMEgzMFY0MEg0MFYzMFoiIGZpbGw9InB1cnBsZSIvPgo8cGF0aCBkPSJNNjAgMzBINDBWNDBINjBWMzBaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNODAgMzBINjBWNDBIODBWMzBaIiBmaWxsPSJibGFjayIvPgo8cGF0aCBkPSJNOTAgMzBIODBWNDBIOTBWMzBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTExMCAzMEgxMDBWNDBIMTEwVjMwWiIgZmlsbD0icHVycGxlIi8+CjxwYXRoIGQ9Ik0xMzAgMzBIMTEwVjQwSDEzMFYzMFoiIGZpbGw9IndoaXRlIi8+CjxwYXRoIGQ9Ik0xNTAgMzBIMTMwVjQwSDE1MFYzMFoiIGZpbGw9ImJsYWNrIi8+CjxwYXRoIGQ9Ik0xNjAgMzBIMTUwVjQwSDE2MFYzMFoiIGZpbGw9InB1cnBsZSIvPgo8cGF0aCBkPSJNMTAgNDBIMFY1MEgxMFY0MFoiIGZpbGw9InB1cnBsZSIvPgo8cGF0aCBkPSJNNDAgNDBIMzBWNTBINDBWNDBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTYwIDQwSDQwVjUwSDYwVjQwWiIgZmlsbD0id2hpdGUiLz4KPHBhdGggZD0iTTgwIDQwSDYwVjUwSDgwVjQwWiIgZmlsbD0iYmxhY2siLz4KPHBhdGggZD0iTTkwIDQwSDgwVjUwSDkwVjQwWiIgZmlsbD0icHVycGxlIi8+CjxwYXRoIGQ9Ik0xMTAgNDBIMTAwVjUwSDExMFY0MFoiIGZpbGw9InB1cnBsZSIvPgo8cGF0aCBkPSJNMTMwIDQwSDExMFY1MEgxMzBWNDBaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNMTUwIDQwSDEzMFY1MEgxNTBWNDBaIiBmaWxsPSJibGFjayIvPgo8cGF0aCBkPSJNMTYwIDQwSDE1MFY1MEgxNjBWNDBaIiBmaWxsPSJwdXJwbGUiLz4KPHBhdGggZD0iTTkwIDUwSDMwVjYwSDkwVjUwWiIgZmlsbD0icHVycGxlIi8+CjxwYXRoIGQ9Ik0xNjAgNTBIMTAwVjYwSDE2MFY1MFoiIGZpbGw9InB1cnBsZSIvPgo8L3N2Zz4=";
    
    address public USER01 = makeAddr("user01");
    function setUp() public {
        noggleNFT = new NoggleNFT(
            CLASIC_NOGGLE_IMAGE_URI,
            PURPLE_NOGGLE_IMAGE_URI
        );
    }
    function testViewTokenURI() public {
        vm.startPrank(USER01);
            noggleNFT.mintNFT();
            console.log(noggleNFT.tokenURI(0));
        vm.stopPrank();
    }
}