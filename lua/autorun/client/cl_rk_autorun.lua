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
include( "enhancednotificationscore/shared.lua" )

hook.Add("PostGamemodeLoaded", "TTT_Risky_Kill_Init", function()

  -- Receive Callback
  net.Receive( "TTT_RK_KILL", function()
  	ENHANCED_NOTIFICATIONS:NewNotification({title="It seems like a player has died.", color=Color(30, 30, 30, 250)})
  end )
end)
