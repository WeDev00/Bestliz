import {
  Button,
  Card,
  CardBody,
  CardHeader,
  Divider,
  Input,
  Progress,
  Table,
  TableBody,
  TableCell,
  TableColumn,
  TableHeader,
  TableRow,
} from "@nextui-org/react";

const BetCard = () => {
  return (
    <>
      <Card>
        <CardHeader className="flex text-center">
          <h2 className="text-md py-2">Match Winner</h2>
        </CardHeader>
        <Divider />
        <CardBody className="pb-5">
          <div className="grid grid-cols-2 gap-x-4 text-small w-full">
            <div className="space-y-4 my-3 text-center">
              <Input
                isClearable
                variant="bordered"
                placeholder="Enter bet amount"
                endContent="CHZ"
                // value={newMessage}
                // onChange={e => setNewMessage(e.target.value)}
                // onKeyPress={e => e.key === "Enter" && handleSendMessage()}
              />
              <Button className="w-full">Place Bet</Button>
            </div>
            <div className="space-y-4 my-3 text-center">
              <Input
                isClearable
                variant="bordered"
                placeholder="Enter bet amount"
                endContent="CHZ"
                // value={newMessage}
                // onChange={e => setNewMessage(e.target.value)}
                // onKeyPress={e => e.key === "Enter" && handleSendMessage()}
              />
              <Button className="w-full">Place Bet</Button>
            </div>
          </div>
          <Divider className="mb-2" />
          <h2 className="text-md text-center py-4">Active Bets</h2>
          <div className="flex justify-between">
            <p>Manchester City</p>
            <p>FC Barcelona</p>
          </div>
          <Progress aria-label="Current Bets" radius="none" color="success" value={35} className="w-full" />
          <div className="flex justify-between">
            <p className="text-warning">500 CHZ</p>
            <p className="text-warning">500 CHZ</p>
          </div>
          <Divider className="mb-2" />
          <Table removeWrapper hideHeader aria-label="Example static collection table" td="">
            <TableHeader>
              <TableColumn align="center">HOME</TableColumn>
              <TableColumn align="center">CATEGORY</TableColumn>
              <TableColumn align="center">AWAY</TableColumn>
            </TableHeader>
            <TableBody>
              <TableRow key="1">
                <TableCell>100%</TableCell>
                <TableCell>#1 Fan</TableCell>
                <TableCell>90%</TableCell>
              </TableRow>
              <TableRow key="2">
                <TableCell>80%</TableCell>
                <TableCell>#2 Fan</TableCell>
                <TableCell>50%</TableCell>
              </TableRow>
              <TableRow key="3">
                <TableCell>60%</TableCell>
                <TableCell>#3 Fan</TableCell>
                <TableCell>30%</TableCell>
              </TableRow>
              <TableRow key="4">
                <TableCell>8%</TableCell>
                <TableCell>Rest</TableCell>
                <TableCell>6%</TableCell>
              </TableRow>
            </TableBody>
          </Table>
        </CardBody>
        {/* <Divider />
        <CardFooter>
          <div className="flex flex-row w-full gap-x-1">
           
          </div>
        </CardFooter> */}
      </Card>
    </>
  );
};

export default BetCard;
