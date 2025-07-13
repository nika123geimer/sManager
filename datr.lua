require 'lib.moonloader'
local sampev = require 'lib.samp.events'

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
    while true do
    wait(0)
sampAddChatMessage("Chairto Sheylebavhsvo", -1)
    end
end
