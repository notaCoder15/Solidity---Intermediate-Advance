//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;

// Inheritance and Shadowing

contract A {
    string public Contract = "A";
    event Str(string message);

    function str1() public virtual  {
        emit Str("A.str1 is called");
    }

    function str2() public virtual  {
        emit Str("A.str2 is called");
    }    
}

contract B is A {
    constructor(){
       Contract = "B";
    }

    function str1() public virtual override {
        emit Str("B.str1 is called");
        A.str1();
    }

    function str2() public virtual override {
        emit Str("B.str2 is called");
        super.str2();
    }    

}

contract C is A {
    constructor(){
       Contract = "C";
    }

    function str1() public virtual override {
        emit Str("C.str1 is called");
        A.str1();
    }

    function str2() public virtual override {
        emit Str("C.str2 is called");
        super.str2();
    }    
}

contract D is B,C {
    constructor(){
        Contract = "D";
    }

    function str1() public virtual override(B,C) {
        emit Str("D.str1 is called");
        super.str1();
    }

    function str2() public virtual override(B,C) {
        emit Str("D.str2 is called");
        super.str2();
    }     

}