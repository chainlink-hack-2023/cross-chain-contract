/* eslint-disable no-await-in-loop */
/* eslint-disable no-console, no-inner-declarations, no-undef, import/no-unresolved */

const { ethers } = require('ethers');
const PolygonZkEVMBridgeABI = require("./ABIs/PolygonZkEVMBridge.abi.json")

const testnetBridgeAddress = '0xF6BEEeBB578e214CA9E23B0e9683454Ff88Ed2A7';

const mekrleProofString = '/merkle-proof';
const getClaimsFromAcc = '/bridges/';

const HUBSource = "0x7D573068bA00964A7Cc7C9E36380E494d406F381"


async function main() {
    const ZkEVMProvider = new ethers.providers.JsonRpcProvider('https://rpc.public.zkevm-test.net');
    // const ZkEVMProvider = new ethers.providers.JsonRpcProvider('https://rpc.ankr.com/eth_goerli');
    let deployer;
    if (process.env.PRIVATE_KEY) {
        deployer = new ethers.Wallet(process.env.PRIVATE_KEY, ZkEVMProvider);
        console.log('Using pvtKey deployer with address: ', deployer.address);
    } else {
        console.log("Please provide the PRIVATE_KEY!")
    }

    let zkEVMBridgeContractAddress = testnetBridgeAddress; 
    let baseURL = 'https://bridge-api.public.zkevm-test.net';

    const axios = require('axios').create({
        baseURL,
    });

    const bridgeContractZkeVM = new ethers.Contract(zkEVMBridgeContractAddress, PolygonZkEVMBridgeABI, deployer);

    const depositAxions = await axios.get(getClaimsFromAcc + HUBSource, { params: { limit: 100, offset: 0 } });
    const depositsArray = depositAxions.data.deposits;

    if (depositsArray.length === 0) {
        console.log('Not ready yet!');
        return;
    }

    for (let i = 0; i < depositsArray.length; i++) {
        const currentDeposit = depositsArray[i];
        if (currentDeposit.ready_for_claim && (currentDeposit.claim_tx_hash === "")) {
            const proofAxios = await axios.get(mekrleProofString, {
                params: { deposit_cnt: currentDeposit.deposit_cnt, net_id: currentDeposit.orig_net },
            });

            const { proof } = proofAxios.data;
            const claimTx = await bridgeContractZkeVM.claimMessage(
                proof.merkle_proof,
                currentDeposit.deposit_cnt,
                proof.main_exit_root,
                proof.rollup_exit_root,
                currentDeposit.orig_net,
                currentDeposit.orig_addr,
                currentDeposit.dest_net,
                currentDeposit.dest_addr,
                currentDeposit.amount,
                currentDeposit.metadata,
            {
                gasLimit: 1000000
            });
            console.log('claim message succesfully send: ', claimTx.hash);
            await claimTx.wait();
            console.log('claim message succesfully mined');
        } else {
            console.log('bridge not ready for claim');
        }
    }
}

main().catch((e) => {
    console.error(e);
    process.exit(1);
});