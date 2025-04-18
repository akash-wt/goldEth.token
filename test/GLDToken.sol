// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/GLDToken.sol";
import "forge-std/Vm.sol";

contract TestGLDToken is Test {
    GLDToken c;

    event Transfer(address indexed from, address indexed to, uint value);

    function setUp() public {
        c = new GLDToken();
    }

    function test_emits() public {

        address account = address(0x19F7C3588F05439A95a60dBb946317A93A254be9);
        uint256 balance = 10 ether; 

        vm.deal(account, balance);
        c.mint(address(this), 100);

       

        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), 0x19F7C3588F05439A95a60dBb946317A93A254be9, 100);
        c.transfer(0x19F7C3588F05439A95a60dBb946317A93A254be9, 100);
    }

    function testMint() public {
        c.mint(0x19F7C3588F05439A95a60dBb946317A93A254be9, 100);
        assertEq(c.balanceOf(0x19F7C3588F05439A95a60dBb946317A93A254be9), 100);
    }

    function testTransfer() public {
        // minting
        c.mint(address(this), 100);
        c.transfer(0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5, 100);

        assertEq(c.balanceOf(0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5), 100);
        assertEq(c.balanceOf(address(this)), 0);
    }

    function testApprovel() public {
        c.mint(address(this), 100);
        console.logAddress(address(this));
        c.approve(0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5, 50);
        uint amount = c.allowance(address(this), 0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5);
        assertEq(amount, 50);

        vm.prank(0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5);
        c.transferFrom(address(this), 0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5, 50);
        assertEq(c.balanceOf(address(this)), 50);

        assertEq(c.balanceOf(0x70f088aDc6E92B091fb6DD19070F57E9BD2d9Ac5), 50);
    }

    // fail

    function test_allowance() public {
        c.mint(address(this), 100);
        vm.prank(0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD);
        vm.expectRevert();
        c.transferFrom(address(this), 0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD, 100);
    }
}
