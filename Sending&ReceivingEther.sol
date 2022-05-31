//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;

contract ReceiveEther{
    
    // if ether is sent to the contract address without any msg.data then this function
    // is called.
    receive() external payable{}

    // if ether is sent to the contract addresss with msg.data but no such function exists
    // then this function is called.

    fallback() external payable {}

}

contract SendEther{

    function sendviatransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    } 

    function sendviasend(address payable _to) public payable {
        bool Sent = _to.send(msg.value);
        require(Sent);
    }

    function sendviacall(address payable _to) public payable {
        (bool sent , bytes memory data) = _to.call{value: msg.value}("");
        require(sent);
    }

}