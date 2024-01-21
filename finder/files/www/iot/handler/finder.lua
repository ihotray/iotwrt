local cjson = require 'cjson.safe'
local uci = require 'uci'
local fs = require 'iot.fs'
local log = require 'iot.log'

local M = {}

local status_file = '/tmp/iot/iot-agent.status'
--params: string, response from broadcaster
--return: string or none
M.on_message = function (params)
    log.debug(params)
    local req = cjson.decode(params)
    if req == nil or req.data == nil or type(req.data.address) ~= 'string' then
        log.error('invalid request, address is nil or not string')
        return
    end

    local c = uci.cursor()
    local agent = c:get_all('agent', 'global')
    if agent ~= nil and agent.controller ~= req.data.address then
        c:set('agent', 'global', 'controller', req.data.address)
        c:commit('agent')
        log.debug('controller changed to '..req.data.address)
        os.execute('/etc/init.d/iot-agent restart')
    else
        local proto = agent.proto or ''
        local port = agent.port or ''
        local data = fs.readfile(status_file)
        if data ~= nil then
            local status = cjson.decode(data)
            if status ~= nil and status.state == 'disconnected' then
                if proto..'://'..req.data.address..':'..port ~= status.address then
                    log.debug('controller changed to '..req.data.address)
                    os.execute('/etc/init.d/iot-agent restart')
                end
            end
        end
    end

    return 'success'
end


return M