// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract MyContract {
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

    // function getAllData() public view returns (Disp[] memory){
         
    //     Disp[] storage Disps = new Disp[](3);

    //     // for(string key in)
    //     // {
    //     //     Disps[i].key=key;
    //     //     for(uint j=0;j<club[key].length;j++){
    //     //         Disps[i].Club.push(club[key][j]);
    //     //     }
    //     // }
    //     return Disps;
    // }
}