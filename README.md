# DApp For Crowd Funding
Simulates crowd funding money. Uses chainlink price feed to determine the conversion rate of fiat currency and Ethereum.
This project is being deployed on the Avalanche network. Other networks such as Goerli are also supported if desirable.
Project that shows how to make a crowd sourcing application that can understand pricing in USD using [Chainlink Price Feed](https://docs.chain.link/data-feeds).

# Usage

Deploy:

```
npx hardhat run scripts/deployFundMe.js
```

## Testing

```
npx hardhat test
```


# Deployment to a testnet or mainnet

1. Setup environment variables

You'll want to set your `GOERLI_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `GOERLI_RPC_URL`: This is url of the goerli testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some tesnet ETH. You should see the ETH show up in your metamask.

3. Deploy

```
npx hardhat run scripts/deployFundMe.js --network goerli
```
