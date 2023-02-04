// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract Lock {
    string category;
    address organizer = msg.sender;
    struct Club {
        string name;
        address owner;
        string title;
        string description;
        uint256 club_id;
        string img;
        string logo;
        uint256 funds; //amt of funds by organizer
    }

    

    //we use no=>Struct object for the mapping of the structure that we create for the project


    string public name;
    //just like the metamask or ethereum address
    address public owner;


    modifier onlyOrganizer() {
        require(msg.sender == organizer);
        _;
    }
    mapping(string => Club[]) club;

    function createClub(
        string memory _name, //this is the category
        address _owner,
        string memory _title,
        string memory _desp,
        string memory _img,
        string memory _logo
    ) public onlyOrganizer returns (uint256) {
        club[_name].push(Club(_name,_owner,_title,_desp,club[_name].length,_img,_logo,0));
        //we give _(name_of_parameter) to separate the parameter only to this function

        //here we are creating an instance of the mapping of the particular Club
        //also being the storage, so directly the original data will be modified and not the separate copy of it

        //now putting a check that if the Club that is being created is having the correct deadline or not

        //if the require statement is true, then only it will proceed futher down here, else not.
        // club[_name][club[_name].length].owner = _owner;
        // club[_name][club[_name].length].title = _title;
        // club[_name][club[_name].length].description = _desp;
        //    Club[_name][club[_name].length()].club_id =club[_name].length() ;
        // Club.target = _target;
        // Club.deadline = _deadline;
        // Club.amtCollected=0; //as initially collected amount = 0
        // club[_name][club[_name].length].img = _img;
        // club[_name][club[_name].length].logo = _logo;
        // club[_name][club[_name].length].funds = 0;
        // club[_name].push(Club);
        // club[_name].length() = club[_name].length() + 1;
        return club[_name].length; //will return the index of the Club created
    }

    // we only have to get the id of the Club that will be given fund to
    function fundClub(string memory _cat_name, string memory _club_name)
        public
        payable
    {
        //payable -> signifies that we r going to send some cryptocurreny by this function
        uint256 amt = msg.value;
        uint8 no;
        //msg is actually the global variable in solidity with various available methods
        //msg.value->amt to be sent from frontend
        // Club storage Club = club[_id]; //accessing the particular Club
        for (uint8 i = 0; i < club[_cat_name].length; i++) {
            if (keccak256(abi.encodePacked(_club_name)) == keccak256(abi.encodePacked(club[_cat_name][i].title))){
                (bool sent, ) = payable(club[_cat_name][i].owner).call{value: amt}("");
                if(sent){
                    club[_cat_name][i].funds += amt;
                    no = i;
                }
            }
        }
    }

    struct Disp{
        string key;
        Club[] Clubs;
    }

    function getAllData() public view returns (Disp[] memory){
        string[3] memory cate_name = ["Technical","Cultural","Sports"];
        Disp[] memory disp = new Disp[](cate_name.length);

        for(uint8 i = 0; i < cate_name.length; i++){
            disp[i].key = cate_name[i];
            // Club[] memory clubs = new Club[](club[cate_name[i]].length);
            disp[i].Clubs = new Club[](club[cate_name[i]].length);
            for(uint8 j = 0; j < club[cate_name[i]].length; j++){
                // disp[i].Clubs.push(club[cate_name[i]][j]);
                disp[i].Clubs[j] = club[cate_name[i]][j];
            }
            
        }
        return disp;
    }
    // function getAllClubs()
}


// contract Owner is MyContract{
//   /* mapping field below is equivalent to an associative array or hash.
//   The key of the mapping is _event name stored as type bytes32 and value is
//   an unsigned integer to store the vote count
//   */

//   mapping (string=>mapping(Club=>mapping(string => uint8))) public votesReceived;

//   /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
//   We will use an array of bytes32 instead to store the list of _events
//   */

//   mapping(string=>mapping(Club=>string[])) public eventList;

//   /* This is the constructor which will be called once when you
//   deploy the contract to the blockchain. When we deploy the contract,
//   we will pass an array of _events who will be contesting in the election
//   */
//   function Voting (string memory _cat, Club memory _club, string[] memory eventNames) public {
//     eventList[_cat][Club] = eventNames;
//   }

//   // This function returns the total votes for an eventthe club has received so far
//   function totalVotesFor(string memory _event) public view returns (uint8) {
//     if (valid_event(_event) == false) revert();
//     return votesReceived[_event];
//   }

//   // This function increments the vote count for the specified _event. This
//   // is equivalent to casting a vote
//   function voteFor_event(string memory _event) public {
//     if (valid_event(_event) == false) revert();
//     votesReceived[_event] += 1;
//   }

//   function valid_event(string memory _event) public view returns (bool) {
//     for(uint i = 0; i < eventList.length; i++) {
//       if (keccak256(bytes(eventList[i])) == keccak256(bytes(_event))) {
//         return true;
//       }
//     }
//     return false;
//   }
// }




