local effil = require('effil')
local encoding = require('encoding')
local u8 = encoding.UTF8
encoding.default = 'CP1251'

function SendWebhook(URL, DATA, callback_ok, callback_error)
    local function asyncHttpRequest(method, url, args, resolve, reject)
        local request_thread = effil.thread(function (method, url, args)
            local requests = require 'requests'
            local result, response = pcall(requests.request, method, url, args)
            if result then
                response.json, response.xml = nil, nil
                return true, response
            else
                return false, response
            end
        end)(method, url, args)
        if not resolve then resolve = function() end end
        if not reject then reject = function() end end
        lua_thread.create(function()
            local runner = request_thread
            while true do
                local status, err = runner:status()
                if not err then
                    if status == 'completed' then
                        local result, response = runner:get()
                        if result then
                            resolve(response)
                        else
                            reject(response)
                        end
                        return
                    elseif status == 'canceled' then
                        return reject(status)
                    end
                else
                    return reject(err)
                end
                wait(0)
            end
        end)
    end
    asyncHttpRequest('POST', URL, {
        headers = {['content-type'] = 'application/json'},
        data = u8(DATA)
    }, callback_ok, callback_error)
end

function main()
    while not isSampAvailable() do wait(0) end

    local webhookURL = 'https://discord.com/api/webhooks/1394081348343566479/QVfnSGAYpQjvOkT5LwHc05Q82D7unQeXTIYk8kv8XIU8RiAVx6rJnNmnETqW6mvHcU5_'
    local jsonPayload = '{"content": "123"}'

    SendWebhook(webhookURL, jsonPayload)

    wait(-1)
end
