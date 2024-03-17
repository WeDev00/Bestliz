"use client";

import React, { useEffect, useState } from "react";
import StakeComponent from "./_components/stake";
import { Card, Divider } from "@nextui-org/react";
import type { NextPage } from "next";
import BetCard from "~~/components/BetCard";
import Chat from "~~/components/Chat";
import { useScaffoldContractRead } from "~~/hooks/scaffold-eth";

const Room: NextPage = () => {
  const { data: userHasStaked, isLoading: contractDataLoading } = useScaffoldContractRead({
    contractName: "ChatStaking",
    functionName: "isAllowed",
  });

  // Handle the loading state if needed (e.g., for showing a loading spinner)
  if (contractDataLoading) {
    return <div>Loading contract data...</div>;
  }
  console.log(userHasStaked);
  if (userHasStaked) {
    return <StakeComponent />;
  }

  return (
    <div className="flex items-center flex-col flex-grow pt-10 text-center">
      <h1 className="text-3xl font-bold mb-12">Welcome to the Match Room</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 max-w-7xl mx-auto gap-x-4">
        <Chat></Chat>
        <main>
          <Card>
            <h2 className="text-xl font-bold py-4 my-0">Active Bets</h2>
          </Card>
          <div className="space-y-4 mt-4">
            {[1, 2, 3].map(key => (
              <BetCard key={key}></BetCard>
            ))}
          </div>
        </main>
      </div>
    </div>
  );
};

export default Room;
