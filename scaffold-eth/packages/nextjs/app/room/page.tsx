"use client";

import { Button, Card, Image, Input, Tab, Tabs } from "@nextui-org/react";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import Chat from "~~/components/Chat";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();
  const tabs = [
    {
      id: "home",
      label: "Manchester City",
      token: "$CITY",
      content: "Manchester City",
    },
    {
      id: "away",
      label: "FC Barcelona",
      token: "$FCB",
      content: "FC Barcelona",
    },
  ];

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10 text-center">
        <h1 className="text-3xl font-bold mb-12">Welcome to the Match Room</h1>
        <div className="grid grid-cols-1 md:grid-cols-2 max-w-7xl mx-auto gap-x-4">
          <Chat></Chat>
          
        </div>
      </div>
    </>
  );
};

export default Home;
