-------------------------------------------------------------------------------
--    TTT Risky Kill
--    Copyright (C) 2017 saibotk (tkindanight)
-------------------------------------------------------------------------------
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------

-- Create notification framework
--include( "enhancednotificationscore/shared.lua" )


local RKEnabledVar = CreateConVar("ttt_rk_enabled","1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should TTT Risky Kill be active?")
local RKMinPlayersVar = CreateConVar("ttt_rk_min_players","7", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How many players should be needed for Risky Kill to be enabled?")

util.AddNetworkString("TTT_RK_KILL")

local function SendDeathNotif(ply, attacker, dmginfo)
  if not RKEnabledVar:GetBool() then return end
  if RKMinPlayersVar:GetInt() > #util.GetAlivePlayers() then return end
  -- headshots, knife damage, and weapons tagged as silent all prevent death
  -- msg from occurring
  local killwep = util.WeaponFromDamage(dmginfo)
  if (ply.was_headshot or dmginfo:IsDamageType(DMG_SLASH) or (IsValid(killwep) and killwep.IsSilent)) then return end
  -- Send net message to players to display the information
  net.Start("TTT_RK_KILL")
  net.Broadcast()

end

local function CheckTTT()
    if gamemode.Get("terrortown") then
        hook.Add("DoPlayerDeath", "TTTRKSendDeathNotification", SendDeathNotif)
    end
end

hook.Add("PostGamemodeLoaded", "LoadTTTRiskyKill", CheckTTT)
