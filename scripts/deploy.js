const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  const Nexus = await hre.ethers.getContractFactory("Nexus");
  const nexus = await Nexus.deploy(
    deployer.address,                // initialOwner
    "0xYourTreasury",                // treasuryAddress
    "0xYourRewards",                 // rewardsAddress
    "0xYourLiquidity",               // liquidityAddress
    "0xYourTeam",                    // teamAddress
    "0xYourMarketing"                // marketingAddress
  );

  await nexus.deployed();
  console.log("Nexus deployed to:", nexus.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
