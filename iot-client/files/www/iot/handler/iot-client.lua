local cjson = require 'cjson.safe'
local M = {}

-- /* 
--     "BrokerPort": 8888,
--     "BrokerAddress": "rot-02.ztehome.com.cn",
--     "KeepAliveTime": 7200,
--     "Subscription.1.Topic": "45fadHN5EN0PH1802068wewqe607d6",
--     "Username": "",
--     "Password": "",
-- */
local function get_config()
    -- get mqtt config
    local config = {
        code = 0,
        data = {
            scheme = "mqtts",
            host = "mqtt.eclipse.org",
            port = 1883,
            user = "",
            password = "",
            client_id = 'test',
            topic = {"topic1", "topic2"},
            qos = 0,
            keepalive = 60
        }
    }

    return cjson.encode(config)
end

local function gen_request()
    --- generate request
    local request = {
        code = 0, -- if code !=0, don't send request
        data = {
            method = "call",
            param = {"ubus", "call", {
                object = "system",
                method = "board"
            }}
        }
    }
    return cjson.encode(request)
end

local function on_event(param)
    local args = cjson.decode(param)
    --- handle event
    --- do something here cloud mqtt connected or disconnected
    return cjson.encode({
        code = 0,
        data = args
    })
end

--- invoked by iot-client(c)
M.call = function(method, param)
    if method == "get_config" then
        return get_config()
    end

    if method == "gen_request" then
        return gen_request()
    end

    if method == "on_event" then
        return on_event(param)
    end

    return '{"code": -1, "message": "method not found"}'
end

return M
