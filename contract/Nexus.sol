// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title Nexus Token (NXS)
 * @dev Fungible ERC20 token for the NexusLabs ecosystem.
 */
contract Nexus is ERC20, ERC20Burnable, Ownable {
    using SafeERC20 for IERC20;
    uint256 public constant TOTAL_SUPPLY = 500_000_000_000 * (10**18);

    constructor(
        address initialOwner,
        address treasuryAddress,
        address rewardsAddress,
        address liquidityAddress,
        address teamAddress,
        address marketingAddress
    )
        ERC20("Nexus", "NXS")
        Ownable(initialOwner)
    {
        require(treasuryAddress != address(0), "NXS: Treasury address cannot be zero");
        require(rewardsAddress != address(0), "NXS: Rewards address cannot be zero");
        require(liquidityAddress != address(0), "NXS: Liquidity address cannot be zero");
        require(teamAddress != address(0), "NXS: Team address cannot be zero");
        require(marketingAddress != address(0), "NXS: Marketing address cannot be zero");

        _mint(address(this), TOTAL_SUPPLY);
        uint256 rewardsSupply = (TOTAL_SUPPLY * 40) / 100;
        _transfer(address(this), rewardsAddress, rewardsSupply);
        uint256 treasurySupply = (TOTAL_SUPPLY * 20) / 100;
        _transfer(address(this), treasuryAddress, treasurySupply);
        uint256 liquiditySupply = (TOTAL_SUPPLY * 15) / 100;
        _transfer(address(this), liquidityAddress, liquiditySupply);
        uint256 teamSupply = (TOTAL_SUPPLY * 15) / 100;
        _transfer(address(this), teamAddress, teamSupply);
        uint256 marketingSupply = (TOTAL_SUPPLY * 10) / 100;
        _transfer(address(this), marketingAddress, marketingSupply);

        uint256 dust = balanceOf(address(this));
        if (dust > 0) {
            _transfer(address(this), treasuryAddress, dust);
        }
    }

    function decimals() public view virtual override(ERC20) returns (uint8) {
        return 18;
    }

    function rescueTokens(address tokenAddress, address to, uint256 amount) external onlyOwner {
        require(to != address(0), "NXS: Rescue address cannot be zero");
        require(amount > 0, "NXS: Rescue amount must be greater than zero");
        IERC20 token = IERC20(tokenAddress);
        token.safeTransfer(to, amount);
    }
}
