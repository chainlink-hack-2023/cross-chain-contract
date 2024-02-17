const { ethers } = require('ethers');
const HUBSourceABI = require("./ABIs/HUBSource.abi.json")
const HUBDestinationABI = require("./ABIs/HUBDestination.abi.json")


const HUBSourceAddress = '0x95f0e48e5f8f946B742A7D5379906f8Fc04abb01';
const HUBDestinationAddress = '0x7742b2C9cca5E9558e93474be5f825dF6707B5c2';

const makerPrivateKey = ""
const takerPrivateKey = ""

const BlastSepoliaProvider = new ethers.providers.JsonRpcProvider('https://sepolia.blast.io');
// const SepoliaProvider = new ethers.providers.JsonRpcProvider('https://eth-sepolia.api.onfinality.io/public');
// const SepoliaProvider = new ethers.providers.JsonRpcProvider('https://ethereum-sepolia.publicnode.com');
const SepoliaProvider = new ethers.providers.JsonRpcProvider('https://ethereum-sepolia.blockpi.network/v1/rpc/public');

maker = new ethers.Wallet(makerPrivateKey, BlastSepoliaProvider);
taker = new ethers.Wallet(takerPrivateKey, SepoliaProvider);

console.log(`Maker address: ${maker.address}`);
console.log(`Taker address: ${taker.address}`);


const BlastSepoliaHUBSourceContract = new ethers.Contract(HUBSourceAddress, HUBSourceABI, maker);
const SepoliaHUBSourceContract = new ethers.Contract(HUBDestinationAddress, HUBDestinationABI, taker);

async function main() {

    setInterval(async () => {
        try {
            const BlastSepolia_WETH = "0x4200000000000000000000000000000000000023";
            const Sepolia_USDC = "0xbe72E441BF55620febc26715db68d3494213D8Cb";
            // order.makerToken = OPSepolia_WETH;
            // order.makerAmount = 0.00001 ether;
            // order.takerToken = Sepolia_USDC;
            // order.takerAmount = 0.2 ether;
            // order.maker = address(deployerAddress);
            // order.expiry = uint64(1800537678);
            // order.taker = address(0);
            // order.salt = 3;
            // order.targetChainId = 11155111;
            // order.target = address(deployerAddress);
            // order.permitSignature = _calldata;
            const slat = Date.now()
            console.log(`==> start create order at ${slat}`)
            const createOrderTransactionResponse  = await BlastSepoliaHUBSourceContract.createOrder({
                makerToken: BlastSepolia_WETH, 
                makerAmount: 0.00001*1e9,
                takerToken: Sepolia_USDC,
                takerAmount: ethers.BigNumber.from("1000000000"),
                maker: maker.address,
                expiry: 1800537678,
                taker: "0x0000000000000000000000000000000000000000",
                salt: slat,
                targetChainId: 11155111,
                target: maker.address,
                permitSignature: 0x0
            })
            console.log('wait for createOrder transaction receipt')
            const createOrderTransactionReceipt = await createOrderTransactionResponse.wait()

            // console.log(createOrderTransactionReceipt.logs)
            let orderHash = ""
            for(log of createOrderTransactionReceipt.logs) {
                if (log.topics[0] == "0x364bd8632407338200e67cbecb4a7ccac7010008895feb33cf1ab96f6f1ea7bf") {
                    orderHash = log.data.substring(0, 66)
                    console.log(`orderHash: ${orderHash}`)

                    console.log(`==> start fulfill order...`)
                    const _orderHash = orderHash;
                    const takerAmount = ethers.BigNumber.from("1000000000");
                    const takerAsset = Sepolia_USDC;
                    const sourceChainId = 11155420;
                    const maker = "0x3C53E585FDbDB1067B94985377582D7712dF4884";

                    const fulfillOrderTransactionResponse  = await SepoliaHUBSourceContract.fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId, maker);

                    console.log('wait for fulfillOrder transaction receipt')
                    const fulfillOrderTransactionReceipt = await fulfillOrderTransactionResponse.wait()
                    // console.log("fulfillOrderTransactionReceipt: ")
                    // console.log(fulfillOrderTransactionReceipt)
                    console.log("Order fulfilled!")
                }
            }
        } catch (error) {
            console.error('Error:', error);
            return 0;
        }
    }, 120*1000); // 5s
}   

main()