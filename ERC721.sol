// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ERC721Example is ERC721 {

    using Strings for uint256;

    uint256 public maxSupply=5;
    uint256 public counter = 0;
    address private  owner;

    modifier avaialbeMint(uint256 amount) {
        require(amount + counter <= maxSupply, "over max supply.");
        _;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    constructor() ERC721("PandaNFT", "PDN"){
        owner=msg.sender;
    }
    
    function tokenURI(uint256 tokenId) public pure  override returns (string memory) {
        return string(abi.encodePacked("https://chocolate-quick-snipe-356.mypinata.cloud/ipfs/QmeK1oAru6eF9Vjvzor8sFsGsYS5JwWgouGxJ5uw4faetM/",tokenId.toString(), ".json"));
    }

    function mint (uint256 amount) external avaialbeMint(amount){
       for(uint256 i=0; i < amount ; i++){
            _mint(msg.sender, counter);
            counter ++ ;
       }
    }
}