// SPDX-License-Identifier: GPL-3.0
import "./maops.sol";
pragma solidity ^0.8.0;

contract Ballot is chainLink {
    event _allowed (string poll);
    enum _timestamp {_proposal, startTime}
    uint startTime;
    event _Poll_data (string _name, uint _votetime, uint _time, bool _closed);
    uint public constant MIN_DELAY = 11; // seconds
    uint public constant MAX_DELAY = 31; // seconds
    uint public constant GRACE_PERIOD = 367; // seconds
    address public owner;
    address public chairperson;
    struct Proposal {
        uint name;
        uint voteCount;
        uint id;
        string named;
    }
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
    Proposal[] public proposals;

    mapping(address => Voter) public voters;
    
    constructor(uint proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        startTime = block.timestamp;

        for (uint i = 0; i< proposalNames; i++) {
            proposals.push(Proposal({
                name: proposalNames-i,
                voteCount: 0,
                id: 0,
                named: "proposal" 
            }));

            emit _Poll_data("proposal", block.timestamp +300, block.timestamp, true);
        }
    }
    
     modifier _Voteended( ) {
        require(300 > uint(block.timestamp)-uint(times[0]-1),"Sorry Voting has ended for this proposal, please redeploy contract chainlink before adding proposals!");
        _;
    }
    modifier voteEnded {
        if (startTime > block.timestamp - MIN_DELAY
            )
            {
            emit _allowed("voteing time slot has yet to occur");
        }
        // ---|------------|---------------|-------
        //  block    block + min     block + max
        if (
            startTime < block.timestamp + MAX_DELAY ||
            startTime < block.timestamp + MIN_DELAY
            )
         {
            emit _allowed("voteing is currently opened");
        }

        if (startTime + GRACE_PERIOD <= block.timestamp) {
            emit _allowed( "voteing time has ended for this proposal");
        }
        _;
    }
    function vote(uint proposal) public _Voteended() {
        Voter storage sender = voters[msg.sender];
        sender.voted=true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }
}
