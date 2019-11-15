-- for the command computer that actually places blocks
local modem = peripheral.wrap("top")
modem.open(69)

while true do
  local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")
  if senderChannel == 69 then
    print(message["command"])
    if message["command"] == "place" then
      if(message["x"] < 0 or message["x"] > 19 or message["y"] < 0 or message["y"] > 19 or message["z"] < 0 or message["z"] > 19) then
        modem.transmit(replyChannel,69,{text = "Someone tried to place a "..message["type"].." block at ("..message["x"]..","..message["y"]..","..message["z"]..")",color=colors.red})
      else
        local x = message["x"] + 1
        local z = message["z"] + 1
        local y = (message["y"] + 1) * -1
        commands.setblock("~" .. x .. " ~" .. y .. " ~" .. z .." minecraft:" .. message["type"])
        modem.transmit(replyChannel,69,{text = "Set the block at ("..message["x"]..","..message["y"]..","..message["z"]..") to " .. message["type"].."!", color = colors.green})
      end
    elseif message["command"] == "clear" then
      commands.fill("~1 ~-1 ~1 ~20 ~-20 ~20 air")
      modem.transmit(replyChannel,69,{text = "Cleared the stage!", color = colors.green})
    elseif message["command"] == "open" then
      commands.fill("~ ~-2 ~4 ~ ~-9 ~17 minecraft:air")
      modem.transmit(replyChannel,69,{text = "Opened the window", color = colors.blue})
    elseif message["command"] == "close" then
      commands.fill("~ ~-2 ~4 ~ ~-9 ~17 chisel:glass")
      modem.transmit(replyChannel,69,{text = "Closed the window", color = colors.blue})
    end
  end
end
