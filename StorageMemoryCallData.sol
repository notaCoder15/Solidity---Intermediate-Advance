//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;


/* 

Taken from : https://stackoverflow.com/questions/33839154/in-ethereum-solidity-what-is-the-purpose-of-the-memory-keyword
            https://ethereum.stackexchange.com/questions/74442/when-should-i-use-calldata-and-when-should-i-use-memory

Storage: 
the structure of storage is set in stone at the time of contract creation based on your contract-level
variable declarations and cannot be changed by future method calls. BUT -- the contents of that storage 
can be changed with sendTransaction calls. Such calls change “state” which is why contract-level variables
are called “state variables”. So a variable uint8 storagevar; declared at the contract level can be changed 
to any valid value of uint8 (0-255) but that “slot” for a value of type uint8 will always be there.

Without the memory keyword, Solidity tries to declare variables in storage.


Memory: 
Memory tells solidity to create a chunk of space for the variable at method runtime, guaranteeing its size
and structure for future use in that method.memory's lifetime is limited to a function call and is meant 
to be used to temporarily store variables and their values. Values stored in memory do not persist on the 
network after the transaction has been completed. 
It is mutable.


CallData:
calldata is very similar to memory in that it is a data location where items are stored. It is a special 
data location that contains the function arguments, only available for external function call parameters.
This is the cheapest location to use. It can only be used for function declaration parameters.
It is immutable. 


The types where the so-called storage location is important are structs and arrays. If you e.g. pass such 
variables in function calls, their data is not copied if it can stay in memory or stay in storage. This means 
that you can modify their content in the called function and these modifications will still be visible in the caller.

*/
contract DataLocations{
    
    uint[] public num;

    function change1() public{
        num.push(5);
        num.push(6);
        uint[] storage myArray = num;
        myArray[0] = 1;
    }

    // myArray points to the same address as num so num[0] will give 1;

    function change2() public {
        num.push(5);
        num.push(6);
        uint[] memory myArray = num;
        myArray[0] = 1;
    }
    // num array is copied into memory and myArray now references an address that is different than num
    // so num[0] after change2 is called is still 5;
}