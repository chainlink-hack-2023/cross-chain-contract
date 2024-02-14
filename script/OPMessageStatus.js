const optimism = require("@eth-optimism/sdk")
const ethers = require("ethers")

const privateKey = process.env.PRIVATE_KEY

const transactionHash = "0xb9038cf2da797be046f1838afbfb7dfaad557f7946c04bde538f8724777a1745"

const l1Provider = new ethers.providers.StaticJsonRpcProvider("https://rpc.ankr.com/eth_sepolia")
const l2Provider = new ethers.providers.StaticJsonRpcProvider("https://sepolia.optimism.io")
const l1Wallet = new ethers.Wallet(privateKey, l1Provider)
const l2Wallet = new ethers.Wallet(privateKey, l2Provider)

async function main() {
    const messenger = new optimism.CrossChainMessenger({
        l1ChainId: 11155111, // 11155111 for Sepolia, 1 for Ethereum
        l2ChainId: 11155420, // 11155420 for OP Sepolia, 10 for OP Mainnet
        l1SignerOrProvider: l1Wallet,
        l2SignerOrProvider: l2Wallet,
      })
    console.log("status:")
    console.log(await messenger.waitForMessageStatus(transactionHash, optimism.MessageStatus.READY_TO_PROVE))
}

main()


