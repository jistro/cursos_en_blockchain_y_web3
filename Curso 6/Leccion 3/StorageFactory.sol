// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public listOfNewStorage;

    function createStorageContract() public returns(bool){
        SimpleStorage newContract = new SimpleStorage();
        listOfNewStorage.push(newContract);
        return true;
    }

    function sfStore(uint256 _indexList, uint256 _newStorageNumber) public returns (bool){
        //nesecitamos la direccion y el ABI (Aplication Binary Interface)
        SimpleStorage myStorage = listOfNewStorage[_indexList];
        myStorage.store(_newStorageNumber);
        return true;
    }

    function sfGet(uint256 _index) public view returns(uint256){
        return listOfNewStorage[_index].retrieve();
    }
}