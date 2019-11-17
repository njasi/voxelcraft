server = "https://voxelcraft.herokuapp.com" -- "localhost:8080"  --
os.loadAPI("json.lua")

function bigMonitor(text,color,modem)
    modem.transmit(420,666,{text = text,color = color})
end

function ping()
    local res = http.get(server.."/api/ping")
    return res ~= nil and json.parseValue(res.readAll())
end

function needsUpdate()
    local v = fs.open("change_num.txt","r")
    local version = v.readAll()
    v.close()
    local r = http.get(server.."/api/blocks/newest")
    local remote = r.readAll()
    r.close()
    if version == remote then
        return false
    else
        local file = fs.open("change_num.txt","w")
        file.write(remote)
        file.close()
        return true
    end
end

function clear(modem)
    modem.transmit(69,420,{command="clear"})
end

function place(modem, b)
    modem.transmit(69,420, { x = b["xPos"], y = b["yPos"], z = b["zPos"], type = b["type"], command="place"})
end

function update(modem)
    local res = http.get(server.."/api/blocks")
    clear(modem)
    sleep(0)
    local blocks = json.parseValue(res.readAll())
    for i = 1,#blocks do
        place(modem,blocks[i])
        sleep(0) -- the sleeping lets the modem send, just an annoying bug in computercraft or something
    end
    -- TODO check if any block needs to be removed
    -- TODO place new blocks
end