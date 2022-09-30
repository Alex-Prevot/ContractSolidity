pragma solidity >=0.7.0 <0.9.0;

// create nft with name, id, level, Tofeed
// id generation random with kecak and with name
// function by for level up and timing only 5min to feed
// echange de ntf

contract mintNFT {

    uint idDigits = 16;
    uint idMod = 10 ** idDigits;
    // uint cooldownTime = 1 minutes;
    uint cooldownTime = 1;

    struct myNFT {
        string name;
        uint id;
        uint32 level;
        uint32 ToFeed;
    }

    myNFT[] public myNft;

    mapping (uint => address) public ntfOwner;
    mapping (address => uint) ntfCount;

    function _pushNft(string memory _name, uint _id) private {
        myNft.push(myNFT(_name, _id, 1, uint32(block.timestamp + cooldownTime)));
        uint index = myNft.length - 1;
        ntfOwner[index] = msg.sender;
        ntfCount[msg.sender]++;
    }

    function _createIdNft(string memory _name) private view returns (uint) {
        uint id = uint(keccak256(abi.encodePacked(_name)));
        return id % idMod;
    }

    function createNft(string memory _name) public {
        require(ntfCount[msg.sender] == 0);
        uint id = _createIdNft(_name);
        _pushNft(_name, id);
    }
}