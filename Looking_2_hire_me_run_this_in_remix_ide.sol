// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
contract TimneNoid {
    struct data {
        uint vblock;
        uint lastime;
    }
    uint vblock;
    uint lastime;
    enum Data {vblock, lastime}

    modifier updateTime() {
        require(block.number > uint(Data.vblock) && block.timestamp > uint(Data.lastime));
        _;
    }

    function getblok() public returns(uint) {
        vblock=block.number;
        vblock=uint(Data.vblock);
        return  vblock;
    }
    function priortime() public returns(uint) {
        lastime = block.timestamp;
        lastime=uint(Data.lastime);
        return lastime;
    }
    function _updatetime() public updateTime {
        getblok();
        priortime();
    }
}

contract TimeReporter is TimneNoid {
    bytes abi ;
    int a = int(block.timestamp);
    //enum Data {vblock, lastime}
    Data Vblock = Data.vblock;
    Data Lastime = Data.lastime;
    event TimeLog(uint256 time, uint _block, uint _lastime);
    
    
    function reportTime(uint vblock, uint lastime) updateTime public returns (uint averageBlocktime) {
        for (uint8 i = 0; i<10; i++) {
            Vblock = Data.vblock;
            Lastime= Data.lastime;
            averageBlocktime=uint(block.timestamp-lastime)/uint(block.number-vblock);
            emit TimeLog(averageBlocktime, block.number, block.timestamp);
            return averageBlocktime;
        }   
    }
    fallback() external {
        bytes memory abi; 
        a = int(uint(block.timestamp));
        abi ;
    }
}
