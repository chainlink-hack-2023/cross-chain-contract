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
1. Do Preparation at Sepolia for maker (Approve Sender's Sepolia_USDC to HUBSource)
2. Do Preparation at OPSepolia for taker (Approve sender's OPSepolia_WETH to HUBDestination)
3. Create Order at Sepolia for maker
4. If parameters changed in CreateOrderAtSepolia, get _orderHash from TX log and update the new _orderHash in FulfilOrderAtOPSepolia.s.sol
5. Fulfill Order at OPSepolia for taker (If maker is different from *0x3C53E585FDbDB1067B94985377582D7712dF4884*, update the maker address at FulfilOrderAtGoerli.s.sol)


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
forge script script/DeployHUBToSepolia.s.sol:HUBScript --fork-url https://sepolia.gateway.tenderly.co --broadcast --legacy
```
## Deploy OPSepolia
```
export PRIVATE_KEY=
forge script script/DeployHUBToOPSepolia.s.sol:HUBScript --fork-url https://sepolia.optimism.io --broadcast --legacy
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

## Create Order at Sepolia
```
export PRIVATE_KEY=
forge script script/CreateOrderAtSepolia.s.sol:CreateOrderAtSepoliaScript --fork-url https://sepolia.gateway.tenderly.co --broadcast --legacy
```

## Fulfill Order at OPSepolia
```
export PRIVATE_KEY=
forge script script/FulfilOrderAtOPSepolia.s.sol:FulfilOrderAtOPSepoliaScript --fork-url https://sepolia.optimism.io --broadcast --legacy
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
forge script script/SepoliaPreparation.s.sol:SepoliaPreparationScript --fork-url https://sepolia.gateway.tenderly.co --broadcast --legacy
```
## Preparation at OPSepolia
```
export PRIVATE_KEY=
forge script script/OPSepoliaPreparation.s.sol:OPSepoliaPreparationScript --fork-url https://sepolia.optimism.io --broadcast --legacy
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


# Contract address in frontend
https://github.com/sydweb3/cow-sdk/blob/main/networks.json



# Deployed Contracts
## HUB Version1
```
Mumbai: 0xabde11230d6fbe5d9a6e4b8dae791feeee760367
Fuji: 0xf770e009ec3af5c103f868509284b87bca08ed77
```
## HUB Version2
### Mumbai
```
deployed _HUBSourceAddress:
0xa3a1eD665F5E0766A719c236c93554B0255B69B5
deployed _HUBDestinationAddress:
0x4c1f94Ccb77Fc3393250c0f9e5D1cB16BD997e4b
```
## HUB Version3
### Mumbai
```
deployed HUBSource Address:
0x55C4A21c42859a0f15dAa2C25f6e67617c13930E
deployed HUBDestination Address:
0x352C8AD43Fb9f0Da22559A3589D1BF9B72fbA4c6
```
### Fuji
```
deployed HUBSource Address:
0x55C4A21c42859a0f15dAa2C25f6e67617c13930E
deployed HUBDestination Address:
0x352C8AD43Fb9f0Da22559A3589D1BF9B72fbA4c6
```
### ZkEVM
```
deployed HUBSource Address:
0x55C4A21c42859a0f15dAa2C25f6e67617c13930E
deployed HUBDestination Address:
0x352C8AD43Fb9f0Da22559A3589D1BF9B72fbA4c6
```
### Goerli
```
deployed HUBSource Address:
0x55C4A21c42859a0f15dAa2C25f6e67617c13930E
deployed HUBDestination Address:
0x352C8AD43Fb9f0Da22559A3589D1BF9B72fbA4c6
```
## HUB Version4
### Mumbai
```
  deployed HUBSource Address:
  0x645057AFFc4e1EA858DeaE1baCbdB1Ff8c15cf17
  deployed HUBDestination Address:
  0x1C7ddf40b4Fb3160927AD43CCbE628954B650945
```
### Fuji
```
  deployed HUBSource Address:
  0x645057AFFc4e1EA858DeaE1baCbdB1Ff8c15cf17
  deployed HUBDestination Address:
  0x1C7ddf40b4Fb3160927AD43CCbE628954B650945
```
### ZkEVM
```
  deployed HUBSource Address:
  0x645057AFFc4e1EA858DeaE1baCbdB1Ff8c15cf17
  deployed HUBDestination Address:
  0x1C7ddf40b4Fb3160927AD43CCbE628954B650945
```
### Goerli
```
  deployed HUBSource Address:
  0x645057AFFc4e1EA858DeaE1baCbdB1Ff8c15cf17
  deployed HUBDestination Address:
  0x1C7ddf40b4Fb3160927AD43CCbE628954B650945
```
## HUB Version5
### Mumbai
```
  deployed HUBSource Address:
  0x9b65F4c28dF06f700660466faCbD74d887a500c3
  deployed HUBDestination Address:
  0x6D068261D12E11E2459C9Cf30127CA49B82834d7
```
### Fuji
```
  deployed HUBSource Address:
  0x9b65F4c28dF06f700660466faCbD74d887a500c3
  deployed HUBDestination Address:
  0x6D068261D12E11E2459C9Cf30127CA49B82834d7
```
### ZkEVM
```
  deployed HUBSource Address:
  0x9b65F4c28dF06f700660466faCbD74d887a500c3
  deployed HUBDestination Address:
  0x6D068261D12E11E2459C9Cf30127CA49B82834d7
```
### Goerli
```
  deployed HUBSource Address:
  0x9b65F4c28dF06f700660466faCbD74d887a500c3
  deployed HUBDestination Address:
  0x6D068261D12E11E2459C9Cf30127CA49B82834d7
```
## HUB Version6
### Mumbai
```
  deployed HUBSource Address:
  0xaC45d2a7B4AAe6a844b6Ca62e9d2E45638349613
  deployed HUBDestination Address:
  0x1C47AA5527dcfBD7563cd3A875227DdC091914d7
```
### Fuji
```
  deployed HUBSource Address:
  0xaC45d2a7B4AAe6a844b6Ca62e9d2E45638349613
  deployed HUBDestination Address:
  0x1C47AA5527dcfBD7563cd3A875227DdC091914d7
```
### ZkEVM
```
  deployed HUBSource Address:
  0xaC45d2a7B4AAe6a844b6Ca62e9d2E45638349613
  deployed HUBDestination Address:
  0x1C47AA5527dcfBD7563cd3A875227DdC091914d7
```
### Goerli
```
  deployed HUBSource Address:
  0xaC45d2a7B4AAe6a844b6Ca62e9d2E45638349613
  deployed HUBDestination Address:
  0x1C47AA5527dcfBD7563cd3A875227DdC091914d7
```
## HUB Version7
### Mumbai
```
  deployed HUBSource Address:
  0x807A36fa511FcA74f9AdFeaBbC751bB6bb056a3b
  deployed HUBDestination Address:
  0x90dCb62b3A118333EB5F1A28DA2d114c366B0434
```
### Fuji
```
  deployed HUBSource Address:
  0x807A36fa511FcA74f9AdFeaBbC751bB6bb056a3b
  deployed HUBDestination Address:
  0x90dCb62b3A118333EB5F1A28DA2d114c366B0434
```
## HUB Version8
### Mumbai
```
  deployed HUBSource Address:
  0xbc86a4F1141bDE9E813903a166f2c9759322E5C6
  deployed HUBDestination Address:
  0x2356CA142e276B7049a093Ed6b19667E42afB45f
```
### Fuji
```
  deployed HUBSource Address:
  0xbc86a4F1141bDE9E813903a166f2c9759322E5C6
  deployed HUBDestination Address:
  0x2356CA142e276B7049a093Ed6b19667E42afB45f
```
## HUB Version9
### Mumbai
```
  deployed HUBSource Address:
  0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12
  deployed HUBDestination Address:
  0x33368768922E11EbBbC08Af958aC9ca3171A62b6
```
### Fuji
```
  deployed HUBSource Address:
  0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12
  deployed HUBDestination Address:
  0x33368768922E11EbBbC08Af958aC9ca3171A62b6
```
## HUB Version10
### Mumbai
```
  deployed HUBSource Address:
  0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12
  deployed HUBDestination Address:
  0x414d60E05439816B6F04bB6D326403B4799013b0
```
### Fuji
```
  deployed HUBSource Address:
  0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12
  deployed HUBDestination Address:
  0x414d60E05439816B6F04bB6D326403B4799013b0
```
### ZkEVM
```
  deployed HUBSource Address:
  0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12
  deployed HUBDestination Address:
  0x414d60E05439816B6F04bB6D326403B4799013b0
```
### Goerli
```
  deployed HUBSource Address:
  0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12
  deployed HUBDestination Address:
  0x414d60E05439816B6F04bB6D326403B4799013b0
```
## HUB Version11
### ZkEVM
```
  deployed HUBSource Address:
  0xF559789b2ADeD227167fd21565b551cB7C858A41
  deployed HUBDestination Address:
  0x4731e98235FC2660Cfdd489CE864C703b9E73FEc
```
### Goerli
```
  deployed HUBSource Address:
  0xF559789b2ADeD227167fd21565b551cB7C858A41
  deployed HUBDestination Address:
  0x4731e98235FC2660Cfdd489CE864C703b9E73FEc
```
## HUB Version12 (ZKEVM PING MESSAGE)
### ZkEVM
```
  deployed HUBSource Address:
  0xd85e84BD9dF29e9cD10e06ac16dfbdC17426794E
  deployed HUBDestination Address:
  0x70a948027D14756768915d87142dF48d17876b15
```
### Goerli
```
  deployed HUBSource Address:
  0xd85e84BD9dF29e9cD10e06ac16dfbdC17426794E
  deployed HUBDestination Address:
  0x70a948027D14756768915d87142dF48d17876b15
```
## HUB Version13
### Mumbai
```
  deployed HUBSource Address:
  0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85
  deployed HUBDestination Address:
  0xd28daF64BF29C91380978132a5F3A94f6D58fd57
```
### Fuji
```
  deployed HUBSource Address:
  0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85
  deployed HUBDestination Address:
  0xd28daF64BF29C91380978132a5F3A94f6D58fd57
```
### ZkEVM
```
  deployed HUBSource Address:
  0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85
  deployed HUBDestination Address:
  0xd28daF64BF29C91380978132a5F3A94f6D58fd57
```
### Goerli
```
  deployed HUBSource Address:
  0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85
  deployed HUBDestination Address:
  0xd28daF64BF29C91380978132a5F3A94f6D58fd57
```
## HUB Version14
### Mumbai
```
  deployed HUBSource Address:
  0xf57c41302BbD709F1E3eAa154E7Cc4C361671f7e
  deployed HUBDestination Address:
  0xE1029eba9600E093f0A83601882d47a8Ecf5af03
```
### Fuji
```
  deployed HUBSource Address:
  0xf57c41302BbD709F1E3eAa154E7Cc4C361671f7e
  deployed HUBDestination Address:
  0xE1029eba9600E093f0A83601882d47a8Ecf5af03
```
### ZkEVM
```
  deployed HUBSource Address:
  0xf57c41302BbD709F1E3eAa154E7Cc4C361671f7e
  deployed HUBDestination Address:
  0xE1029eba9600E093f0A83601882d47a8Ecf5af03
```
### Goerli
```
  deployed HUBSource Address:
  0xf57c41302BbD709F1E3eAa154E7Cc4C361671f7e
  deployed HUBDestination Address:
  0xE1029eba9600E093f0A83601882d47a8Ecf5af03
```
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
## HUB Version16
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
  0x7D573068bA00964A7Cc7C9E36380E494d406F381
  deployed HUBDestination Address:
  0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F
```
### Goerli
```
  deployed HUBSource Address:
  0x7D573068bA00964A7Cc7C9E36380E494d406F381
  deployed HUBDestination Address:
  0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F
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