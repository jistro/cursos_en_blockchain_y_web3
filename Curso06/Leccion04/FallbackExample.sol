// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract FallBackExample {
    uint256 public balanceReceived;
    bool public usoFallback;
    receive() external payable {
        balanceReceived += msg.value;
    }
    fallback() external payable {
        usoFallback = true;
    }
    /*
        Eth es enviado al contrato

        es msg.data vacio?
            /       \
            si      no
            /       \
        recive  fallback
        /   \
        si  no
        /   \
    revert  fallback

    */
}