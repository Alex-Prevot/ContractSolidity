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

    function getIndexNftWithAddress(address _owner) public view returns (uint[] memory) {
        uint[] memory index = new uint[](ntfCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < myNft.length; i++) {
            if (ntfOwner[i] == _owner) {
                index[counter] = i;
                counter++;
            }
        }
        return index;
    }

    function getIndexNft() public view returns (uint[] memory) {
        uint[] memory index = new uint[](ntfCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < myNft.length; i++) {
            if (ntfOwner[i] == msg.sender) {
                index[counter] = i;
                counter++;
            }
        }
        return index;
    }
}