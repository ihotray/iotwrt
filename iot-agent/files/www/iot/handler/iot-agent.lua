local cjson = require 'cjson.safe'
local fs = require 'iot.fs'

local M = {}

local status_dir = '/tmp/iot/'
local status_file = status_dir .. 'iot-agent.status'
--params: string, event msg
--return: none
M.on_event = function (params)
    local msg = cjson.decode(params)
    if msg == nil or msg.event == nil or type(msg.event) ~= 'string' then
        return
    end
    if msg.event ~= 'connected' and msg.event ~= 'disconnected' then
        return
    end
    os.execute('mkdir -p ' .. status_dir)
    fs.writefile(status_file, cjson.encode({state = msg.event, address = msg.address}))
    if msg.event == 'disconnected' then
        os.execute('kill -USR1 `pidof finder`')
    end
end


return M