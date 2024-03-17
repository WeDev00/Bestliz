import { useState } from "react";
import { Button, Card, CardBody, CardFooter, CardHeader, Divider, Input } from "@nextui-org/react";


const Chat = () => {
  const [messages, setMessages] = useState([
    { id: 1, text: "I hope Haaland is injured and not playing!", sender: "other", time: "04:00 am" },
    { id: 2, text: "$CHZ coin to the moon", sender: "me", time: "04:13 pm" },
    { id: 3, text: "Milan is looking strong today. I am all in on red!", sender: "other", time: "05:05 pm" },
  ]);
  const [newMessage, setNewMessage] = useState("");

  const handleSendMessage = () => {
    if (newMessage.trim() !== "") {
      const nextMessage = {
        id: messages.length + 1,
        text: newMessage,
        sender: "me",
        time: Date(),
      };
      setMessages([...messages, nextMessage]);
      setNewMessage("");
    }
  };

  return (
    <>
      <div>
        <Card>
          <CardHeader className="flex gap-3 text-center">
            <h2 className="text-md text-center font-bold pt-2 mx-auto">Chat Room</h2>
          </CardHeader>
          <Divider />
          <CardBody>
            <div className="min-h-[500px] max-h-[700px] overflow-y-scroll">
              {messages.map(message => (
                <div key={message.id} className={`chat chat-${message.sender === "me" ? "end" : "start"}`}>
                  <div className="chat-image avatar">
                    <div className="w-10 rounded-full">
                      <img
                        alt="Tailwind CSS chat bubble component"
                        src="https://daisyui.com/images/stock/photo-1534528741775-53994a69daeb.jpg"
                      />
                    </div>
                  </div>
                  <div className="chat-header">
                    {message.sender}
                    <time className="ml-2 text-xs opacity-50">{message.time}</time>
                  </div>
                  <div className="chat-bubble">{message.text}</div>
                  <div className="chat-footer opacity-50">Delivered</div>
                </div>
              ))}
            </div>
          </CardBody>
          <Divider />
          <CardFooter>
            <div className="flex flex-row w-full gap-x-1">
              <Input
                isClearable
                variant="underlined"
                placeholder="Type a message..."
                value={newMessage}
                onChange={e => setNewMessage(e.target.value)}
                onKeyPress={e => e.key === "Enter" && handleSendMessage()}
              />
              <Button onClick={handleSendMessage}>Send</Button>
            </div>
          </CardFooter>
        </Card>
      </div>
    </>
  );
};

export default Chat;