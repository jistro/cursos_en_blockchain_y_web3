
pragma solidity >=0.4.0 <0.7.0;

contract funcionesGlobales
{
    function MsgSender () public view retunrs (address)
    {
        retunr msg.sender
    }
    funcion BlockCoinbase() public view retunrs (address)
    {
        retunrs block.coinbase;
    }

}