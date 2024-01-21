local cjson = require 'cjson.safe'
local fs = require 'iot.fs'
local log = require 'iot.log'

local M = {}

local status_dir = '/tmp/iot/'
local status_file = status_dir .. 'iot-agent.status'
--params: string, event msg
--return: none
M.on_event = function (params)
    log.debug(params)
    local msg = cjson.decode(params)
    if msg == nil or msg.event == nil or type(msg.event) ~= 'string' then
        log.error('invalid request, event is nil or not string')
        return
    end
    if msg.event ~= 'connected' and msg.event ~= 'disconnected' then
        log.error('invalid request, event is not connected or disconnected')
        return
    end
    os.execute('mkdir -p ' .. status_dir)
    fs.writefile(status_file, cjson.encode({state = msg.event, address = msg.address}))
    if msg.event == 'disconnected' then
        log.debug('send USR1 to finder')
        os.execute('kill -USR1 `pidof finder`')
    end
end


return M