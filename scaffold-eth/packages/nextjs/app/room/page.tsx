"use client";

import { Divider } from "@nextui-org/react";
import type { NextPage } from "next";
import BetCard from "~~/components/BetCard";
import Chat from "~~/components/Chat";

const Room: NextPage = () => {
  return (
    <div className="flex items-center flex-col flex-grow pt-10 text-center">
      <h1 className="text-3xl font-bold mb-12">Welcome to the Match Room</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 max-w-7xl mx-auto gap-x-4">
        <Chat></Chat>
        <main>
          <h2 className="text-xl font-bold">Active Bets</h2>
          <Divider />
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
