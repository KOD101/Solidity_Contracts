// SPDX-License-Identifier: GPL-3.0
//import "./Harmony.sol";
pragma solidity ^0.8.7;

contract a {
    uint[1] a;
}
contract chainLink is a {
    mapping (string => uint) public rollcall;
    string[] names;
    uint[] times;
    function append_name(string memory _name) public returns(uint) {
        names.push(_name);
        times.push(uint(block.timestamp));
        //rollcall[names[names.length]]=uint(times[times.length]+1);
        return  uint(block.timestamp)-uint(times[0]-1);

    }
    fallback(bytes calldata) external returns(bytes memory) {
        a;
        abi;
    }

}
