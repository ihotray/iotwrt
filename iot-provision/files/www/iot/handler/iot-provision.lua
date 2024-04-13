local cjson = require 'cjson.safe'
local uci = require 'uci'
local log = require 'iot.log'

local M = {}

--params: string, msg: {"code":0,"message":"","data":{"username":"","password":"","address":""}}
--return: {code: 0} 0: success, other: failed
M.on_message = function(params)
    -- do something with params
    log.debug(params)
    local msg = cjson.decode(params)
    if msg == nil or type(msg.code) ~= 'number' or msg.code ~= 0 then
        log.error('invalid request')
        return cjson.encode({ code = -1 }) --- 失败
    end
    if msg.data == nil or type(msg.data) ~= 'table' then
        log.error('invalid request, data is nil or not table')
        return cjson.encode({ code = -2 }) --- 失败
    end
    if msg.data.username ~= nil and msg.data.password ~= nil and msg.data.address ~= nil then
        local c = uci.cursor()
        c:set('agent-cloud', 'global', 'username', msg.data.username)
        c:set('agent-cloud', 'global', 'password', msg.data.password)
        c:set('agent-cloud', 'global', 'address', msg.data.address)
        c:commit('agent-cloud')
        os.execute('/etc/init.d/agent-cloud restart')
        return cjson.encode({ code = 0 })
    end

    return cjson.encode({ code = -3 }) --- 失败
end

return M
