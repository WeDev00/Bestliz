# Bestliz

The Sport Chat Platform offers a unique combination of interactive chat features and lossless betting options for sports enthusiasts. Our mission is to engage sports fans without risking their funds, offering an opportunity to integrate with Web3. Each match has its dedicated chat room, accessible by staking a minimum number of $FANTOKEN, specific to the teams playing. After the match ending, users can claim again their tokens.

In the betting aspect, users bet on their token stakes yield, without risking money loss. Bets can be created during live matches staking an arbitrary amount of $CHZ into a match vault, there is no need of odds. A smart contract Factory creates and manages all match vaults and ensures that token get locked until a specified deadline. Winners can claim their stake and gain platform tokens, on the other hand Losers doesn’t lose their stake, but the unlock time to redeem the staked tokens moves further in time. Tokens staked in match vaults will be used for revenue generation. The earned revenue and the protocol fees are used to create use cases for the platform token, such as team merchandise and fan experiences.
How it's Made

The project make use of Chiliz layer 1 protocol Tech stack:

    Schaffold eth to build our dapp
    Hardhat as framework that help us to write scripts and compile our contract
    The smart contracts written in Solidity, with the help of openzeppelin contracts

our protocol is based on the interaction of 3 different contracts:

    Chat.sol, the contract in which you stake your fan tokens to access the chat 2)BettingPool.sol, the contract that allows users to bet during the match
    Bestliz Fidelity Token, the non-tradable token contract of our platform, is the one that is used to access the fan experiences

The first two contracts are for individual matches, which is why two further Factory contracts are provided, which the platform owners will use to create instances of the individual match contracts
