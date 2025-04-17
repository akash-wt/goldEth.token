// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Counter {
    uint private num;
    constructor(uint _num) {
        num = _num;
    }

    function Inc() public {
        num++;
    }
    function Dec() public {
        num--;
    }

    function Get() public view returns (uint) {
        return num;
    }
}


