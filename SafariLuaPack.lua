--[[
Scripted By Safari1
Safari#0063
Private Lua Pack
Project B

Version 3/25/2020


		Lua Pack Features:
AA Lua
Fake Lag Lua
Custom Visuals
Double Tap Lua
Auto Buy

	 	----------------
	 	Other Luas USED:
	 	----------------
  Especial Thanks to these People
//---------------------------------\\

Person who made the manual AA, Have no idea what your username is Thanks bud
Who ever also made the Sync Movement


		Disabled Parts :
	Some features of the AA lua are not willing to work with me so I have disabled them

---------------------------------------------------------------
P.S. I used other luas as well not everything is made by me :/
---------------------------------------------------------------
--]]

local VERSION_NUMBER = ' 1.0.0';
local VERSION_CHECK_DONE = false;
local UPDATE_DOWNLOADED = false;
local isBeta = false;

--- Auto Updater
local SAFARI_PACK_UPDATE_TAB = gui.Tab(gui.Reference("Settings") , "SAFARI.PACK.UPDATER", "Safari Pack Updater")
local SAFARI_PACK_GP = gui.Groupbox(SAFARI_PACK_UPDATE_TAB, "Updater for Safari's Lua Pack | Version" ..VERSION_NUMBER, 16, 16, 600,600)

local Updater_GP = gui.Groupbox(SAFARI_PACK_UPDATE_TAB, "Updater", 16, 80, 250, 600)
local Changelog_GP = gui.Groupbox(SAFARI_PACK_UPDATE_TAB, "Changelog", 276, 80, 340, 600)


local clientVersion = "1.0.0"
local latestVersion = http.Get("https://raw.githubusercontent.com/Safari1Lua/Safari1Lua/master/Version")
--local changelog = http.get("https://raw.githubusercontent.com/Safari1Lua/Safari1Lua/master/Changelog")
local txt = gui.Text(Changelog_GP, "Nothing to see here")


local function Update()
    if clientVersion ~= latestVersion then       
	currentScript = file.Open(GetScriptName(), "w")
        currentScript:Write(http.Get("https://raw.githubusercontent.com/Safari1Lua/Safari1Lua/master/SafariLuaPack.lua"))
        currentScript:Close()
        LoadScript(GetScriptName())
	 local text_Update = gui.Text(Changelog_GP, "Reload for update") 
	elseif clientVersion == latestVersion then
	 local text_UpToDate = gui.Text(Changelog_GP, "Latest Version Already Installed")
	end
end

local clientverision_txt = gui.Text(Updater_GP, "Client Version: "..clientVersion)
local latestversion_txt = gui.Text(Updater_GP, "Latest Version: "..latestVersion)
local update_button = gui.Button(Updater_GP, "Update", Update)
--local Changelog_txt = gui.Text(Changelog_GP, http.get("https://raw.githubusercontent.com/Safari1Lua/Safari1Lua/master/Changelog)


--LoadScript('Safari AA.lua')

	
-------------//            Big MAMA             \\-------------	  
		
-- Anti Aim --


local ref = gui.Tab(gui.Reference("Ragebot"), "SafariAA", "Safari's AA")

local First_GP = gui.Groupbox(ref, "Base Rotation/LBY", 16, 16, 600,600);
--local Second_GP = gui.Groupbox(ref, "Left Rotation/LBY");
--local Third_GP = gui.Groupbox(ref, "Right Rotation/LBY");
local ANTIAIM_CHECKBOX = gui.Checkbox( First_GP, "Checkbox", "Anti Aim Active",  false)


local rotation = gui.Slider(First_GP, "limit", "Rotation", 1, -58,58);
local rotationfreq = gui.Slider(First_GP,"rtfreq", "Rotation Speed", 1, 1, 50 );
local rotationoffset = gui.Slider(First_GP, "rtoffset", "Rotation Offset" , 1, -58, 58);

local lbyrotation = gui.Slider(First_GP, "lbylimit", "LbyRotation", 1, -58, 58);
local lbyfreq = gui.Slider(First_GP,"lbyfreq", "LBY Speed", 1, 1, 50 );
local lbyoffset = gui.Slider(First_GP, "lbyoffset", "LBY Offset", 1, -58, 58);



-- Left Rotation
--[[
local leftrotation = gui.Slider(Second_GP, "leftlimit", "LeftRotation", 1, -58,58);
local leftrotationfreq = gui.Slider(Second_GP, "lrtfreq", "Left Rotation Speed", 1, 0, 100);
local leftrotationoffset = gui.Slider(Second_GP, "lrtoffset", "Left Rotation Offset" , 1, -58, 58);

local leftlbyrotation = gui.Slider(Second_GP, "leftlbylimit", "Left LbyRotation", 1, -58, 58);
local leftlbyfreq = gui.Slider(Second_GP,"Leftlbyfreq", "Left LBY Speed", 1, 0, 100 );
local leftlbyoffset = gui.Slider(Second_GP, "Leftlbyoffset", "Left LBY Offset", 1, -58, 58);


-- Right Rotation

local rightrotation = gui.Slider(Third_GP, "rightlimit", "RightRotation", 1, -58,58);
local rightrotationfreq = gui.Slider(Third_GP, "rightrtfreq", "Right Rotation Speed", 1, 0, 100);
local rightrotationoffset = gui.Slider(Third_GP, "rightrtoffset", "Right Rotation Offset" , 1, -58, 58);

local rightlbyrotation = gui.Slider(Third_GP, "rightlbylimit", "Reft LbyRotation", 1, -58, 58);
local rightlbyfreq = gui.Slider(Third_GP, "rightlbyfreq", "Reft LBY Speed", 1, 0, 100 );
local rightlbyoffset = gui.Slider(Third_GP, "rightlbyoffset", "Reft LBY Offset", 1, -58, 58); ]] 

-- Manual AA & Indicators : NOT MADE BY ME

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;
local rage_ref = gui.Groupbox(ref, "Manual Anti Aim", 16, 400, 600, 600);
local check_indicator = gui.Checkbox( rage_ref, "Enable", "Manual AA", false)
local AntiAimleft = gui.Keybox(rage_ref, "Anti-Aim_left", "Left Keybind", 0);
local AntiAimRight = gui.Keybox(rage_ref, "Anti-Aim_Right", "Right Keybind", 0);
local AntiAimBack = gui.Keybox(rage_ref, "Anti-Aim_Back", "Back Keybind", 0);

-- fonts
local fatality_font = draw.CreateFont("Verdana", 20, 700)
local damage_font = draw.CreateFont("Verdana", 15, 700)
local arrow_font = draw.CreateFont("Marlett", 35, 700)
local normal_font = draw.CreateFont("Arial", 0, 0)

local function main()
    if AntiAimleft:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimleft:GetValue()) then
            LeftKey = LeftKey + 1;
            BackKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimBack:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimBack:GetValue()) then
            BackKey = BackKey + 1;
            LeftKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimRight:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimRight:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
            BackKey = 0;
        end
    end
end


function CountCheck()
   if ( LeftKey == 1 ) then
        BackKey = 0;
        RightKey = 0;
   elseif ( BackKey == 1 ) then
        LeftKey = 0;
        RightKey = 0;
    elseif ( RightKey == 1 ) then
        LeftKey = 0;
        BackKey = 0;
    elseif ( LeftKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   elseif ( BackKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   elseif ( RightKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   end       
end

function SetLeft()
   gui_set("rbot.antiaim.base", 90);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetBackWard()
   gui_set("rbot.antiaim.base", 180);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetRight()
   gui_set("rbot.antiaim.base", -90);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetAuto()
   gui_set("rbot.antiaim.base", 180);
   gui_set("rbot.antiaim.advanced.autodir", 1);
end

function draw_indicator()
--142 122 240 255

    local active = check_indicator:GetValue()

    if active then
        local w, h = draw.GetScreenSize();
        draw.SetFont(fatality_font);
        if (LeftKey == 1) then
            SetLeft();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "left");
            draw.TextShadow(15, h - 560, "left");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 60, h/2 - 16, "3");
            draw.TextShadow( w/2 - 60, h/2 - 16, "3");
            draw.SetFont(fatality_font);
        elseif (BackKey == 1) then
            SetBackWard();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "back");
            draw.TextShadow(15, h - 560, "back");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 17, h/2 + 33, "6");
            draw.TextShadow( w/2 - 17, h/2 + 33, "6");
            draw.SetFont(fatality_font);
        elseif (RightKey == 1) then
            SetRight();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "right");
            draw.TextShadow(15, h - 560, "right");
            draw.SetFont(arrow_font);
            draw.Text( w/2 + 30, h/2 - 16, "4");
            draw.TextShadow( w/2 + 30, h/2 - 16, "4");
            draw.SetFont(fatality_font);
        elseif ((LeftKey == 0) and (BackKey == 0) and (RightKey == 0)) then
            SetAuto();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "auto");
            draw.TextShadow(15, h - 560, "auto");
        end
        draw.SetFont(normal_font);
    end
end

-- Sync Movement : NOT MADE BY ME

local movement_ref = gui.Groupbox(ref, "More Options", 16, 666, 600, 600)

local sync_movement = gui.Checkbox(movement_ref, "sync_movement_0.", "Enable synced movement when on player's head", false)

local sync_movement_indicator = gui.Checkbox(movement_ref, "sync_movement_indicator.", "Enable synced movement indicator", false)

local s_w, s_h = draw.GetScreenSize()
local sync_movement_indicator_X = gui.Slider(movement_ref, "sync_movement_indicator.x", "Text X position", 280, 0, s_w);
local sync_movement_indicator_Y = gui.Slider(movement_ref, "sync_movement_indicator.y", "Text Y position", 190, 0, s_h);
local sync_movement_indicator_size = gui.Slider(movement_ref, "sync_movement_indicator.y", "Text size", 25, 0, 100);


function syncMovement(cmd, pos)
    local world_forward = {vector.Subtract( pos,  {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z} )}
    local ang_LocalPlayer = {engine.GetViewAngles().x, engine.GetViewAngles().y, engine.GetViewAngles().z }
    
    cmd.forwardmove = ( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 200 ) -- mine
    cmd.sidemove = ( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 200 )
end

function is_movement_keys_down()
    return input.IsButtonDown( 87 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 83 ) or input.IsButtonDown( 68 ) or input.IsButtonDown( 32 )
end

function is_crouching(player)
    return player:GetProp('m_flDuckAmount') > 0.1
end



local is_synced = false

callbacks.Register("CreateMove", function(cmd)
    if not sync_movement:GetValue() then return end
    succ, err = pcall(function() is_movement_keys_down() is_synced = false end)
    if err or is_movement_keys_down() then return end
    
    local players = entities.FindByClass( "CCSPlayer" )
    
    for k, player in pairs(players) do
        local player_pos = {player:GetAbsOrigin().x, player:GetAbsOrigin().y, player:GetAbsOrigin().z}
        local distance = vector.Distance(player_pos, {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z})
        
        local z_dist = entities.GetLocalPlayer():GetAbsOrigin().z - player_pos[3]
        
        local d_min = 0
        local d_max = 0
        if not is_crouching(player) then
            d_min = 70
            d_max = 85
        else
            d_min = 50
            d_max = 64
        end
        if (distance > d_min and distance < d_max) and (z_dist > d_min and z_dist < d_max) then
            syncMovement(cmd, player_pos)
            is_synced = true
        else
            is_synced = false
        end
    end        
end)


callbacks.Register("Draw", function(cmd)
    if not sync_movement:GetValue() or not sync_movement_indicator:GetValue() then return end
    local main_font = draw.CreateFont("Verdana", sync_movement_indicator_size:GetValue());
    draw.SetFont(main_font)

    draw.Color(255,0,0)
    if is_synced then
        draw.Color(0,255,0)
        draw.Text(sync_movement_indicator_X:GetValue(),sync_movement_indicator_Y:GetValue(), "Synced")
    else
        draw.Text(sync_movement_indicator_X:GetValue(),sync_movement_indicator_Y:GetValue(), "Unsynced")
    end
    
end) 
local function mathfactor()
if ANTIAIM_CHECKBOX:GetValue() then
 
	MATHFACTOR_BASE = (gui.GetValue("rbot.SafariAA.limit") * math.cos((globals.RealTime()) / (gui.GetValue("rbot.SafariAA.rtfreq")*(0.01))) + gui.GetValue("rbot.SafariAA.rtoffset"))
	
		gui.SetValue("rbot.antiaim.base.rotation", MATHFACTOR_BASE)
			
	MATHFACTOR_BASELBY = (gui.GetValue("rbot.SafariAA.lbylimit") * math.cos((globals.RealTime()) / (gui.GetValue("rbot.SafariAA.lbyfreq")*(0.01))) + gui.GetValue("rbot.SafariAA.lbyoffset"))

			gui.SetValue("rbot.antiaim.base.lby", MATHFACTOR_BASELBY)


--	MATHFACTOR_LEFT = (gui.GetValue("rbot.SafariAA.leftlimit") * math.cos((globals.RealTime()) / (gui.GetValue("rbot.SafariAA.lrtfreq")*0.01))))
--		gui.SetValue("rbot.antiaim.left.rotation", MATHFACTOR_LEFT))
end
end	


-- Double Tap --

local DT_TAB = gui.Tab(gui.Reference("Misc"), "DoubleTap", "Double Tap")
local DT_GB = gui.Groupbox(DT_TAB, "Safari's Double Tap", 16, 16, 600,600)
local dtCheckbox = gui.Checkbox(DT_GB, "Double Tab Active", false)
--if dtCheckbox:GetValue() then 
local DT_ST = gui.Combobox(DT_GB, "dt.set", "DT Key Setting", "Off" , "Shift", "Rapidfire")
local DT_OFF = gui.Combobox(DT_GB, "dt.set2", "DT OFF", "Off", "Shift")
local DT_BINDKEY = gui.Keybox(DT_GB, "dt.bind", "Double Tap Key", 0)
local DT_BUTTON = gui.GetValue("misc.DoubleTap.dt.bind")

local function DTBIND_SWITCH()
	local DT_BUTTON = gui.GetValue("misc.DoubleTap.dt.bind")
		local DT_ST = gui.GetValue("misc.DoubleTap.dt.set")
		local DT_OFF = gui.GetValue("misc.DoubleTap.dt.set2")
		if input.IsButtonDown(DT_BUTTON) then
			gui.SetValue("rbot.accuracy.weapon.asniper.doublefire", DT_ST)
		else
			gui.SetValue("rbot.accuracy.weapon.asniper.doublefire", DT_OFF)
		end
end
--end
-- Visuals --
	--\\ Screen Animations
function Effect( Event )
 
  if ( Event:GetName() == 'player_death' ) then
     
      local ME = client.GetLocalPlayerIndex();
     
      local INT_UID = Event:GetInt( 'userid' );
      local INT_ATTACKER = Event:GetInt( 'attacker' );
     
      local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
      local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
     
      local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
      local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
     
      if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
      entities.GetLocalPlayer():SetProp("m_flHealthShotBoostExpirationTime", globals.CurTime() + 1)
                    client.Command("playvol physics\\glass\\glass_pottery_break2 .5", true);
     
      end
 
  end
 
end

	--\\ FOV CHANGER
local FOV_TAB = gui.Tab(gui.Reference("Misc"), "Extra", "More Visuals") 
local FOV_GP = gui.Groupbox(FOV_TAB, "Visuals",16, 16, 600,600);
gui.Slider( FOV_GP, "FOV_SLIDER", "FOV", 60, 0, 140 );

local function FOV( )

	if gui.GetValue( "misc.Extra.FOV_SLIDER" ) then
		client.SetConVar( "fov_cs_debug", gui.GetValue("misc.Extra.FOV_SLIDER"), true)
	else
		client.SetConVar( "fov_cs_debug", 0, true );
	end

end



-- Auto Buy --
local BUYTAB = gui.Tab(gui.Reference("Misc"), "AB", "Auto Buy") 
local AUTOBUY_GP = gui.Groupbox(BUYTAB, "Autobuy",16, 16, 600,600)
local AUTOBUY_CHECKBOX = gui.Checkbox( AUTOBUY_GP, "Checkbox", "BuyBot Active",  false)
local PRIMARY_GUNS = gui.Combobox( AUTOBUY_GP, "primary", "Primary", "Off", "AutoSniper","AK/M4", "Scout", "AWP", "AUG/SG")
local SECONDARY_GUNS = gui.Combobox( AUTOBUY_GP, "Secondary", "Secondary",  "Off", "DB", "Deagle/Revo", "P250","tec9/cz" )
local FULL_ARMOR = gui.Checkbox( AUTOBUY_GP, "k_armor", "Buy Full Armor", false)
local KEVLAR = gui.Checkbox( AUTOBUY_GP, "armor", "Buy Armor", false)
local NADES = gui.Checkbox( AUTOBUY_GP, "nades", "Buy Nades", false)
local ZUES = gui.Checkbox( AUTOBUY_GP, "zeus", "Buy Zeus",  false)
local DEFUSER = gui.Checkbox( AUTOBUY_GP, "defuser", "Buy Defuser",  false)
local GUNS = {"pistol", "revolver", "smg", "rifle", "shotgun", "scout", "autosniper", "sniper", "lmg"}
local HITBOXES = {"head", "neck", "chest", "stomach", "pelvis", "arms", "legs"}
local PRIMARY_G = {"buy scar20", "buy m4a1", "buy ssg08", "buy awp", "buy aug"}
local SECONDARY_G = {"buy elite", "buy deagle", "buy p250", "buy tec9"}
local function Autobuy( event )
    if event:GetName() == "round_start" and AUTOBUY_CHECKBOX:GetValue() then
        local needtobuy = ""
        local primary = PRIMARY_GUNS:GetValue()
        local secondary = SECONDARY_GUNS:GetValue()

        if FULL_ARMOR:GetValue() then needtobuy = "buy vesthelm;"
		end
		if KEVLAR:GetValue() then needtobuy = "buy vest"   
        end
        if NADES:GetValue() then needtobuy = needtobuy.."buy hegrenade;buy molotov;buy smokegrenade;buy flashbang;buy flashbang;"
        end
        if ZUES:GetValue() then needtobuy = needtobuy.."buy taser;" 
        end        
        if DEFUSER:GetValue() then needtobuy = needtobuy.."buy defuser;" 
        end
        if primary> 0 then needtobuy = needtobuy..PRIMARY_G[primary]..";"   
        end        
        if secondary > 0 then needtobuy = needtobuy..SECONDARY_G[secondary]..";" 
        end
       

		
client.Command(needtobuy, false)
	end
end

  
-- Call Backs --)
callbacks.Register( "Draw", "main", main);
callbacks.Register( "Draw", "CountCheck", CountCheck);
callbacks.Register( "Draw", "SetLeft", SetLeft);
callbacks.Register( "Draw", "SetBackWard", SetBackWard);
callbacks.Register( "Draw", "SetRight", SetRight);
callbacks.Register( "Draw", "SetAuto", SetAuto);
callbacks.Register( "Draw", "draw_indicator", draw_indicator);
client.AllowListener( 'player_death' );
callbacks.Register( "Draw", FOV );
callbacks.Register( 'FireGameEvent', 'AWKS', Effect );
callbacks.Register("FireGameEvent", Autobuy)
callbacks.Register("Draw",mathfactor)
callbacks.Register("Draw",DTBIND_SWITCH) 
