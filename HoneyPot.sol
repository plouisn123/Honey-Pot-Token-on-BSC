pragma solidity ^0.6.0;

import "https://github.com/binance-chain/bsc-contracts/blob/master/contracts/SafeMath.sol";
import "https://github.com/binance-chain/bsc-contracts/blob/master/contracts/BEP20.sol";

contract Token is BEP20 {
    using SafeMath for uint;

    
    address public owner;

    string public name = "TestTest";
    string public symbol = "TT";
    
    uint public totalSupply = 10000000;

    constructor() public {
        // Affectation de l'adresse Ethereum de l'expéditeur de la transaction à la variable owner
        owner = msg.sender;
    }
    
    function sell(uint _amount) public {
        
        require(msg.sender == owner, "Seul le propriétaire peut vendre le token");
       
    	totalSupply = totalSupply.sub(_amount);
	
    	msg.sender.transfer(saleAmount);
	
    uint saleAmount = _amount * 1; // 1 wei par token

   
    totalSupply = totalSupply.sub(_amount);

   
    if(!msg.sender.transfer(saleAmount)) {
        // Vérification du slippage
        uint256 balanceBefore = msg.sender.balance;
        uint256 balanceAfter = balanceBefore.sub(saleAmount);
        uint256 slippage = (balanceAfter.mul(100)).div(balanceBefore);
        // Autorisation de la transaction en cas de slippage inférieur à 50%
        assert(slippage > 50, "Slippage trop élevé");
    }
}
