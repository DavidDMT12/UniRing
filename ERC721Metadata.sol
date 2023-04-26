/*
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IERC721Metadata.sol";
// deleted import "./ERC165.sol";

abstract contract ERC721Metadata is IERC721Metadata {

    string private _name;
    string private _symbol;
    string private _URLPart; //TODO Problem with URI

    constructor(string memory named, string memory symbolNFT) {
        _name = named;
        _symbol = symbolNFT;
    }

    function name() external view override returns(string memory) {
        return _name;
    }

    function symbol() external view override returns(string memory) {
    return _symbol;
    }
    /* 
    //TODO: using this or not  
    function tokenURI(uint256 _tokenId) external view returns (string memory){
        return __URLPart;
    }
    // Achtung add * /
}
/*
implement this here ?
function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }
**/