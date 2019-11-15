local modem = peripheral.wrap( "back" )
local win = false

modem.open(1)

function gather(table)
  local thing = ""
  for i = 1, #table do
    thing = thing..table[i]
  end
  return thing
end

function getMultiChar ()
  local x, y = term.getCursorPos()
  local key = 0
  local event = nil
  local acc = {}
  while key ~= 28 do
    event, key = os.pullEvent("key")
    if key ~= 42 and key ~= 54 and key~=58 and key~=28 and key~=29 then
      if key == 15 then
        acc[#acc+1] = "\t"
      elseif key == 14 then
        if #acc > 0 then
          acc[#acc] = nil
        end
      elseif key == 57 then
        acc[#acc+1] = " "
      elseif key >1 and key < 11 then
        acc[#acc+1] = key - 1
      elseif key == 11 then
        acc[#acc+1] = 0
      else
        acc[#acc+1] = keys.getName(key)
      end
    end
    term.setCursorPos(x,y)
    print(gather(acc).." ")
  end
  return gather(acc)
end

while true do
  shell.run("clear")
  term.setTextColor(colors.white)
  print("What do you want to do?\n[C]: clear stage\n[P]: place block\n[W]: open/close window\n")
  local event, char = os.pullEvent("char")
  if char == "c" then
    modem.transmit(69, 1, { command = "clear" })
    local event, modemSide, senderChannel,
      replyChannel, message, senderDistance = os.pullEvent("modem_message")
    term.setTextColor(message["color"])
    print("Successfully cleared the stage.")

  elseif char == "w" then
    win = not win
    if win then
      modem.transmit(69, 1, { command = "open" })
    else
      modem.transmit(69, 1, { command = "close" })
    end
    local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")
    term.setTextColor(message["color"])
    print(message["text"])

  elseif char == "p" then
    print("Please enter the x pos.")
    local xPos = tonumber(getMultiChar())
    print("Please enter the y pos.")
    local yPos = tonumber(getMultiChar())
    print("Please enter the z pos.")
    local zPos = tonumber(getMultiChar())
    print("Please enter the block type.")
    local blockType = getMultiChar()
    modem.transmit(69,1,{x=xPos, y=yPos, z=zPos, type=blockType,command="place"})
    local event, modemSide, senderChannel,
      replyChannel, message, senderDistance = os.pullEvent("modem_message")
    term.setTextColor(message["color"])
    print(message["text"])
  end
  sleep(1)
end