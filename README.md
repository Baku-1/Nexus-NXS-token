# Nexus Token (NXS)

The official utility and governance token for the NexusLabs ecosystem, powering a suite of interconnected games and decentralized applications on the Ronin blockchain.

## Features

- ERC20, burnable, Ownable, safe allocation and rescue function.
- 500,000,000,000 total supply, fixed at deployment.
- Initial tokenomics allocation (see `Nexus.sol`).
- Metadata in `token.json`.

## Setup

1. Clone this repo
2. Install dependencies

   ```bash
   npm install
   ```

3. Compile

   ```bash
   npx hardhat compile
   ```

4. Deploy

   ```bash
   npx hardhat run scripts/deploy.js --network <network>
   ```

5. Update the addresses in `deploy.js` before deploying.

## License

MIT
