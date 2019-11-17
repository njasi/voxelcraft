local modem = peripheral.wrap("bottom")
args = {...}
if #args ~= 4 then
  print("usage: place <x> <y> <x> <block>")
  os.exit()
end

local xPos = tonumber(args[1])
local yPos = tonumber(args[2])
local zPos = tonumber(args[3])
local blockType = args[4]

modem.open(420)
modem.transmit(69,420,{x=xPos, y=yPos, z=zPos, type=blockType,command="place"})
local event, modemSide, senderChannel,
  replyChannel, message, senderDistance = os.pullEvent("modem_message")
term.setTextColor(message["color"])

if message["color"] == colors.green then
    print("Successfully placed the block.")
else
    print("Failed to place the block.")
end
