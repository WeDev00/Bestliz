"use client";

import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { Card, CardFooter, Image, Button } from "@nextui-org/react";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  if (connectedAddress) {
    return (
      <>
        <div className="flex items-center flex-col flex-grow pt-10 text-center">
          <h1 className="text-xl font-bold mb-12">Welcome to the match room</h1>
        </div>
      </>
    );
  }
  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10 text-center">
        <p className="my-2 font-medium">Connect your wallet to get started</p>
      </div>
    </>
  );
};

export default Home;
