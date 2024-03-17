"use client";

import { useState } from "react";
import { Button, Card, Image, Input, Tab, Tabs } from "@nextui-org/react";
import { ethers } from "ethers";
import { parseEther } from "viem";
import { useAccount } from "wagmi";
import { useScaffoldContract, useScaffoldContractWrite } from "~~/hooks/scaffold-eth";

const StakeComponent = () => {
  const [amount, setAmount] = useState("");
  const { address } = useAccount();

  const [token, setTokenContract] = useState("MCR");

  const stakingContract = useScaffoldContract({
    contractName: "ChatStaking",
  });

  const { write: handleApprove } = useScaffoldContractWrite({
    contractName: token,
    functionName: "approve",
    args: [stakingContract.data?.address, parseEther("20", "wei")],
  });

  const { write } = useScaffoldContractWrite({
    contractName: "ChatStaking",
    functionName: "stake",
    args: [parseEther(amount, "wei"), token == "ACM"],
  });

  const handleStake = async () => {
    if (!amount) return;
    const isHomeTeamToken = true;
    const amountToStake = ethers.parseEther(amount);
    write();
  };

  const tabs = [
    {
      id: "away",
      label: "Manchester City",
      token: "$CITY",
      contract: "MCR",
      content: "Manchester City",
    },
    {
      id: "home",
      label: "AC Milan",
      token: "$ACM",
      contract: "ACM",
      content: "AC Milan",
    },
  ];

  return (
    <>
      <div role="alert" className="alert alert-error">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          className="stroke-current shrink-0 w-6 h-6"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth="2"
            d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
          ></path>
        </svg>
        <span>Only Fanz are allowed in! Show your loyalty and wager your fan tokens!</span>
        <div>
          <button onClick={() => handleApprove()} className="btn btn-sm btn-base">
            Approve OnlyFanz
          </button>
        </div>
      </div>
      <div className="flex items-center flex-col flex-grow pt-10 text-center">
        <div className="grid grid-cols-1 md:grid-cols-2 max-w-5xl mx-auto gap-x-4">
          <Card isFooterBlurred radius="lg" className="border-none">
            <Image
              alt="Woman listing to music"
              className="object-cover"
              height={300}
              src="/images/fcbcity.jpeg"
              width={500}
            />
          </Card>
          <div>
            <Tabs
              aria-label="Dynamic tabs"
              items={tabs}
              onSelectionChange={key => setTokenContract(tabs.find(tab => tab.id === key).contract)}
            >
              {item => (
                <Tab key={item.id} title={item.label}>
                  <Card className="p-4">
                    <Input
                      className="mb-4"
                      type="email"
                      label="Stake your Fan Tokens to enter room!"
                      placeholder="5"
                      labelPlacement="outside"
                      onChange={e => setAmount(e.target.value)}
                      endContent={item.token}
                    />
                    <Button
                      className="text-tiny text-white bg-black/20 my-1"
                      variant="flat"
                      color="default"
                      radius="lg"
                      size="sm"
                      onClick={() => handleStake()}
                    >
                      Stake
                    </Button>
                  </Card>
                </Tab>
              )}
            </Tabs>
          </div>
        </div>
      </div>
    </>
  );
};

export default StakeComponent;
