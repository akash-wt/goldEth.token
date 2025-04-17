// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Counter.sol";

contract TestCounter is Test {
     Counter c;

    function setUp() public {
        c = new Counter(1);
    }

    function testInc() public {
        c.Inc();
        c.Inc();
        assertEq(c.Get(),3,"ok" );
    }

   
    function testDec() public {
       c.Dec();
       vm.expectRevert();
       c.Dec();
        
    }
}
