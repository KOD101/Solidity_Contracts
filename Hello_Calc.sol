// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;contract Calculator {
    uint lastime;    
    uint vblock;          
    function arithmetics(uint _num_1, uint _num_2) public pure returns(uint sum, uint product) {

        sum= _num_2 + _num_2;
        product = _num_2*_num_1;

    }

    function UpdateABT() VoteEnds public view returns(uint vblock, uint lastime) {
        lastime=block.timestamp;
        vblock=block.number;
    }

    function multiply(uint _num_1, uint _num_2) public pure returns (uint) {
        return _num_1*_num_2;
    
    }
    modifier VoteEnds() {

        require(lastime+300 < block.timestamp);
        require(vblock<block.number);
        _;
    }
    function getAveBlockTime() VoteEnds public view returns (uint) {

        //require(lastime+60 < block.timestamp);
        //require(vblock<block.number);
        return ((block.timestamp-lastime)/(block.number-vblock));
    }
}
