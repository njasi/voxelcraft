local modem = peripheral.wrap("bottom")
args = {...}
if #args ~= 1 then
  print("usage: window <open>")
  os.exit()
end

modem.open(420)
if args[1] == "open" then
  modem.transmit(69,420,{command = "open"})
elseif args[1] == "close" then
  modem.transmit(69,420,{command = "close"})
end

local event, modemSide, senderChannel,
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

term.setTextColor(message["color"])
print(message["text"])
