# cross-chain-contract

# Install Lib
```
forge install openzeppelin/openzeppelin-contracts@v4.9.3
npm install
```

# Env
```
Node: v16.18.1
npm: 9.6.6
forge 0.2.0 (08a629a 2023-06-03T00:14:26.563741000Z)
```



# Test
```
forge test -vvv
```

# Onchain Test Steps:
## CCIP onchain test steps:
1. Do Preparation at Fuji for maker (Approve Sender's FUJI_LINK to HUBSource and transfer enough FUJI_LINK to HUBSource)
2. Do Preparation at Mumbai for taker (Approve sender's MUMBAI_WETH to HUBDestination and transfer enough MUMBAI_LINK to HUBDestination)
3. Create Order at Fuji for maker
4. If parameters changed in CreateOrderAtFuji, get _orderHash from TX log and update the new _orderHash in FulfilOrderAtMumbai.s.sol
5. Fulfill Order at Mumbai for taker (If maker is different from *0x3C53E585FDbDB1067B94985377582D7712dF4884*, update the maker address at FulfilOrderAtMumbai.s.sol)
6. Check CCIP status at https://ccip.chain.link/ with fulfill order TX

## LYLX onchain test steps
1. Do Preparation at Goerli for maker (Approve Sender's GOERLI_USDC to HUBSource)
2. Do Preparation at ZkEVM for taker (Approve sender's ZkEVM_LINK to HUBDestination)
3. Create Order at ZkEVM for maker
4. If parameters changed in CreateOrderAtZkEVM, get _orderHash from TX log and update the new _orderHash in FulfilOrderAtGoerli.s.sol
5. Fulfill Order at Goerli for taker (If maker is different from *0x3C53E585FDbDB1067B94985377582D7712dF4884*, update the maker address at FulfilOrderAtGoerli.s.sol)
6. Check bridge status by https://bridge-api.public.zkevm-test.net/bridges/<HUDSource>
7. Claim by: `node ./script/ZkEVMClaimSource.js`

## Sepolia->OP Sepolia onchain test steps
1. Do Preparation at OPSepolia for maker (Approve Sender's OPSepolia_WETH to HUBSource)
2. Do Preparation at Sepolia for taker (Approve sender's Sepolia_USDC to HUBDestination)
3. Create Order at OPSepolia for maker
4. If parameters changed in CreateOrderAtOPSepolia, get _orderHash from TX log and update the new _orderHash in FulfilOrderAtSepolia.s.sol
5. Fulfill Order at Sepolia for taker (If maker is different from *0x3C53E585FDbDB1067B94985377582D7712dF4884*, update the maker address at FulfilOrderAtSepolia.s.sol)


# Deploy
## Deploy to Mumbai
```
export PRIVATE_KEY=
forge script script/DeployHUBToMumbai.s.sol:HUBScript --fork-url https://polygon-mumbai-bor.publicnode.com --broadcast --legacy
```
## Deploy Fuji
```
export PRIVATE_KEY=
forge script script/DeployHUBToFuji.s.sol:HUBScript --fork-url https://api.avax-test.network/ext/bc/C/rpc --broadcast --legacy
```
## Deploy ZkEVM
```
export PRIVATE_KEY=
forge script script/DeployHUBToZkEVM.s.sol:HUBScript --fork-url https://rpc.public.zkevm-test.net --broadcast --legacy
```
## Deploy Goerli
```
export PRIVATE_KEY=
forge script script/DeployHUBToGoerli.s.sol:HUBScript --fork-url https://rpc.ankr.com/eth_goerli --broadcast --legacy
```
## Deploy Sepolia
```
export PRIVATE_KEY=
forge script script/DeployHUBToSepolia.s.sol:HUBScript --fork-url https://eth-sepolia.api.onfinality.io/public --broadcast --legacy
```
## Deploy OPSepolia
```
export PRIVATE_KEY=
forge script script/DeployHUBToOPSepolia.s.sol:HUBScript --fork-url https://optimism-sepolia.blockpi.network/v1/rpc/public --broadcast --legacy
```

# Deploy Permit2 to PolygonZkEVM
Deploy from permit2 repo
```
export PRIVATE_KEY=
forge script --broadcast --rpc-url https://rpc.public.zkevm-test.net --private-key <Private key> script/DeployPermit2.s.sol:DeployPermit2
```

# Script
## Create Order at Fuji
```
export PRIVATE_KEY=
forge script script/CreateOrderAtFuji.s.sol:CreateOrderAtFujiScript --fork-url https://api.avax-test.network/ext/bc/C/rpc --broadcast --legacy
```

## Fulfill Order at Mumbai
```
export PRIVATE_KEY=
forge script script/FulfilOrderAtMumbai.s.sol:FulfilOrderAtMumbaiScript --fork-url https://polygon-mumbai-bor.publicnode.com --broadcast --legacy
```

## Create Order at Goerli
```
export PRIVATE_KEY=
forge script script/CreateOrderAtGoerli.s.sol:CreateOrderAtGoerliScript --fork-url https://rpc.ankr.com/eth_goerli --broadcast --legacy
```

## Fulfill Order at ZkEVM
```
export PRIVATE_KEY=
forge script script/FulfilOrderAtZkEVM.s.sol:FulfilOrderAtZkEVMScript --fork-url https://rpc.public.zkevm-test.net --broadcast --legacy
```


## Create Order at ZkEVM
```
export PRIVATE_KEY=
forge script script/CreateOrderAtZkEVM.s.sol:CreateOrderAtZkEVMScript --fork-url https://rpc.public.zkevm-test.net --broadcast --legacy
```

## Fulfill Order at Goerli
```
export PRIVATE_KEY=
forge script script/FulfilOrderAtGoerli.s.sol:FulfilOrderAtGoerliScript --fork-url https://rpc.ankr.com/eth_goerli --broadcast --legacy
```

## Create Order at OPSepolia
```
export PRIVATE_KEY=
forge script script/CreateOrderAtOPSepolia.s.sol:CreateOrderAtOPSepoliaScript --fork-url https://optimism-sepolia.blockpi.network/v1/rpc/public --broadcast --legacy
```

## Fulfill Order at Sepolia
```
export PRIVATE_KEY=
forge script script/FulfilOrderAtSepolia.s.sol:FulfilOrderAtSepoliaScript --fork-url https://eth-sepolia.api.onfinality.io/public --broadcast --legacy
```

## Token Approve at Fuji
```
export PRIVATE_KEY=
forge script script/TokenApprove.s.sol:TokenApproveScript --fork-url https://api.avax-test.network/ext/bc/C/rpc --broadcast --legacy
```

## Token Approve at Mumbai
```
export PRIVATE_KEY=
forge script script/TokenApprove.s.sol:TokenApproveScript --fork-url https://polygon-mumbai-bor.publicnode.com --broadcast --legacy
```

## Token Transfer at Fuji
```
export PRIVATE_KEY=
forge script script/TokenTransfer.s.sol:TokenTransferScript --fork-url https://api.avax-test.network/ext/bc/C/rpc --broadcast --legacy
```

## Token Transfer at Mumbai
```
export PRIVATE_KEY=
forge script script/TokenTransfer.s.sol:TokenTransferScript --fork-url https://polygon-mumbai-bor.publicnode.com --broadcast --legacy
```

## Preparation at Fuji
```
export PRIVATE_KEY=
forge script script/FujiPreparation.s.sol:FujiPreparationScript --fork-url https://api.avax-test.network/ext/bc/C/rpc --broadcast --legacy
```

## Preparation at Mumbai
```
export PRIVATE_KEY=
forge script script/MumbaiPreparation.s.sol:MumbaiPreparationScript --fork-url https://polygon-mumbai-bor.publicnode.com --broadcast --legacy
```

## Preparation at Goerli
```
export PRIVATE_KEY=
forge script script/GoerliPreparation.s.sol:GoerliPreparationScript --fork-url https://rpc.ankr.com/eth_goerli --broadcast --legacy
```

## Preparation at ZkEVM
```
export PRIVATE_KEY=
forge script script/ZkEVMPreparation.s.sol:ZkEVMPreparationScript --fork-url https://rpc.public.zkevm-test.net --broadcast --legacy
```

## Preparation at Sepolia
```
export PRIVATE_KEY=
forge script script/SepoliaPreparation.s.sol:SepoliaPreparationScript --fork-url https://eth-sepolia.api.onfinality.io/public --broadcast --legacy
```
## Preparation at OPSepolia
```
export PRIVATE_KEY=
forge script script/OPSepoliaPreparation.s.sol:OPSepoliaPreparationScript --fork-url https://optimism-sepolia.blockpi.network/v1/rpc/public --broadcast --legacy
```

## ExecuteMessageReceivedAtFuji
```
export PRIVATE_KEY=
forge script script/ExecuteMessageReceivedAtFuji.s.sol:ExecuteMessageReceivedAtFujiScript --fork-url https://api.avax-test.network/ext/bc/C/rpc --broadcast --legacy
```

## ExecuteMessageReceivedAtMumbai
```
export PRIVATE_KEY=
forge script script/ExecuteMessageReceivedAtMumbai.s.sol:ExecuteMessageReceivedAtMumbaiScript --fork-url https://polygon-mumbai-bor.publicnode.com --broadcast --legacy
```

## ExecuteMessageReceivedAtGoerli
```
export PRIVATE_KEY=
forge script script/ExecuteMessageReceivedAtGoerli.s.sol:ExecuteMessageReceivedAtGoerliScript --fork-url https://rpc.ankr.com/eth_goerli --broadcast --legacy
```
## ExecuteMessageReceivedAtZkEVM
```
export PRIVATE_KEY=
forge script script/ExecuteMessageReceivedAtZkEVM.s.sol:ExecuteMessageReceivedAtZkEVMScript --fork-url https://rpc.public.zkevm-test.net --broadcast --legacy
```
## ExecuteMessageReceivedAtOPSepolia
```
export PRIVATE_KEY=
forge script script/ExecuteMessageReceivedAtOPSepolia.s.sol:ExecuteMessageReceivedAtOPSepoliaScript --fork-url https://optimism-sepolia.blockpi.network/v1/rpc/public --broadcast --legacy
```

## Status Check at OPSepolia
```
forge script script/OPSepoliaStatusCheck.s.sol:OPSepoliaStatusCheckScript --fork-url https://optimism-sepolia.blockpi.network/v1/rpc/public --legacy -vvv
```

# Contract address in frontend
https://github.com/sydweb3/cow-sdk/blob/main/networks.json



# Deployed Contracts
## HUB Version15
### Mumbai
```
  deployed HUBSource Address:
  0x4d69742D8a6b38b30FB4A430A564F47e718a40EB
  deployed HUBDestination Address:
  0xd6a85f08863aAC58CbcAcD337b513a7534C10F6E
```
### Fuji
```
  deployed HUBSource Address:
  0x4d69742D8a6b38b30FB4A430A564F47e718a40EB
  deployed HUBDestination Address:
  0xd6a85f08863aAC58CbcAcD337b513a7534C10F6E
```
### ZkEVM
```
  deployed HUBSource Address:
  0x4d69742D8a6b38b30FB4A430A564F47e718a40EB
  deployed HUBDestination Address:
  0xd6a85f08863aAC58CbcAcD337b513a7534C10F6E
```
### Goerli
```
  deployed HUBSource Address:
  0x4d69742D8a6b38b30FB4A430A564F47e718a40EB
  deployed HUBDestination Address:
  0xd6a85f08863aAC58CbcAcD337b513a7534C10F6E
```
## HUB Version17
### Mumbai
```
  deployed HUBSource Address:
  0x7D573068bA00964A7Cc7C9E36380E494d406F381
  deployed HUBDestination Address:
  0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F
```
### Fuji
```
  deployed HUBSource Address:
  0x7D573068bA00964A7Cc7C9E36380E494d406F381
  deployed HUBDestination Address:
  0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F
```
### ZkEVM
```
  deployed HUBSource Address:
  0x48cba1C2fF4335484a0f95Cd87743A7B0b41e0a4
  deployed HUBDestination Address:
  0x5461EdFc4dD52cF348Ae0284619BE5353158f774
```
### Goerli
```
  deployed HUBSource Address:
  0x48cba1C2fF4335484a0f95Cd87743A7B0b41e0a4
  deployed HUBDestination Address:
  0x5461EdFc4dD52cF348Ae0284619BE5353158f774
```
## HUB Version18
### Mumbai
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### Fuji
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### ZkEVM
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### Goerli
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
## HUB Version18
### Mumbai
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### Fuji
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### ZkEVM
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### Goerli
```
  deployed HUBSource Address:
  0x2db63ba5F9101F5017a33922AE1c3C329e516625
  deployed HUBDestination Address:
  0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E
```
### Sepolia
```
  deployed HUBSource Address:
  0x7bF9b7d581e33BFbf047db57dd5b3722ef31eD78
  deployed HUBDestination Address:
  0x396b6B1EDCc46F104D97D6fABE806C97c1dB273D
```
### OPSepolia
```
  deployed HUBSource Address:
  0x7bF9b7d581e33BFbf047db57dd5b3722ef31eD78
  deployed HUBDestination Address:
  0x396b6B1EDCc46F104D97D6fABE806C97c1dB273D
```

## HUB Version19
### Sepolia
```
  deployed HUBSource Address:
  0x11Ad41e37a4a5354e6660A344373F9c6c30Faff2
  deployed HUBDestination Address:
  0x2d7FF7ED9ad1eb27e4f05C08b10752c981860292
```
### OPSepolia
```
  deployed HUBSource Address:
  0x11Ad41e37a4a5354e6660A344373F9c6c30Faff2
  deployed HUBDestination Address:
  0x2d7FF7ED9ad1eb27e4f05C08b10752c981860292
```

## HUB Version20
### Sepolia
```
  deployed HUBSource Address:
  0x0ec146c8cf1bA19c809b8c9c1FC8F2f598a053A9
  deployed HUBDestination Address:
  0x50C275d455F77ef5BBB144067d9BA02bd55Be1e3
```
### OPSepolia
```
  deployed HUBSource Address:
  0x0ec146c8cf1bA19c809b8c9c1FC8F2f598a053A9
  deployed HUBDestination Address:
  0x50C275d455F77ef5BBB144067d9BA02bd55Be1e3
```
## HUB Version21
### Mumbai
```
  deployed HUBSource Address:
  0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1
  deployed HUBDestination Address:
  0xAC639a69B329A01E727188f8d90ECeA3f6189243
```
### Fuji
```
  deployed HUBSource Address:
  0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1
  deployed HUBDestination Address:
  0xAC639a69B329A01E727188f8d90ECeA3f6189243
```
### ZkEVM
```
  deployed HUBSource Address:
  0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1
  deployed HUBDestination Address:
  0xAC639a69B329A01E727188f8d90ECeA3f6189243
```
### Goerli
```
  deployed HUBSource Address:
  0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1
  deployed HUBDestination Address:
  0xAC639a69B329A01E727188f8d90ECeA3f6189243
```
### Sepolia
```
  deployed HUBSource Address:
  0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1
  deployed HUBDestination Address:
  0xAC639a69B329A01E727188f8d90ECeA3f6189243
```
### OPSepolia
```
  deployed HUBSource Address:
  0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1
  deployed HUBDestination Address:
  0xAC639a69B329A01E727188f8d90ECeA3f6189243
```
