"use client";

import Link from "next/link";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { Address } from "~~/components/scaffold-eth";
import { Card, CardFooter, Image, Button } from "@nextui-org/react";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  if (connectedAddress) {
    return (
      <>
        <div className="flex items-center flex-col flex-grow pt-10 text-center">
          <h1 className="text-xl font-bold mb-12">Matches</h1>
          <div className="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-3 gap-x-4 gap-y-4">
            <Card isFooterBlurred radius="lg" className="border-none">
              <Image
                alt="Woman listing to music"
                className="object-cover"
                height={300}
                src="/images/fcbcity.jpeg"
                width={500}
              />
              <CardFooter className="justify-between before:bg-white/10 border-white/20 border-1 overflow-hidden py-1 absolute before:rounded-xl rounded-large bottom-1 w-[calc(100%_-_8px)] shadow-small ml-1 z-10">
                <p className="text-tiny text-white/80 my-1">Match Room Open</p>
                <Link href="/room">
                  <Button
                    className="text-tiny text-white bg-black/20 my-1"
                    variant="flat"
                    color="default"
                    radius="lg"
                    size="sm"
                  >
                    Enter Match Room
                  </Button>
                </Link>
              </CardFooter>
            </Card>
            {[1, 2, 3].map(name => (
              <Card isFooterBlurred radius="lg" className="border-none">
                <Image
                  alt="Match Banner"
                  className="object-cover"
                  height={300}
                  src="/images/fcbcity.jpeg"
                  width={500}
                />
                <CardFooter className="justify-between before:bg-white/10 border-white/20 border-1 overflow-hidden py-1 absolute before:rounded-xl rounded-large bottom-1 w-[calc(100%_-_8px)] shadow-small ml-1 z-10">
                  <p className="text-tiny text-white/80 my-1">Starting soon.</p>
                  <Button
                    className="text-tiny text-white bg-black/20 my-1"
                    variant="flat"
                    color="default"
                    radius="lg"
                    size="sm"
                  >
                    Notify me
                  </Button>
                </CardFooter>
              </Card>
            ))}
          </div>
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
