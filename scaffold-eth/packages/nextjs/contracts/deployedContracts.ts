/**
 * This file is autogenerated by Scaffold-ETH.
 * You should not edit it manually or your changes might be overwritten.
 */
import { GenericContractsDeclaration } from "~~/utils/scaffold-eth/contract";

const deployedContracts = {
  88882: {
    StakingFactory: {
      address: "0x148B43B07e57672a39456C41d26C3d70a831b2a4",
      abi: [
        {
          inputs: [],
          stateMutability: "nonpayable",
          type: "constructor",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "contract IERC20[2]",
              name: "tokens",
              type: "address[2]",
            },
            {
              indexed: false,
              internalType: "address",
              name: "stakingContract",
              type: "address",
            },
          ],
          name: "StakingContractCreated",
          type: "event",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "_newOwner",
              type: "address",
            },
          ],
          name: "changeOwner",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "homeTeamFanToken",
              type: "address",
            },
            {
              internalType: "address",
              name: "guestTeamFanToken",
              type: "address",
            },
            {
              internalType: "string",
              name: "eventName",
              type: "string",
            },
            {
              internalType: "uint256",
              name: "_stakingTime",
              type: "uint256",
            },
          ],
          name: "createStakingContract",
          outputs: [
            {
              internalType: "address",
              name: "_stakingContract",
              type: "address",
            },
          ],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "owner",
          outputs: [
            {
              internalType: "address",
              name: "",
              type: "address",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
      ],
      inheritedFunctions: {},
    },
    

  },
} as const;

export default deployedContracts satisfies GenericContractsDeclaration;
