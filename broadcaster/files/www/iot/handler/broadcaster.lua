local cjson = require 'cjson.safe'
local uci = require 'uci'

local M = {}

local function discovery(address)

    local inet_prefix = "inet addr:"

    local c = uci.cursor()
    local res = c:get_all('broadcaster', 'controller')
    if res == nil or res.type == nil or res.type ~= 'static' or res.address == nil or res.address == "" then
        --auto
        local cmd = "ifconfig | grep " .. address
        local handle = io.popen(cmd)
        if handle == nil then
            return cjson.encode({ code = -1, type = 'discovery', message = 'failed to get address' })
        end
        local result = handle:read("*a")
        handle:close()

        local lines = {}
        for line in string.gmatch(result, "[^\r\n]+") do
            table.insert(lines, line)
        end
        for _, line in pairs(lines) do
            if string.find(line, inet_prefix) then
                local start_pos = string.find(line, inet_prefix) + #inet_prefix
                local end_pos = string.find(line, " ", start_pos + 1) - 1
                local ip_address = string.sub(line, start_pos, end_pos)
                return cjson.encode({ code = 0, type = 'discovery', message = 'success', data = { address = ip_address } })
            end
        end
    else
        --static
        return cjson.encode({ code = 0, type = 'discovery', message = 'success', data = { address = res.address } })
    end

    return cjson.encode({ code = -1, type = 'discovery', message = 'no address found' })
end

--params: string, message from finder
--address: string, address of broadcast
--return: string

M.on_message = function (params, address)
    local req = cjson.decode(params)
    if req ~= nil and req.type ~= nil and type(req.type) == 'string' and type(address) == 'string' then
        if req.type == 'discovery' then
            return discovery(address)
        end
    end
    return cjson.encode({code = -1, message = 'invalid params'})
end


return M