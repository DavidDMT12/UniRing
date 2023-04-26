// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";
import "./ERC721Metadata.sol";
import "./ERC721Enumerable.sol";
//import "./Strings.sol";


contract UniRing is ERC721Enumerable {
    //RAW     https://raw.githubusercontent.com/l-m-s/UniRing/main/json/Ring_Bas_02.json
    string public constant BASE_URI ="https://raw.githubusercontent.com/l-m-s/UniRing/main/json/";
    // array to stored Rings 
    string [] public UniRings;
    uint internal nftAcounter;
    // add this Ring_Bas_02.json for metadata
    //authority address of rings 
    address private ringAuthority;
    address public ringNFTAdrress;
    string public studentName;
    uint256 public issueDate;
    string [] private yearBook; //array of stored messages

    mapping(string => bool) _UniRingsExists;
    
    constructor() ERC721("UniRing", "URNG") {
        ringNFTAdrress = tx.origin;
        nftAcounter = 0;
        ringAuthority = _msgSender();
    }

    function mint(string memory _UniRing, string memory _studentName) public onlyRingAuthority{
        require(!_UniRingsExists[_UniRing],"Error - Ring already exists");
        studentName = _studentName;
        issueDate = block.timestamp;

        // this is deprecated - uint _id = UniRingz.push(_UniRing);
        UniRings.push(_UniRing);
        nftAcounter += 1 ;
        uint _id = UniRings.length - 1;
        
        //save sending with _msgSender
        _mint(_msgSender(), _id);
        _UniRingsExists[_UniRing] = true;
    }

    function setRingAuthority(address _ringAuthority) public onlyRingAuthority{
        ringAuthority = _ringAuthority;

    }
    
    function getName() public view returns(string memory){
        return studentName;
    }

    function setRingAuthority() public view returns (address){
        return ringAuthority;
    }


    function addYearBook(string memory input) public onlyRingHolder {
        yearBook.push(input);

    }

    function getYearBookSize() public view returns (uint256){
    return yearBook.length - 1;
    }

    //gets entries from the yearbook
    function getYearBook(uint _spot) public view returns (string memory) {
         return yearBook[_spot];
    }   
    
    //GetsURI for the token, to be used by opensea
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent Ring");
        return UniRings[tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return nftAcounter;
    }

    //Modifiers for the functions
    modifier onlyRingAuthority {
        require(_msgSender() == ringAuthority,"Error - only RingAuthority can do this");
            _;
   }

    modifier onlyRingHolder{
        require(_balances[_msgSender()] > 0,"Error - only Ring holder can do this");
            _;
    }

}
