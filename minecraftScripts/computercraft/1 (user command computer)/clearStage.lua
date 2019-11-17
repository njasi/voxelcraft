local modem = peripheral.wrap("bottom")
args = {...}
if #args ~= 0 then
  print("usage: clear")
  os.exit()
end

modem.open(420)
modem.transmit(69,420,{command="clear"})

local event, modemSide, senderChannel,
  replyChannel, message, senderDistance = os.pullEvent("modem_message")

term.setTextColor(message["color"])
print("Successfully cleared the stage.")
