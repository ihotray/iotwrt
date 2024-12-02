local cjson = require 'cjson.safe'
local uci = require 'uci'

local M = {}

local function discovery(req)

    local inet_prefix = "inet addr:"

    local address = req.address

    local c = uci.cursor()
    local res = c:get_all('broadcaster', 'controller')
    if res == nil or res.type == nil or res.type ~= 'static' or res.address == nil or res.address == "" then
        -- auto
        local cmd = "ifconfig | grep " .. address
        local handle = io.popen(cmd)
        if handle == nil then
            return cjson.encode({
                code = -1,
                type = 'offer',
                message = 'failed to get address'
            })
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
                return cjson.encode({
                    code = 0,
                    type = 'offer',
                    message = 'success',
                    data = {
                        address = ip_address
                    }
                })
            end
        end
    else
        -- static
        return cjson.encode({
            code = 0,
            type = 'offer',
            message = 'success',
            data = {
                address = res.address
            }
        })
    end

    return cjson.encode({
        code = -1,
        type = 'offer',
        message = 'no address found'
    })
end

local function offer(req)
    -- set handle offer to do something
    return cjson.encode({
        code = 0,
        type = 'ack',
        message = 'success'
    })
end

-- params: string, response from broadcaster
-- return: string or none
M.on_message = function(params)

    local req = cjson.decode(params)
    if req ~= nil and req.type ~= nil and type(req.type) == 'string' then
        if req.type == 'discovery' then -- request from agent, handle it by controller
            return discovery(req)
        elseif req.type == 'offer' then -- offer from controller, handle it by agent
            return offer(req)
        else
            -- don't answer to other
            return
        end
    end

    return cjson.encode({
        code = -1,
        message = 'invalid params'
    })
end

-- create a message to send to broadcaster
M.load_message = function()
    return '{"type": "discovery", "params": {"mac": "7C:27:3C:08:57:94"}}'
end

return M
