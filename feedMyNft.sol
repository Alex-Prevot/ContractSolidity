pragma solidity >=0.7.0 <0.9.0;

import "./createNFT.sol";

contract feedMyNft is mintNFT {

    uint levelFee = 0.000001 ether;

    function _timeIsGood(myNFT storage _nft) internal view returns (bool) {
        return (_nft.ToFeed <= block.timestamp); 
    }

    function feedMe(uint _nftId) external payable {
        myNFT storage _nft = myNft[_nftId];
        // require(msg.value == levelFee);
        require(_timeIsGood(_nft));
        myNft[_nftId].level++;
    }
}