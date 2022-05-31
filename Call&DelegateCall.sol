//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;

    //source - https://solidity-by-example.org/

contract Receiver{
    
    // call is a low level function to interact with other contracts.
    //This is the recommended method to use when you're just sending Ether via calling the fallback function.
    //However it is not the recommend way to call existing functions.

    event Received(address caller , uint amount , string message);

    fallback() external payable{
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    function receiver(string memory _message , uint _x) public payable returns(uint){
        emit Received(msg.sender, msg.value, _message);

        return _x ;
    }
}

contract Call{
    event Response(bool success , bytes data);

    function callreceiver(address payable _addr) public payable {                    
        (bool success , bytes memory data) = _addr.call{value: msg.value , gas: 5000}(         // Call receiver function in Receiver contract
            abi.encodeWithSignature("receiver(string,uint256)", "call receiver" , 123)          // calling address is the address of this contract
        );

        emit Response(success, data);
    }

    function calldoesnotexists(address payable _addr) public payable {
        (bool success , bytes memory data) = _addr.call{value: msg.value , gas: 5000}(
            abi.encodeWithSignature("doesnotExists()")
        );

        emit Response(success, data);
    }
    
}

contract DelegateCall{
    //delegatecall is a low level function similar to call.
    //When contract A executes delegatecall to contract B, B's code is executed
    //with contract A's storage, msg.sender and msg.value.

    event Response(bool success , bytes data);

    function callreceiver(address payable _addr) public payable {
        (bool success , bytes memory data) = _addr.delegatecall(                                // function receive is called in contract Receive
            abi.encodeWithSignature("receiver(string,uint256)", "call receiver" , 123)       // msg.sender and msg.value is the same of the fucntion
        );

        emit Response(success, data);
    }

    function calldoesnotexists(address payable _addr) public payable {
        (bool success , bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("doesnotExists()")
        );

        emit Response(success, data);
    }

}