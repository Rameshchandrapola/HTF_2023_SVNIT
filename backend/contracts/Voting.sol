// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

/**
 * @title Owner
 * @dev Set & change owner
 */
contract Owner {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is _event name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */

  mapping (string => uint8) public votesReceived;

  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of _events
  */

  string[] public eventList;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of _events who will be contesting in the election
  */
  function Voting (string[] memory eventNames) public {
    eventList = eventNames;
  }

  // This function returns the total votes for an eventthe club has received so far
  function totalVotesFor(string memory _event) public view returns (uint8) {
    if (valid_event(_event) == false) revert();
    return votesReceived[_event];
  }

  // This function increments the vote count for the specified _event. This
  // is equivalent to casting a vote
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
