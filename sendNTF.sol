pragma solidity >=0.7.0 <0.9.0;

import "./NFT.sol";
import "./erc721.sol";

contract sendNft is mintNFT, ERC721 {

    mapping (uint => address) nftApprovals;

    modifier onlyOwnerOf(uint _NftId) {
        require(msg.sender == ntfOwner[_NftId]);
        _;
    }

    function balanceOf(address _owner) public override view returns (uint256 _balance) {
      return ntfCount[_owner];
    }

    function ownerOf(uint256 _NftId) public override view returns (address _owner) {
      return ntfOwner[_NftId];
    }

    function _transfer(address _from, address _to, uint _NftId) private {
      ntfCount[_to]++;
      ntfCount[_from]--;
      ntfOwner[_NftId] = _to;
    }

    function transfer(address _to, uint256 _NftId) public override onlyOwnerOf(_NftId) {
      _transfer(msg.sender, _to, _NftId);
    }

    function approve(address _to, uint256 _NftId) public override onlyOwnerOf(_NftId) {
        nftApprovals[_NftId] = _to;
    }

    function takeOwnership(uint256 _NftId) public override {
        require(nftApprovals[_NftId] == msg.sender);
        address owner = ownerOf(_NftId);
        _transfer(owner, msg.sender, _NftId);
    }
}