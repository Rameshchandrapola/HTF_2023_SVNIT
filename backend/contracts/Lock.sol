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

    



    string public name;

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
        return club[_name].length; 
    }

    function fundClub(string memory _cat_name, string memory _club_name)
        public
        payable
    {
        uint256 amt = msg.value;
        uint8 no;
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
            disp[i].Clubs = new Club[](club[cate_name[i]].length);
            for(uint8 j = 0; j < club[cate_name[i]].length; j++){
                disp[i].Clubs[j] = club[cate_name[i]][j];
            }
            
        }
        return disp;
    }
}





