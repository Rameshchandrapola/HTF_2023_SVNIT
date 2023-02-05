// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Owner {

  mapping (string => uint8) public votesReceived;



  string[] public eventList;



  function transferEther(address payable recipient) public payable{
        recipient.transfer(msg.value);
    }
  function Voting (string[] memory eventNames) public {
    eventList = eventNames;
  }


  function totalVotesFor(string memory _event) public view returns (uint8) {
    if (valid_event(_event) == false) revert();
    return votesReceived[_event];
  }

  function voteFor_event(string memory _event) public {
    if (valid_event(_event) == false) revert();
    votesReceived[_event] += 1;
  }

  function valid_event(string memory _event) public view returns (bool) {
    for(uint i = 0; i < eventList.length; i++) {
      if (keccak256(bytes(eventList[i])) == keccak256(bytes(_event))) {
        return true;
      }
    }
    return false;
  }
}
