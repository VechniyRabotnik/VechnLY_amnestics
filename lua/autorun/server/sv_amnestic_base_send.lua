include("amnestic_config.lua")

util.AddNetworkString("activated_effect_amnestic")
util.AddNetworkString("SetAmnesticValueToAvoid")
util.AddNetworkString("SetJobForAmnesticPlayer")
util.AddNetworkString("KillPlayerAmnestic")
util.AddNetworkString("GetBannedJobsTimer")

function AmnesticsEffectLY(sending_ply, target_ply, amnestic_type)
    if !target_ply:GetNWBool("amnestic_activated", false) then
    local targetteam = target_ply:Team()
        target_ply:SetNWInt( 'reprimand:valueFloat', targetteam)
        target_ply:SetNWBool("amnestic_activated", true)
        net.Start("GetBannedJobsTimer")
        net.WriteFloat(260)
        net.Send(target_ply)
    net.Start("activated_effect_amnestic")
        net.WriteString(amnestic_type)
    net.Send(target_ply)
    end
end

net.Receive("SetJobForAmnesticPlayer", function()
    local target = net.ReadEntity()
       target:KillSilent()
       target:SetTeam(TEAM_CITIZEN)
       target:Spawn()
 end)

net.Receive("KillPlayerAmnestic", function()
    local target = net.ReadEntity()
       target:KillSilent()
       target:Spawn()
 end)

net.Receive("SetAmnesticValueToAvoid", function()
    local receivedBool = net.ReadBool()
    local target = net.ReadEntity()

    target:SetNWBool('amnestic_activated', receivedBool)

 end)

hook.Add("PostPlayerDeath", "RemoveEffectsFromPlayer", function(ply)
   ply:SetNWBool("amnestic_activated", false)
end)


--print(AmnesticConfig.GetText("LoadServer"))