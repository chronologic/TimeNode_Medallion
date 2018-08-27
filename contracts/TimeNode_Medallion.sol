pragma solidity 0.4.24;

import "ico-by-tosh/contracts/DayToken.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";

contract TimeNode_Medallion is ERC721Token {

    address public constant DAY_TOKEN = 0xE814aeE960a85208C3dB542C53E7D4a6C8D5f60F;

    uint256 public  nextTokenId = 0;

    mapping(uint256 => address) ownerOfTokensByMedallionId;

    constructor()
        ERC721Token("TimeNode_Medallion", "TNM") {}

    function createMedallion()
        public returns (bool)
    {
        DayToken dayToken = DayToken(DAY_TOKEN);
        require(
            dayToken.transferFrom(msg.sender, address(this), 333 * uint256(dayToken.decimals()))
        );

        _mint(msg.sender, nextTokenId);
        nextTokenId += 1;

        ownerOfTokensByMedallionId[nextTokenId - 1] = msg.sender;

        return true;
    }
    
    function destroyMedallion(uint256 _tokenId)
        public returns (bool)
    {
        address ownerOfTokens = ownerOfTokensByMedallionId[_tokenId];
        DayToken dayToken = DayToken(DAY_TOKEN);

        require(
            dayToken.transfer(ownerOfTokens, 333 * uint256(dayToken.decimals()))
        );

        _burn(msg.sender, _tokenId);
        return true;
    }
}
