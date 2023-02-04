// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MyContract {
    string category;
    address organizer = msg.sender;
    struct Club {
        address owner;
        string title;
        string description;
        uint256 club_id;
        // uint256 target; //for the target amount that the campain wants to reach
        // uint256 deadline;
        // uint256 amtCollected;
        string img;
        string logo;
        uint256 funds; //amt of funds by organizer
    }

    //we use no=>Struct object for the mapping of the structure that we create for the project

    //all the functions for the this application that will be used
    // mapping(string=>uint256) cat_budget = {
    //     'technical' =
    // };

    string public name;
    //just like the metamask or ethereum address
    address public owner;

    //ACM -> Amount
    // mapping(string=>uint256) cat_budget;

    // modifier onlyBudget(string _name){
    //         require(msg.value <= cat_budget[Club[_name][]]);
    //         _;
    //     }
    // uint256 public noOfClubs = 0;

    modifier onlyOrganizer() {
        require(msg.sender == organizer);
        _;
    }
    // mapping(string => mapping(uint256 => Club[])) club;
    mapping(string => Club[]) club;

    //function allotBudget(uint256 _budget, uint256 _id) public onlyOrganizer{
    //    cat_budget[categories[_id]] = _budget;
    //}
    //this function should return the id of the specific Club
    function createClub(
        string memory _name, //this is the category
        address _owner,
        string memory _title,
        string memory _desp,
        string memory _img,
        string memory _logo,
        string memory _funds
    ) public onlyOrganizer returns (uint256) {
        //we give _(name_of_parameter) to separate the parameter only to this function

        //here we are creating an instance of the mapping of the particular Club
        //clubs -> dictionary of clubs based on the id -> eg) Club[3];
        // Club storage Club=club[_name][club[_name].length]; //creating the array of club
        //also being the storage, so directly the original data will be modified and not the separate copy of it

        //now putting a check that if the Club that is being created is having the correct deadline or not
        // require(Club.deadline < block.timestamp, "Deadline should be of future");

        //if the require statement is true, then only it will proceed futher down here, else not.
        club[_name][club[_name].length].owner = _owner;
        club[_name][club[_name].length].title = _title;
        club[_name][club[_name].length].description = _desp;
        //    Club[_name][club[_name].length()].club_id =club[_name].length() ;
        // Club.target = _target;
        // Club.deadline = _deadline;
        // Club.amtCollected=0; //as initially collected amount = 0
        club[_name][club[_name].length].img = _img;
        club[_name][club[_name].length].logo = _logo;
        club[_name][club[_name].length].funds = 0;
        // club[_name].push(Club);
        // club[_name].length() = club[_name].length() + 1;
        return club[_name].length; //will return the index of the Club created
    }

    // we only have to get the id of the Club that we want to donate to
    function fundClub(string memory _cat_name, string memory _club_name)
        public
        payable
    {
        //payable -> signifies that we r going to send some cryptocurreny by this function
        uint256 amt = msg.value;
        //msg is actually the global variable in solidity with various available methods
        //msg.value->amt to be sent from frontend
        // Club storage Club = club[_id]; //accessing the particular Club
        for (uint256 i = 0; i < club[_cat_name].length; i++) {
            if (keccak256(abi.encodePacked(_club_name)) == keccak256(abi.encodePacked(club[_cat_name][i].title))){
                club[_cat_name][i].funds = amt;
            }
        }

        //as we are sending the amount to owenr Club, so to confirm the transcation, bool sent has been used
        
    }
    function getAllclubs() public view returns (Club[] memory){
        //creating an empty array, that will be having the length of the noOfClubs created already or are existing.
        Club[] memory allclubs = new Club[](noOfClubs);

        //now, looping through them and populating it
        for(uint i=0;i<noOfClubs;i++){
            allclubs[i] = clubs[i];
        }
        return allclubs;
    }
}

