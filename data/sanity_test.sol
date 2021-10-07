pragma solidity >= 0.4;

contract SanityTest {
    uint x;

    function foo(uint a) public {
        require(x < 100);
        x++; // EVAL: safe
        require(x + a >= a);
        uint y = x + a; // EVAL: safe
    }

    function bar() public returns (uint) {
        return x + 5; // EVAL: safe
    }
}
