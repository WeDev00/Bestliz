"use client";

import { Button, Card, Image, Input, Tab, Tabs } from "@nextui-org/react";
import type { NextPage } from "next";
import { useAccount } from "wagmi";

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
            <Tabs aria-label="Dynamic tabs" items={tabs}>
              {item => (
                <Tab key={item.id} title={item.label}>
                  <Card className="p-4">
                    <Input
                      className="mb-4"
                      type="email"
                      label="Stake your Fan Tokens to enter room!"
                      placeholder="5"
                      labelPlacement="outside"
                      endContent={item.token}
                    />
                    <Button
                      className="text-tiny text-white bg-black/20 my-1"
                      variant="flat"
                      color="default"
                      radius="lg"
                      size="sm"
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

export default Home;
