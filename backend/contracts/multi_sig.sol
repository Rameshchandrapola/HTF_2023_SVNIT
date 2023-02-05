pragma solidity ^0.4.25;

contract SimpleMultisig {

  address[3] public _owners;
  mapping(address => bool) public signed;
  uint8 numberOfSignatures=0;
  uint8 numberofSignRequired=2;
  uint8 total_owners=3;

  constructor() public {
    _owners[0] = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    _owners[1] = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    _owners[2] = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
  }


  function Sign() public {
    for (uint i = 0; i < _owners.length; i++) {
        address owner = _owners[i];

        if(owner==msg.sender){
        signed[owner] = true;
        }
    }
  }



  function Action() public  returns (string) {

    for (uint i = 0; i < _owners.length; i++) {

            address owner = _owners[i];
        if(signed[owner]==true){
          numberOfSignatures++;
        }
        }
        require(numberOfSignatures >= numberofSignRequired, "not enough signatures");
  }
}

