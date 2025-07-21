


sampev = require "lib.samp.events"

qwerty = false 

function sampev.onPlayerChatBubble(id, col, dist, dur, msg)
    if msg:find("habsburgs") then 

        tests()

    end

end

function tests()
    lua_thread.create(function()
        qwerty = true 
        wait(1000)
        sampSendChat(":D")
        wait(2000)
        qwerty = false 
    end)
end

function sampev.onServerMessage(color, text)

    if qwerty then 
        return false  
    end 

end
