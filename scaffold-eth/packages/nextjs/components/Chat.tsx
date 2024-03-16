import { useState } from "react";
import { Button, Card, CardBody, CardFooter, CardHeader, Divider, Input } from "@nextui-org/react";

const Chat = () => {
  const [messages, setMessages] = useState([
    { id: 1, text: "Hello, how can I help you?", sender: "other", time: "12:00 pm" },
    { id: 2, text: "I have a question about my order.", sender: "me", time: "12:05 pm" },
    // Add more messages here
  ]);
  const [newMessage, setNewMessage] = useState("");

  const handleSendMessage = () => {
    if (newMessage.trim() !== "") {
      const nextMessage = {
        id: messages.length + 1,
        text: newMessage,
        sender: "me",
        time: Date().now.toString(),
      };
      setMessages([...messages, nextMessage]);
      setNewMessage("");
    }
  };

  return (
    <>
      <Card>
        <CardHeader className="flex gap-3">
          <h2 className="text-md">Chat Room</h2>
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
    </>
  );
};

export default Chat;
