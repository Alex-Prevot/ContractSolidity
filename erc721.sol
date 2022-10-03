pragma solidity >=0.7.0 <0.9.0;

abstract contract ERC721 {
    function balanceOf(address _owner) public virtual view returns (uint256 _balance);
    function ownerOf(uint256 _tokenId) public virtual view returns (address _owner);
    function transfer(address _to, uint256 _tokenId) public virtual;
    function approve(address _to, uint256 _tokenId) public virtual;
    function takeOwnership(uint256 _tokenId) public virtual;
}
