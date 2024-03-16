"use client";

import Link from "next/link";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { Address } from "~~/components/scaffold-eth";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  if (connectedAddress) {
    return (
      <>
        <div className="flex items-center flex-col flex-grow pt-10 text-center">
          <h1 className="text-xl">Matches</h1>
          
          <p className="my-2 font-medium">Connected Address:</p>
          <Address address={connectedAddress} />
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
