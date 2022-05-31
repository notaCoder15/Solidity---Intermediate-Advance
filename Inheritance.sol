//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;

// Inheritance and Shadowing
// Source - https://solidity-by-example.org/

contract A {
    string public Contract = "A";
    event Str(string message);

    function str1() public virtual  {
        emit Str("A.str1 is called");   // returns an event with message A.str1 is called 
    }

    function str2() public virtual  {
        emit Str("A.str2 is called");   // returns an event with message A.str2 is called
    }    
}

contract B is A {
    constructor(){
       Contract = "B";                   // overrides the variable Contract to B
    }

    function str1() public virtual override {
        emit Str("B.str1 is called");   // returns an event with message B.str1 is called
        A.str1();                      // returns an event with message A.str1 is called ; Calling directly;
    }

    function str2() public virtual override {
        emit Str("B.str2 is called");   // returns an event with message B.str2 is called
        super.str2();                   // returns an event with message A.str2 is called ; Calling on parent Contract with super
    }    

}

contract C is A {
    constructor(){
       Contract = "C";                  // overrides the variable Contract to C
    }   

    function str1() public virtual override {
        emit Str("C.str1 is called");       // returns an event with message C.str1 is called
        A.str1();                           // returns an event with message A.str1 is called ; Calling directly;
    }

    function str2() public virtual override {
        emit Str("C.str2 is called");          // returns an event with message C.str2 is called
        super.str2();                   // returns an event with message A.str2 is called ; Calling on parent Contract with super
    }    
}

contract D is B,C {
    constructor(){
        Contract = "D";                 // overrides the variable Contract to C
    }

    function str1() public virtual override(B,C) {
        emit Str("D.str1 is called");       // returns an event with message D.str1 is called
        C.str1();                       // Call C; "C.st1 is called " --> "A.str1 is called";
    }

    function str2() public virtual override(B,C) {
        emit Str("D.str2 is called");       // returns an event with message D.str2 is called
        super.str2();                       // Call all parents; "C.str2 is called" --> "B.str2 is called" --> "A.str2 is called";git 
    }     

}