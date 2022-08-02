if SERVER then 

    util.AddNetworkString("ecs:Comms")
    --[[---------
    Here's the config in short.

    ["COMMS"] --> [COMMS] Player: ...
    command --> /...

    follow the current defeault
    --]]--------------
    local cfg = {
        ["Open Comms"] = {
            Color = Color(222,247,0),
            command = "openc"
        },
        ["Long Range Comms"] = {
            Color = Color(0,58,247),
            command = "lrc"
        },
        ["Enemy Comms"]={
            Color = Color(255,0,0),
            command = "enemyc"
        },
        ["Air Traffic Control"] = {
            Color = Color(247,169,0),
            command = "atc"
        },
    
}
    
--[[-------------------

Don't Touch the code below...

--]]-------------


--string.sub(text, #comms["Air Traffic Control"].command + 3
  for k,v in pairs(cfg) do
        hook.Add("PlayerSay", "ecs:Comms:" .. v.command, function(ply, text)
            
            if (string.find(text, "/"..v.command))then 
                net.Start("ecs:Comms")
                net.WriteTable({
                    user_name = ply:Nick(),
                    prefix = "["..k.."] ",
                    col = v.Color,
                    othertext = string.sub(text, #v.command + 3)
                })
                net.Broadcast()
                return ""
            end 

        end )
  end

else 

    net.Receive("ecs:Comms", function()
        local tbl = net.ReadTable()

        chat.AddText(tbl.col, tbl.prefix, Color(255,255,255), tbl.user_name .. " ", Color(255,255,255), tbl.othertext)

    end )


end
--a