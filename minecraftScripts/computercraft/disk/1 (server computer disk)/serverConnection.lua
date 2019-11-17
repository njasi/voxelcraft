local modem = peripheral.wrap("right")
local top = peripheral.wrap("top")
os.loadAPI("json.lua")
os.loadAPI("voxel.lua")

modem.open(666)
term.redirect(top)
term.setTextColor(colors.white)
shell.run("clear")

function bigMonitor(text,color)
  modem.transmit(420,666,{text = text,color = color})
end

-- check that I can access the server and run restart if I cannot
bigMonitor("Connecting to the server",colors.yellow)
if voxel.ping() then
  bigMonitor(voxel.server.." responded!",colors.green)
else
  bigMonitor("There was an error reaching "..voxel.server.."...",colors.red)
  shell.run("reconnect")
end

while true do
  if voxel.needsUpdate() then
    bigMonitor("update needed",colors.red)
    voxel.update(modem)
  else
    bigMonitor("no update needed",colors.blue)
  end
  sleep(5)
end

