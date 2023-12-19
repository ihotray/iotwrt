local cjson = require 'cjson.safe'
--local uci = require 'uci'

local M = {}

--params: string, response from broadcaster
--return: string or none

    
M.on_message = function (params)
    -- do something with params
    local resp = cjson.decode(params)
    return resp.message
end


return M