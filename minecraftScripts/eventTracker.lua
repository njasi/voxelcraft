local display = peripheral.wrap("top")
local modem = peripheral.wrap("right")
term.redirect(display)
modem.open(420)

while true do
  local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")
  term.setTextColor(message["color"])
  print(message["text"])
end
