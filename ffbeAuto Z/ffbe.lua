-- Final Fantasy Brave Exvius: ffbeAuto -  Farming & Exploration
-- by tinotk modded by Sikat
-- Memu 960x600 120dpi
-- Nox
-- http://ankulua.boards.net/thread/167/brave-exvius-ffbeauto-farming-explorations

ver = "ffbeAuto Z11 - AnkuLua ver "..getVersion()
ALver = 0
ALpro = true

Settings:setCompareDimension(true, 600)
Settings:setScriptDimension(true, 600)
setImmersiveMode(true)

exploration = Pattern("exploration.png"):similar(0.5)
control = Pattern("control.png")
autobtn = Pattern("auto.png"):similar(0.9)
autobtn_reg = nil
autoonbtn = Pattern("AutoOn.png"):similar(0.8)
repeatbtn = Pattern("SB_Repeat.png"):similar(0.9)
nextbtn = Pattern("next.png")
nextbtn2 = Pattern("next2.png")
next_mission = Pattern("next_missioncomplete.png")
next_i = Pattern("next_initial.png") --next btn at initial screen
backbtn = Pattern("back.png")
nobtn = Pattern("no_btn.png")
yesbtn = Pattern("yes_btn.png")
departbtn = Pattern("depart.png")
no_request = Pattern("no_request.png")
closebtn = Pattern("close.png")
rank_up = Pattern("rank_up.png")
no_nrg = Pattern("out_of_energy.png")
refill_lapis = Pattern("refill_lapis.png")
refill_item = Pattern("refill_item.png")
continue_ask = Pattern("continue_explore.png")
explore_yes = Pattern("explore_yes.png")
explore_continue = Pattern("explore_continue.png")
explore_leave = Pattern("explore_leave.png")
locked_chest = Pattern("locked_chest.png")
results = Pattern("results.png")
lapis_results = Pattern("lapis_results.png")
results_big = Pattern("results_big.png")
questclear = Pattern("questclear.png")
menu = Pattern("menu.png")
menuinbattle = Pattern("menuinbattle.png")
gold_coin = Pattern("gold_coin.png"):similar(0.8)
menu_back = Pattern("menu_back.png")
sense_hostile = Pattern("sense_hostile.png")
battle_won = Pattern("battle_won.png")
battle_won2 = Pattern("battle_won2.png")
dungeon = Pattern("dungeon.png")
connection_error = Pattern("connection_error.png")
connect_ok = Pattern("connect_ok.png")
no_companion = Pattern("no_companion.png")
companion = Pattern("companion.png")
bonus_unit = Pattern("bonus.png"):similar(0.7)
dungeon_clear = Pattern("dungeon_clear.png"):similar(0.7)
unitdatachanged = Pattern("unitdatachanged.png")
lapis = Pattern("Lapis.png"):similar(0.7)
friend = Pattern("friend.png"):similar(0.7)
insufficient_raid_orbs = Pattern("insufficient_raid_orbs.png"):similar(0.75)
raid_orbs_no = Pattern("raid_orbs_no.png"):similar(0.7)
revive = Pattern("lapis_revive.png"):similar(0.7)

buttonreg = { }
findMoveReg = nil
findMoveSet = false
findMoveX = 999999
findMoveY = 999999
findMoveX2 = 0
findMoveY2 = 0
friendsreg = nil
friendsATKreg = nil
friendsBONUSreg = nil

lagx = 1.0
lagc = 1.0
help_screen = false
use_bonus_unit = false
use_highest_atk_companion = false
use_esper_battle = false
continue_on_gameover = true
--always_findmove = false
goldcheck_success = false
leave_after_boss = false
finished_explore = false
depart_count = 0
max_depart_count = 99999
gameover_count = 0
lapis_refill_count = 0
--colosseumTimer = Timer() -- set timer for colosseum schedule
alt_step=true
gold_reg = nil
tempbtn = nil
battle_counter = 0
move_counter = 0
enable_bosscheck_counter = 20					-- when to enable bosscheck on explorations, will be adjusted automatically after a successful run
bosses_encountered = 0
screen = getAppUsableScreenSize()
width = screen:getX(); height = screen:getY()
left_reg = Region(0,0,300,1200)
right_reg = Region(300,0,600,1200)
top_reg = Region(0,0,600,480)
bottom_reg = Region(0,480,600,600)
control_reg = Region(0,900,600,300)
SB_reg = Region(0,550,600,520)
debug_reg = Region(40,0,495,35)
--mid_reg = Region(width/4,height/4,width/2,height/2)
r_x = width/4; r_y = height/4; r_w = width/2; r_h = height/2
mid_reg = Region(r_x,r_y,r_w,r_h)
--mid_reg = Region(150,240,300,480)
center = Location(300,480)
diff = width/2.5
up = {center:offset(0,-(height/3))}
down = {center:offset(0,height/3)}
left = {center:offset(-diff,0)}
right = {center:offset(diff,0)}
ul = {center:offset(-diff,-diff)}
ur = {center:offset(diff,-diff)}
dl = {center:offset(-diff,diff)}
dr = {center:offset(diff,diff)}

aRatio = 1

top = Location(300,150)
bottom = Location(300,750)
rain = {Pattern("rain_up.png"):similar(0.9),Pattern("rain_down.png"):similar(0.9),Pattern("rain_left.png"):similar(0.9),Pattern("rain_right.png"):similar(0.9),
		Pattern("rain_ul.png"):similar(0.9),Pattern("rain_ur.png"):similar(0.9),Pattern("rain_dl.png"):similar(0.9),Pattern("rain_dr.png"):similar(0.9)}

worldmap = {}
worldmap["maranda_coast"] = Pattern("wm_maranda_coast.png")
worldmap["dwarves_forge"] = Pattern("wm_dwarves_forge.png")
worldmap["earth_shrine"] = Pattern("wm_earth_shrine.png")
worldmap["fulan_pass"] = Pattern("wm_fulan_pass.png")
worldmap["phantom_forest"] = Pattern("wm_phantom_forest.png")

farm = {}
farm["earth_shrine_entrance"] = Pattern("earth_shrine_entrance.png")
farm["earth_shrine_exit"] = Pattern("earth_shrine_exit.png")
farm["earth_shrine_exploration"] = Pattern("earth_shrine_exploration.png")
farm["phantom_forest_exploration"] = Pattern("phantom_forest_exploration.png")
farm["fulan_pass_exploration"] = Pattern("fulan_pass_exploration.png")
farm["maranda_coast_exploration"] = Pattern("maranda_coast_exploration.png")
farm["wolfsfang_peak_exploration"] = Pattern("wolfsfang_peak_exploration.png")
farm["dwarves_forge_exploration"] = Pattern("dwarves_forge_exploration.png")
farm["dalnakya_cavern_harvest_exploration"] = Pattern("dalnakya_cavern_harvest.png")
farm["water_shrine_exploration"] = Pattern("water_shrine_exploration.png")
farm["wind_shrine_exploration"] = Pattern("wind_shrine_exploration.png")
farm["fire_shrine_exploration"] = Pattern("fire_shrine_exploration.png")
farm["invincible_interior_exploration"] = Pattern("invincible_interior_exploration.png")
farm["dungeon_finder"] = Location(0,0)
farm["enchanted_maze"] = exploration
farm["orbonne_monastery_vault_exploration"] = Pattern("vault_explore.png")
farm["free_farm"] = exploration

custom = {} -- for custom path name
explorePath = {}
explorePath["earth_shrine_exploration"] ="bosscheck,30|up,2500|findmove|down,1|left,4000|right,3|up,5000|right,6000|down,1|right,4000|left,3|down,3750|right,1000|down,500|left,500|up,500|left,1000|up,9000|down,1|right,1000|up,1000|left,500|up,1|left,500|up,1|left,1|up,3750|down,3750|right,1000|down,2000|up,1|left,5750|right,6|up,4000|left,800|down,600,collect3|up,600|right,3|up,2500"
explorePath["phantom_forest_exploration"] = "left,1|findmove|left,3000|down,1000|left,3000|right,2|up,2000|left,1000|up,2000|right,2500|up,1500|down,1500|left,2500|right,1|battle,ud,700,up|up,3000|right,3000|up,2000|right,3000|up,2000|left,2500|up,500|right,2000|down,500|right,500|down,2000|left,3000|down,2500|left,3000|down,1000|left,2000|up,2000|left,3000|down,4000|left,500|down,2500|left,1500|right,1|up,2000|right,2000|up,5000|right,500|up,4000|right,2000|up,500|left,4000|down,500|left,8000"
explorePath["fulan_pass_exploration"] = "up,2000|left,2500|up,1000|left,5|up,3000|right,1|left,1|down,3000|left,1500|up,1500|left,1500|up,3000|right,3000|up,2500|left,1000|up,500|left,2500|up,3000|left,1500|right,1500|down,3000|right,3000|down,2|right,3000|up,2000|right,3500|up,2000|left,3000|up,2000|left,1|up,3000|right,3500|up,5000|down,2|right,2000|up,3000|left,4000|right,4000|down,3000|left,5000|up,500|left,1000|down,500|left,1000|down,2000|left,3500|up,1500|left,1500|up,6000"
explorePath["maranda_coast_exploration"] = "bosscheck,35|down,500|findmove|down,8000|up,13|left,5000|down,1000|right,10|up,3500,collect1|left,500|down,5000|up,7|battle,lr,2900,left|left,10000|up,4000|left,4000|up,2000,collect2|down,2000|up,2|left,3000|left,4000,zone2|findmove|down,500,collect3|right,4000|left,2|down,3000|left,500|down,3000|left,1000|up,1000|left,4000|right,2|up,2000|left,15|down,3000|left,1500|up,2000|left,1000,collect4|right,2000|up,3000|battle,lr,7300,left|left,8000|up,3000|right,1500|up,2000|right,1500|up,1000|right,2000|down,500,collect5|left,2000|down,1500|left,3000|right,3|up,6000"
explorePath["dalnakya_cavern_harvest_exploration"] = "down,1000|right,1500|up,1000|right,4500|down,1000|right,3500|up,2|left,2000,collect1|down,2|left,3000|up,1000|left,9|down,4000|left,1000|down,2|left,1|down,6,collect2|right,1500|down,2000|left,1000|down,1000|left,1000|down,6|right,2000|up,2|right,3000|up,1000|right,1500,collect3|left,1500|down,2000|left,3000|down,1000|left,2000|down,1500|left,1500|down,2000|left,1500|down,1500|left,1500|down,3000|down,1500,zone2|left,1500|down,1|left,1000,collect4|right,2000|up,3|right,1500|down,1500|right,2000|up,1000|right,1000|up,1500|right,3000,collect5|left,3000|down,1500|left,1000|down,1000|left,2000|down,3000|down,3000,bosszone|down,3000|down,1500|down,1500,extraforboss|right,1500|down,3000|down,2000,3collectzone|up,2|right,1500,collect|left,1|up,2|left,1500|right,1500|down,6000"
explorePath["orbonne_monastery_vault_exploration"] = "up,1000|findmove|down,1|left,1000,collect1|up,2500|right,1000|up,1000|left,1500|up,2000|up,2000,collect2|down,2000|right,1000|down,500|right,1000|down,500,collect3|up,500|left,5|down,2000|right,2000|down,2000|left,2000|up,1000|left,2000|down,9|left,4|up,2000|left,3000|right,2|up,1500|left,2000|left,2|down,1500|right,1500|up,1500|right,2000|down,1500|right,2000|down,2000|up,1|left,500|down,500|left,500|up,500|left,500|up,500|left,16|down,5000|right,3500|up,2000|down,1|right,3000|down,2000|left,5000,collect5|down,4000|right,6000|right,6000"
explorePath["wolfsfang_peak_exploration"] = "right,1500|findmove|left,1|findmove|up,1|findmove|up,1|findmove|up,1|findmove|up,1|findmove|up,1|right,6000|up,1000|right,500|up,1500|right,2500|up,1500|left,3000|findmove|right,1|findmove|right,1|findmove|right,1|up,1500|up,500|right,2000|up,5500|left,1500|up,2|left,1500|right,2|up,3000|left,1500|down,1|right,2|up,1000|right,500|down,1|right,2500|down,3500|up,4|battle,lr,1977,right|right,3000|left,2|up,1500|left,5|up,1500|left,2|up,1000|left,1500|up,1|right,1000|up,1|right,1|right,500|up,500|right,2|up,500|left,1|up,1|left,6000|up,1500|right,2000|left,1|up,500|right,1|up,1500|right,1|up,1|right,1|up,1000|left,2|up,1|left,1|up,2000|right,1|up,500|left,1|up,1000|left,3|up,500|right,1000|up,1000|battle,lr,3500,right|right,3000|up,6500"
explorePath["dwarves_forge_exploration"] = "right,1000|ur,4000|down,3000|up,3000|dl,1000|dl,5000|up,6000|ur,3000|up,4000|left,1000|up,5000|battle,ud,3204,up|right,1000|down,4000|left,1|down,1000|left,6000|left,4000|ul,4000|down,5000|dr,2000|dr,2000|right,5000|down,1|down,3000|left,3000|down,1000|left,1000|up,1000|left,3000|ur,2000|left,4000|up,1000|right,5000|ur,1000|right,4000|right,8000|right,4000|right,4000|dl,3000|left,5000|up,1|up,3000|right,4000|ul,2000|up,6000|right,1000|up,2000|ul,2000|up,3000|ur,2000|battle,ud,7888,up|ul,2000|up,2000|ur,2000|up,2000|up,4000|right,3000|down,2000|left,3000|down,1000|right,3000|down,3000|left,1000|dl,2000|left,5000|up,1000|ur,3000|ul,2000|up,4000|left,4000|up,1000|left,3000|ur,4000|down,1000|dl,5000|right,4000|up,1000|ur,9000"
explorePath["water_shrine_exploration"] = "leaveafterboss|bosscheck,40|right,700|up,2000|right,2500|up,1800|down,1800|left,1|down,1200|left,1950|up,700|left,5|up,3000|up,2100|right,1500|down,3|right,1500|battleex,lr,4820,14,4500,right|right,4000|left,1|up,2700|down,4|right,1200|right,8500|down,1|left,9000|down,3000|left,3000|up,1200|left,4|up,2500|left,2000|right,1|up,2000|down,4|left,4500|right,3|up,2000|up,2300|right,4000|battleex,lr,11188,29,8000,right|right,8000|left,17|up,3000|up,3000"
explorePath["invincible_interior_exploration"] = "leaveafterboss|bosscheck,74|up,6500|down,9|right,5000|left,1|down,700|left,700|down,2|left,1|down,700|right,700|down,2|right,600|down,600|left,700|down,3000|down,3800|battleex,lr,6631,14,3500,left|left,4500|up,1|right,4500|up,3000|up,8000|up,5000|right,1|up,500|wait,8500|up,1|right,2500|battleex,ud,15300,29,3250,down|down,4000|up,3|left,3500|down,1250|down,1800|right,5000|left,2|down,4500|up,5|left,700|up,3000|down,2|left,3100|right,3|down,14|left,1250|left,2000|down,3500|left,2500|down,11|left,3000|up,4750|right,3500|left,11|down,10|down,12|right,2500|up,3250|right,5|up,3000|right,3000|right,1000|left,1|down,5000|down,2800|right,800|up,2300|right,1250|up,2|left,3200|up,1000|right,1250|up,2|left,3000|up,1|right,7|up,700|right,1250|up,3200|up,10000|up,2000|right,1|up,500"
explorePath["wind_shrine_exploration"] = "leaveafterboss|bosscheck,42|right,3800|left,12|up,3000|right,400|up,700|left,2|up,1500|left,700|up,700|left,1500|right,1|up,2000|left,3|down,3500|right,3000|up,800|left,3000|up,3500|left,2000|up,3000|right,2800|down,2500|right,3000|battleex,ud,3870,14,2800,up|up,3700|left,1|up,3000|right,3000|up,700|down,1|right,2500|left,3000|down,1000|left,2500|up,3000|right,700|battleex,ud,10500,29,2600,up|up,3000|left,2|up,7|left,3700|up,1|right,2800|up,1|right,6|up,1500|up,8000|up,1000"
explorePath["fire_shrine_exploration"] = "leaveafterboss|bosscheck,90|left,500|up,2750|right,1|up,2|left,4|down,1|up,1|right,4500|up,500|right,5|up,1000|right,2500|down,2250|left,1500|down,2250|left,1|down,2000|right,2250|down,2000|right,500|left,500|up,2000|left,3500|up,1|right,1500|up,2000|right,1750|left,1|battleex,ud,4350,14,2000,up|up,2500|right,1|up,1500|left,3000|down,3000|left,3000|left,15|up,2350|up,9|right,2500|down,2500|right,2250|right,2500|up,1|right,2750|up,2500|left,2500|up,500|left,1500|down,800|up,800|right,1500|down,1|right,2000|down,2500|left,3500|down,1|left,3100|left,2000|up,800|right,1|up,2500|left,1000|battleex,lr,11040,29,3200,left|left,4500|down,2750|left,2250|left,4500|up,300|right,1|down,3750|down,4350|right,1|up,2750|right,2750|left,1|up,3500|up,1750|down,2500|down,3500|left,3500|right,2|up,3750|up,3500|right,500|down,1500|right,4500|right,2000|left,1|up,3100|ur,5000|ur,5000|left,1|up,2500|up,3000|up,3000"

--allow 2 or more steps of bosscheck before the boss for safety reasons

waitmsg = {"Changing diaper", "Feeding baby", "Warming bottle", "Bathing baby", "Making coffee", "Burping baby"}

function score(target)
	if(exists(target)) then
		toast(target..getLastMatch():getScore())
	else
		toast("  not found")
	end
end

function string:save(filename)
	local f = io.open(scriptPath()..filename, "a+")
	f:write(self.."\t"..os.date().."\n")
	f:close()
end

function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

function runlog(str,istxt)
	local mult = 10^(4)

	if(not istxt) then
		score = getLastMatch():getScore()
		if(score ~= nil) then
			if score >= 0 then score=math.floor(score * mult + 0.5) / mult	else score=math.ceil(num * mult - 0.5) / mult end
			str = str.."  "..score
		else
			str = str.."  nil"
		end
	end

	if (ALver >= "6.0.0") then
		setHighlightTextStyle (0xffffffff, 0xff000000, 22)
		debug_reg:highlight(str,0.5)
	else
		toast(str)
	end

	str:save("run.log")
end

function getPath(str,pathIndex)
	if not pathIndex then pathIndex = 1 end
	local output = {}
	local temp = str:split("|")
	for i=pathIndex,#temp do output[#output+1] = temp[i] end
	return output
end

function getALVer()
	local ALstring = getVersion()
--	local version = 0
	local pro = false
--	local output = {}

	if string.match(ALstring, "pro") then pro = true end

	local temp = ALstring:split("-")
	return temp[1],pro
end

function existsClickL(obj, howLong)
	
	local returnval = false
	local safetyMargin = 15
	local tX = 0
	local tY = 0
	local tW = 0
	local tH = 0

	if not howLong then howLong = 0 end
	
	if (buttonreg[obj] == nil) then
		if (existsClick(obj, howLong)) then
			returnval = true
			tX = getLastMatch():getX()
			tY = getLastMatch():getY()
			tW = getLastMatch():getW()
			tH = getLastMatch():getH()
			buttonreg[obj] = Region(tX-safetyMargin,tY-safetyMargin,tW+safetyMargin*2,tH+safetyMargin*2)
		else
			returnval = false
		end
	else
		if (buttonreg[obj]:existsClick(obj, howLong)) then
			returnval = true
		else
			returnval = false
		end
	end
	
	return returnval
end

function existsL(obj, howLong)
	
	local returnval = false
	local safetyMargin = 5
	local tX = 0
	local tY = 0
	local tW = 0
	local tH = 0

	if not howLong then howLong = 0 end
	
	if (buttonreg[obj] == nil) then
		if (exists(obj, howLong)) then
			returnval = true
			tX = getLastMatch():getX()
			tY = getLastMatch():getY()
			tW = getLastMatch():getW()
			tH = getLastMatch():getH()
			buttonreg[obj] = Region(tX-safetyMargin,tY-safetyMargin,tW+safetyMargin*2,tH+safetyMargin*2)
		else
			returnval = false
		end
	else
		if (buttonreg[obj]:exists(obj, howLong)) then
			returnval = true
		else
			returnval = false
		end
	end
	
	return returnval
end

--Custom path
local f = io.open(scriptPath().."custom.txt", "r")
if( f ~= nil) then 
	custom_tbl = f:read("*all"):split("\n"); f:close()
	for i,v in pairs(custom_tbl) do 
		temp = custom_tbl[i]:split(":")
		table.insert(custom,"custom_"..temp[1])
		explorePath["custom_"..temp[1]] = temp[2]
	end
end

function findMove()
	local center = nil
--	toast("Finding Rain's position...")
	usePreviousSnap(false)

	for i=1,#rain do 
--		if(debug_mode) then toast("Hightlighting Rain region"); mid_reg:save("rain_reg.png"); mid_reg:highlight(1); runlog("Checking Rain#"..i) end
		if(findMoveSet == false and exists(rain[i],0)) then 

			if (getLastMatch():getX() < findMoveX) then
				findMoveX = getLastMatch():getX()
--				if (debug_mode) then runlog("Rain X :"..findMoveX, true) end
			end
			if (getLastMatch():getY() < findMoveY) then
				findMoveY = getLastMatch():getY()
--				if (debug_mode) then runlog("Rain Y :"..findMoveY, true) end
			end
			if (getLastMatch():getX()+getLastMatch():getW() > findMoveX2) then
				findMoveX2 = getLastMatch():getX()+getLastMatch():getW()
--				if (debug_mode) then runlog("Rain X2 :"..findMoveX2, true) end
			end
			if (getLastMatch():getY()+getLastMatch():getH() > findMoveY2) then
				findMoveY2 = getLastMatch():getY()+getLastMatch():getH()
--				if (debug_mode) then runlog("Rain Y2 :"..findMoveY2, true) end
			end

--			if (debug_mode) then
--				findMoveReg = Region(findMoveX, findMoveY, findMoveX2-findMoveX, findMoveY2-findMoveY)
--				findMoveReg:highlight(0.35)
--			end
			
			center = getLastMatch()
--			if(debug_mode) then runlog("Found Rain#"..i) end
--			center:highlight(.1)
			up[2] = center:getCenter()
--			center:offset(0,70):highlight(.1)
			down[2] = up[2]:offset(0,115)
--			center:offset(-35,50):highlight(.1)
			left[2] = up[2]:offset(-30,75)
--			center:offset(35,50):highlight(.1)
			right[2] = up[2]:offset(30,75)
			ul[2] = up[2]:offset(-30,0)
			ur[2] = up[2]:offset(30,0)
			dl[2] = down[2]:offset(-30,0)
			dr[2] = down[2]:offset(30,0)
			break
		elseif(findMoveSet == true and findMoveReg:exists(rain[i],0)) then 
			center = findMoveReg:getLastMatch()
--			center:highlight(.1)
			up[2] = center:getCenter()
--			center:offset(0,70):highlight(.1)
--			center:offset(-35,50):highlight(.1)
--			center:offset(35,50):highlight(.1)
			down[2] = up[2]:offset(0,115)
			left[2] = up[2]:offset(-30,75)
			right[2] = up[2]:offset(30,75)
			ul[2] = up[2]:offset(-30,0)
			ur[2] = up[2]:offset(30,0)
			dl[2] = down[2]:offset(-30,0)
			dr[2] = down[2]:offset(30,0)
			break
		end
		usePreviousSnap(true)
	end

	usePreviousSnap(false)

	if(center == nil) then 
--		toast("Can't find Rain, turning off Step by click mode"); alt_step=false 
		if(debug_mode) then runlog("Rain not found",true) end
		return false
	end
	return true
end

function selectDungeon()
	toast("Finding available dungeon...")
	dungeonList = findAllNoFindException(dungeon)
	if(debug_mode) then runlog("Custom dungeon found: "..#dungeonList,true) end
	dialogInit()
	addRadioGroup("custom_dungeon",1)
	for i=1,#dungeonList do
		addRadioButton("Dungeon #"..i,i)
	end
	dialogShow("Select Dungeon")
	farm["dungeon_finder"] = dungeonList[custom_dungeon]
	if(debug_mode) then runlog("Custom dungeon select: "..custom_dungeon,true) end
end

function chaosExploraton()
	local count = 0
	local random_1 = math.random(8)
	local random_2 = math.random(450+(lagx*100),7250+(lagx*250))
	
	if(debug_mode) then runlog("Random Exploration Start!",true)
	else
		toast("Random exploration, please stop and manually finish.")
	end	

	leave_after_boss = true
	
	while(true) do
		if (finished_explore == true) then break end
		if (exists(revive,0)) then break end
		count = count + 1
		random_1 = math.random(12)
		random_2 = math.random(450+(lagx*100),7250+(lagx*250))
		if (random_1 == 1) then go("left",random_2)
		elseif (random_1 == 2) then go("right",random_2)
		elseif (random_1 == 3) then go("up",random_2)
		elseif (random_1 == 4) then go("down",random_2)
		elseif (random_1 == 5 or random_1 == 9) then go("ul",random_2*1.5)
		elseif (random_1 == 6 or random_1 == 10) then go("ur",random_2*1.5)
		elseif (random_1 == 7 or random_1 == 11) then go("dl",random_2*1.5)
		elseif (random_1 == 8 or random_1 == 12) then go("dr",random_2*1.5)
		end
		if (count%13 == 0) then
			if(debug_mode) then runlog("Exploration failure.",true)
			else
				toast("Exploration failure.")
			end	
		elseif (count%17 == 0) then
			if(debug_mode) then runlog("Please finish manually.",true)
			else
				toast("Please finish manually.")
			end	
		end
	end
end

function findBattle(loot_direction,limit,exit_direction)

	-- store optimization variables
	local lastEnableBossCheck = enable_bosscheck_counter
	local lastMoveCounter = move_counter
	local locBattleCount = 0
	local lapsWithoutBattle = 0

	-- no bosscheck
	enable_bosscheck_counter = 100000
		
	for i=0, 100 do 
		if(exists(revive,0)) then return end
		toast("Lap "..i)
		local count = battle_counter
		if(loot_direction == "lr") then
			go("left",2500+1750*lagx)
			go("right",2500+1750*lagx)
		elseif(loot_direction == "ud") then
			go("up",2500+1750*lagx)
			go("down",2500+1750*lagx)
		end
		locBattleCount = locBattleCount + battle_counter - count
		if (battle_counter > count) then
			lapsWithoutBattle = 0
		else
			lapsWithoutBattle = lapsWithoutBattle + 1
		end
		if(((i>=30 and i%5==0) or (locBattleCount>=10 and count<battle_counter) or (lapsWithoutBattle > 2)) and checkGold(limit)) then break end
		if (lapsWithoutBattle > 7) then break end
		--if(battle_counter >= limit) then go(exit_direction,4000); break end
	end

	toast("Exiting farming...")
	go(exit_direction,1234);go(exit_direction,2345)
		
	-- restore optimization variables
	enable_bosscheck_counter = lastEnableBossCheck
	move_counter = lastMoveCounter
	
end

function findBattleEx(loot_direction,limit,battle_limit,run_length,exit_direction)

	-- store optimization variables
	local lastEnableBossCheck = enable_bosscheck_counter
	local lastMoveCounter = move_counter
	local locBattleCount = 0
	local lapsWithoutBattle = 0

	-- no bosscheck
	enable_bosscheck_counter = 100000
	
	-- reduce lagx
--	lagx = lagx / 5
	
	for i=0, 100 do 
		if(exists(revive,0)) then return end
		toast("Lap "..i)
		local count = battle_counter
		if(loot_direction == "lr") then
			go("left",run_length*0.8+run_length*lagx*0.2)
			go("right",run_length*0.8+run_length*lagx*0.2)
		elseif(loot_direction == "ud") then
			go("up",run_length*0.8+run_length*lagx*0.2)
			go("down",run_length*0.8+run_length*lagx*0.2)
		end
		locBattleCount = locBattleCount + battle_counter - count
		if (battle_counter > count) then
			lapsWithoutBattle = 0
		else
			lapsWithoutBattle = lapsWithoutBattle + 1
		end
		if (battle_limit > 0 and battle_counter >= battle_limit) then break end
		if(((i>=30 and i%5==0) or (locBattleCount>=10 and count<battle_counter) or (lapsWithoutBattle > 2 and i%3 == 0)) and checkGold(limit)) then break end
		if (lapsWithoutBattle > 9) then break end
		--if(battle_counter >= limit) then go(exit_direction,4000); break end
	end

	toast("Exiting farming...")
	go(exit_direction,run_length)
	
	-- restore lagx
--	lagx = lagx * 5
	
	-- restore optimization variables
	enable_bosscheck_counter = lastEnableBossCheck
	move_counter = lastMoveCounter
	
end

function checkGold(limit)
	local gold
	local returnval = false
	
	usePreviousSnap(false)

	for i=1,20 do
		existsClickL(menu,lagx/3)
		wait(lagx/8+0.1)
		if(existsL(gold_coin,lagx/4)) then

--			if(debug_mode) then runlog("Gold coin exists",true) end

			if(gold_reg == nil) then 
				gold_reg = Region(getLastMatch():getX()+40,getLastMatch():getY()+1,135,41*aRatio)
				if(debug_mode) then gold_reg:save("gold_reg.png") end
			else
				gold_reg:highlight(0.25)
				gold, returnval = numberOCRNoFindException(gold_reg,"gil")
				if (returnval) then
					existsClickL(menu_back,2)
					toast(gold.." gold")
					if(debug_mode) then runlog("Gold check: "..gold,true) end
					if(gold >= limit) then
						goldcheck_success = true
						return true
					else
						if (goldcheck_success == false and (gold < limit/5)) then
							gold_reg = Region(gold_reg:getX()-1,gold_reg:getY()-2,gold_reg:getW()+2,gold_reg:getH()+4)
							if(debug_mode) then runlog("Enlarging check region",true) end					
						end
						return false
					end
				else
					if(debug_mode) then runlog("Enlarging check region",true) end					
					gold_reg = Region(gold_reg:getX()-1,gold_reg:getY()-2,gold_reg:getW()+2,gold_reg:getH()+4)
				end
			end
		else
			wait(0.1)
		end
	end	

	existsClickL(menu_back,2)
	return 1000000 -- can't check, better quit
end

function resultsExit()
	local giveup = Pattern("giveupnow.png")
	local numfunc = 14
	local e_nextbtn = false
	local e_nextbtn2 = false
	local e_nextmission = false

	if(debug_mode) then runlog("Results exit start",true) end

	while true do
		usePreviousSnap(false)
		if(top_reg:exists(results_big,0)) then click(getLastMatch()) ; break end		
		usePreviousSnap(true)
		connectionCheckNoWait()
		if(existsL(backbtn,0)) then break end		
		if(existsL(lapis,0)) then break end
		if(existsL(lapis_results,0)) then break end
		if(existsL(revive,0)) then gameOver(); break end
		if(existsL(giveup,0)) then gameOver(); break end
	end

	for i=0, 3000000 do
		usePreviousSnap(false)
		if(existsL(backbtn,0)) then break end
		usePreviousSnap(true)
		top_reg:existsClick(results_big,0)
		
		if ((i%numfunc == 0 or i%numfunc == 8 or i%numfunc == 11) and (existsClickL(nextbtn,0)) and debug_mode) then
			runlog("Next 1")
		elseif ((i%numfunc == 2 or i%numfunc == 9 or i%numfunc == 12) and (existsClickL(nextbtn2,0)) and debug_mode) then
			runlog("Next 2")
		elseif ((i%numfunc == 4 or i%numfunc == 10 or i%numfunc == 13) and (existsClickL(next_mission,0)) and debug_mode) then
			runlog("Next 3")
		elseif (i%numfunc == 1 and existsClickL(rank_up,0) and debug_mode) then
			runlog("Rank Up")
		elseif (i%numfunc == 3 and existsClick(closebtn,0) and debug_mode) then
			runlog("Close Button")
		elseif (i%numfunc == 5 and existsClickL(no_request,0) and debug_mode) then
			runlog("No Request")
		elseif (i%numfunc == 6) then
			gameOverNoWait()
		elseif (i%numfunc == 7) then
			connectionCheckNoWait()
		end

	end

	usePreviousSnap(false)

	if(debug_mode) then  
		runlog("Results exit done",true)
	else
--		toast("Results exit done")
	end
end

function exploreBattle()
	local esperfilled = Pattern("SB_EsperFilled.png"):similar(0.7)
	local IsReady = Pattern("SB_MyTurn.png"):similar(0.7)
	--boss = (boss or false)
	local auto_pressed = 0
	local findUnit = nil
	
	for i=0,10000 do
		usePreviousSnap(false)
		if (existsL(menuinbattle,0)) then break end
		usePreviousSnap(true)
		if (existsL(autobtn,0)) then break end
		if (existsL(autoonbtn,0)) then break end
		if (i > 100 and existsL(menu,0)) then return false end
		if (i > 200 and findMove()) then return false end
	end
	
	usePreviousSnap(false)

	if(debug_mode) then runlog("Explore battle start",true) end
	for i=0,300000 do
		if(existsL(results,0)) then
			click(getLastMatch())
			if(debug_mode) then runlog("Result screen") end
		elseif (use_esper_battle and right_reg:exists(esperfilled,0)) then
			if (debug_mode) then getLastMatch():highlight(0.2); runlog("Esper Ready : ") end
			if (not existsClickL(autoonbtn,0)) then
				if (bottom_reg:exists(IsReady,lagx/3)) then
					findUnit = findAllNoFindException(IsReady)

					for i,u in ipairs(findUnit) do
						dragDrop(Location(u:getX()+10,u:getY()+20),Location(u:getX()+190,u:getY()+20))
						wait(0.15+lagx/4)
						if (battleChoice("esper")) then break end
					end

--					if (debug_mode) then getLastMatch():highlight(0.2) ; runlog("Selecting Esper...", true) end
--					dragDrop(Location(getLastMatch():getX()+10,getLastMatch():getY()+30),Location(getLastMatch():getX()+250,getLastMatch():getY()+30))
--					wait(0.1+math.max(0,(lagx-0.5)/3))
--					battleChoice("esper")
					existsClick(autobtn,lagx/5+0.1)
				end
			end
			auto_pressed = 0
		else
			if(auto_pressed < 3 and existsClickL(autobtn,0)) then 
				if (debug_mode) then runlog("Auto : ") end
			    auto_pressed = auto_pressed + 1
			elseif (auto_pressed < 3 and existsL(autoonbtn,0)) then
				if (debug_mode) then runlog("Auto is on : ") end
			end
		end
		usePreviousSnap(false)
		if(existsL(menu,0)) then break end
		usePreviousSnap(true)
		if(existsL(battle_won,0) or existsL(battle_won2,0) or existsL(continue_ask,0)) then break end
		if(existsL(revive,0)) then return end
		usePreviousSnap(false)
	end
	usePreviousSnap(false)
	battle_counter = battle_counter+1

	if(debug_mode) then
		runlog("Battle done: "..battle_counter,true) 
--	else
--		toast("Battle done: "..battle_counter)
	end

	for i=0,1000 do
		usePreviousSnap(false)
		if (existsL(menu,0)) then break end
		usePreviousSnap(true)
		if (findMove()) then break end
	end	
	
	return true
end

function exploreLeave()
	local rain_found = 0

	if(debug_mode) then runlog("Attempting to leave",true) end

	if(exists(revive,0)) then return end

	for i=0,900000 do
		click(center)
		usePreviousSnap(false)
		existsClick(explore_leave,0)
		usePreviousSnap(true)
		existsClick(explore_yes,0)
		if(top_reg:exists(results_big,0)) then click(getLastMatch()); break end
		if(exists(dungeon_clear,0)) then break end
		if(i%49 == 0 and i > 0 and findMove()) then rain_found = rain_found + 1 end
		if(rain_found > 5) then toast("Leave failed!") ; break end
		connectionCheck()
	end
	
	if (rain_found > 5) then
		if(debug_mode) then runlog("Leave failed!",true) end
		chaosExploraton()
	end

	usePreviousSnap(false)
end

function bossBattle()
	toast("Boss battle!")
	if(debug_mode) then runlog("Boss battle after move : "..move_counter,true) end
	for i=0,200000 do
		click(center)
--		wait(3)
		usePreviousSnap(false)
		existsClick(explore_yes,0)
		usePreviousSnap(true)
		if(control_reg:exists(menuinbattle,0)) then exploreBattle(); break end
		if(exists(revive,0)) then return end
	end

	usePreviousSnap(false)

	if (bosses_encountered == 0 and enable_bosscheck_counter+4 <= move_counter) then enable_bosscheck_counter = move_counter - 3 end
	
	bosses_encountered = bosses_encountered + 1

	for i=0,30000 do
		if(exists(revive,0)) then return end
--		usePreviousSnap(false)
		existsClick(battle_won,0)
--		usePreviousSnap(true)
		existsClick(battle_won2,0)
		if (leave_after_boss) then
			finished_explore = true
			existsClick(explore_leave,0)
			break
		elseif(existsClick(explore_continue,0)) then break end
		if(bottom_reg:exists(menu,0)) then break end
		if(exists(revive,0)) then return end
	end

	usePreviousSnap(false)

end

function finishExplore()


	if(exists(revive,0)) then return end

	if(not finished_explore and top_reg:exists(sense_hostile)) then 
		if(debug_mode) then runlog("Boss found") end
		bossBattle()
	else exploreLeave() end
	if (not findMoveSet) then
		findMoveSet = true
		findMoveReg = Region(findMoveX-15, findMoveY-15, findMoveX2-findMoveX+30, findMoveY2-findMoveY+30)
		if(debug_mode) then toast("Hightlighting Rain region"); findMoveReg:highlight(0.75) end
	end
	toast("Explore Finished!")
	if(debug_mode) then runlog("Explore Finished!",true) end
end

function connectionCheck()
--	if(debug_mode) then runlog("Connection check",true) end
	if(exists(connection_error, lagx/4)) then 
		if(debug_mode) then runlog("Connection error") end
		if(existsClick(connect_ok, lagx/4) and debug_mode) then runlog("Connect attempt") end
	end
end

function connectionCheckNoWait()
--	if(debug_mode) then runlog("Connection2 check",true) end
	if(existsL(connection_error, 0)) then 
		if(debug_mode) then runlog("Connection Error") end
		if(existsClickL(connect_ok, 0) and debug_mode) then runlog("Connect Attempt.") end
	end
end

function freeFarm()
	toast("Free farm")
	dialogInit()
	addRadioGroup("direction",1)
	addRadioButton("Left-Right",1)
	addRadioButton("Up-Down",2)
	dialogShow("Which direction?")
	findMove()
	enable_bosscheck_counter = 100000
	continue_on_gameover = false				-- never continue with free farm
	lagx = (0.01 * lagx) + 0.07
	while true do
		if(direction == 1) then
			go("left",2500+30000*lagx)
			go("right",2500+30000*lagx)
		elseif(direction == 2) then
			go("up",2500+30000*lagx)
			go("down",2500+30000*lagx)
		end
	end
end

function enchantedMaze()
	local lv1 = Pattern("enchanted_maze_lv1.png")
	local lv2 = Pattern("enchanted_maze_lv2.png")
	local lv3 = Pattern("enchanted_maze_lv3.png")
	local lv4 = Pattern("enchanted_maze_lv4.png")
	local lv5 = Pattern("enchanted_maze_lv5.png")
	local lvexit = Pattern("enchanted_maze_exit.png")
	
	go("up",4000)
	if(exists(lv1)) then
		go("up",4000)
	end
	if(exists(lv2)) then 
		go("up",4000) 
	end
	if(exists(lv3)) then 
		findMove()
		go("up",1)
		findMove()
		go("right",1)
		go("up",2000)
		go("left",3)
		go("up",4000)
	end
	if(exists(lv4)) then
		findMove()
		go("up",1)
		findMove()
		go("left",1)
		go("up",2000)
		go("right",3)
		go("up",1000)
	end
	if(exists(lv5)) then
		go("up",1000)
		go("left",2000)
		go("up",2000)
	end
	if(exists(lvexit)) then
		go("up",2000)
	end
end

function fFarm(location)
	local tempi = 0
	local func_state = 0
	local departed = false
	local findComp = nil
	local findCompReg = nil
	local compATK = -1
	local highestATK = -1
	local highestATKBtn = nil
	local returnval = false
	
	while (true) do
		if (departed == false) then 

			wait(0.1+lagx/10)
			
			usePreviousSnap(false)
			if (exists(lapis,0)) then
				usePreviousSnap(true)
			end

			--if(colosseumsched and colosseumTimer:check()>7200) then colosseumBattle() end
			if(string.match(location,"custom_")) then 
				if(existsClickL(exploration,0) and debug_mode) then runlog("Custom Exploration",true) end
				tempbtn = getLastMatch()
			elseif(location=="dungeon_finder") then
				--toast("Custom dungeon")
				if (exists(dungeon,0)) then
					click(farm[location])
					tempbtn = farm[location]
					if(debug_mode) then runlog("Dungeon Finder",true) end
				end
			else
				if(location=="orbonne_monastery_vault_exploration") then dragDrop(bottom,top);wait(3);dragDrop(bottom,top) end --swipe to vault explore section
				if(existsClickL((farm[location]),0) and debug_mode) then runlog("Selected",true) end
				tempbtn = getLastMatch()
			end
			
			--toast(location.."  "..getLastMatch():getScore())
--			wait(0.1+lagx*0.1)
		
			--out of raid orbs handler
			if(func_state == 11 or existsL(insufficient_raid_orbs,0)) then 
				func_state = 11
				if(debug_mode) then runlog("Out of raid orbs") end
				if(refill) then 
					toast("Burning lapis..."); if(debug_mode) then runlog("Refill lapis") end
					existsClick(refill_lapis,0)
					if (existsClick(yesbtn,0)) then wait(lagx) ; func_state = 0 ; lapis_refill_count = lapis_refill_count + 1 end
				elseif(existsClick(raid_orbs_no,0)) then
					func_state = 0
					math.randomseed(os.time()); toast(waitmsg[math.random(#waitmsg)].. " now... Come back way later."); wait(90+lagx*3*math.random(1,4)*math.random(1,30))
				end
	--			if(location=="dungeon_finder") then click(farm[location])
	--			else existsClick((farm[location])) end
	--			wait(0.75+lagx*0.15)
			end

			--out of energy handler
			if(func_state == 12 or existsL(no_nrg,0)) then 
				func_state = 12
				if(debug_mode) then runlog("Out of energy") end
				if(refill) then 
					toast("Burning lapis..."); if(debug_mode) then runlog("Refill lapis") end
					existsClick(refill_lapis,0); 
					if (existsClick(yesbtn,0)) then wait(lagx) ; func_state = 0  ; lapis_refill_count = lapis_refill_count + 1 end
				elseif (bottom_reg:existsClick(backbtn,0)) then 
					func_state = 0
					math.randomseed(os.time()); toast(waitmsg[math.random(#waitmsg)].. " now... Come back later."); wait(35+lagx*math.random(1,35))
				end
	--			if(location=="dungeon_finder") then click(farm[location])
	--			else existsClick((farm[location])) end
	--			wait(0.75+lagx*0.15)
			end

			-- next button
			if(existsL(backbtn,0)) then 
				if(existsClickL(next_i,0) and debug_mode) then runlog("Next!", true) end
			end
		
			-- companion handler
			if(func_state == 21 or exists(companion,0)) then				
				if (func_state ~= 21) then
					func_state = 21
					if ((use_bonus_unit == true and friendsBONUSreg == nil) and (friendsreg == nil)) then
						wait(0.7 + lagx/2) -- wait for animation
					else
						wait(0.1)
					end
				elseif use_bonus_unit == true and friendsBONUSreg == nil and exists(bonus_unit,0) then
					tempbtn = getLastMatch()
					friendsBONUSreg = Region(getLastMatch():getX()-15,80,getLastMatch():getW()+30,height-60)
					if(debug_mode) then friendsBONUSreg:highlight(0.35) ; runlog("Companion : Bonus", true) end
					click(tempbtn)
					func_state = 0
				elseif use_bonus_unit == true and friendsBONUSreg:exists(bonus_unit,0) then
					tempbtn = friendsBONUSreg:getLastMatch()
					if(debug_mode) then getLastMatch():highlight(0.15) ; runlog("Companion : Bonus", true) end
					click(tempbtn)
					func_state = 0
				elseif(friendsreg == nil and exists(friend,0)) then
					friendsreg = Region(getLastMatch():getX()-15,80,getLastMatch():getW()+30,height-60)
					if(debug_mode) then friendsreg:highlight(0.35) end
					if (use_highest_atk_companion == false) then
						friendsreg:existsClick(friend,0)
						if(debug_mode) then getLastMatch():highlight(0.2) ; runlog("Companion : Standard", true) end
					else
						findComp = regionFindAllNoFindException(friendsreg,friend)
						for i,u in ipairs(findComp) do
							findCompReg = Region(u:getX()+37,u:getY(),112,35)
							if (debug_mode) then findCompReg:highlight(0.15) end
							compATK, returnval = numberOCRNoFindException(findCompReg,"gil")
							if (returnval) then
								if(debug_mode) then runlog("CompATK :"..compATK,true) end
								if (compATK > highestATK) then
									highestATK = compATK
									highestATKBtn = u
								end
							end
						end
						click (highestATKBtn)
					end
					func_state = 0
				elseif(friendsreg ~= nil and friendsreg:exists(friend,0)) then
					if (use_highest_atk_companion == false) then
						friendsreg:existsClick(friend,0)
						if(debug_mode) then friendsreg:getLastMatch():highlight(0.2) ; runlog("Companion : Standard", true) end
					else
						findComp = regionFindAllNoFindException(friendsreg,friend)
						for i,u in ipairs(findComp) do
							findCompReg = Region(u:getX()+37,u:getY(),112,35)
							if (debug_mode) then findCompReg:highlight(0.15) end
							compATK, returnval = numberOCRNoFindException(findCompReg,"gil")
							if (returnval) then
								if(debug_mode) then runlog("CompATK :"..compATK,true) end
								if (compATK > highestATK) then
									highestATK = compATK
									highestATKBtn = u
								end
							end
						end
						click (highestATKBtn)
					end
					func_state = 0
				elseif(top_reg:exists(no_companion,0)) then
					tempbtn = top_reg:getLastMatch()
					if(debug_mode) then getLastMatch():highlight(0.2) ; runlog("No Companions", true) end
					click(tempbtn)
					func_state = 0
				else
					if(debug_mode) then runlog("Warning : Unknown Companion", true) end
					click(Location(300,350*aRatio))
					click(tempbtn)
					func_state = 0
				end
			end
			
			-- depart handler
			if(func_state == 31 or bottom_reg:exists(departbtn,0)) then
				if (func_state ~= 31) then
					func_state = 31
					if (buttonreg[departbtn] == nil) then
						wait(0.7+lagx/2) -- wait for animation
					else
						wait(0.1)
					end
				elseif(existsClickL(departbtn,0)) then
					if(debug_mode) then getLastMatch():highlight(0.2) ; runlog("Depart Button : ") 	end
					departed = true
					func_state = 0
				end
			end
			
--			if (exists(connection_error,0)) then 
--				if(debug_mode) then runlog("\tconnection error.") end
--				if(existsClick(connect_ok, lagx/2) and debug_mode) then runlog("\tconnect_ok") end
--			end
		else	-- departed is true

			usePreviousSnap(false)
			if (exists(lapis,0)) then
				usePreviousSnap(true)
			end

			if existsL(unitdatachanged,0) then
				if(debug_mode) then runlog("Depart failed - unit data changed") 	end
				departed = false
				existsClick(connect_ok, 0)
				wait (0.5+lagx/3)
			elseif (existsL(connection_error,0)) then 
				if(debug_mode) then runlog("Connection Error") end
				if(existsClickL(connect_ok, 0) and debug_mode) then runlog("Pressed Ok") end
				break
			elseif (not existsL(lapis,0)) then
				if(debug_mode) then runlog("Departed : ") 	end
				break
			end
		end
	end

	--toast("depart "..getLastMatch():getScore())
--	wait(0.25+0.25*lagx+0.5*lagc)

	--moved waiting for connection here
	while(true) do
		usePreviousSnap(false)
		if(existsL(menuinbattle,lagx/3)) then break end
		usePreviousSnap(true)
		if(existsL(menu,0)) then break end
		connectionCheckNoWait()
	end
	
	if(string.match(location,"_exploration") or string.match(location,"custom_")) then explore2(location)
	elseif(location=="enchanted_maze") then enchantedMaze()
	elseif(location=="earth_shrine_exit") then esLBFarm()
	elseif(use_esper_battle==true) then battleEsper()
	else
		battleAuto()
	end
	resultsExit() -- handle results screen
end

function go(loc,steps)
	steps = steps or 1
	move_counter = move_counter + 1
	if(step_mode==2) then  -- always single step
		if(steps > 100) then
			if(debug_mode) then runlog("Going "..loc.." "..(steps/100).." steps",true) end
			for i=1,steps/100 do --convert to single steps
				if (not findMove() and not (existsL(menu,0))) then break
				elseif(move_counter >= enable_bosscheck_counter and top_reg:exists(sense_hostile,0)) then break end
				click((_G[loc])[2])
				wait(0.1+math.max(0,(lagx-1)/3))
			end
			usePreviousSnap(false)
--			wait(0.25+lagx/2)
			if((not findMove()) and not (existsL(menu,0))) then 
				exploreBattle()
				if(exists(revive,0)) then return end
				if (move_counter >= enable_bosscheck_counter) then
					move_counter = move_counter - 1
					go(loc,steps)
				else
					move_counter = move_counter - 1
					go(loc,steps-math.max(0,i-3))
				end
			elseif(move_counter >= enable_bosscheck_counter and top_reg:exists(sense_hostile,0.4+lagx/2)) then bossBattle()
			else
				go(loc,steps-math.max(0,i-2))
			end
		else
			if (not findMove() and not (bottom_reg:exists(menu,0))) then exploreBattle() end
			for i=1,steps do
				if(debug_mode) then runlog("Step #"..i.." of "..steps,true) end
				if(alt_step) then click((_G[loc])[2]) ; wait(0.1)
				else
					setDragDropTiming(100,20)
					dragDrop(center,(_G[loc])[1])
				end
				wait(0.1+math.max(0,(lagx-1)/3))
				if(move_counter >= enable_bosscheck_counter and top_reg:exists(sense_hostile,0.4+lagx/2)) then bossBattle()
				elseif(not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(exists(revive,0)) then return end end
			end
		end
	else -- swiping
		if(steps > 20) then -- swiping for ms
			--toast("Going "..loc.." "..steps.."ms")
			setDragDropTiming(100,steps)
			if(debug_mode) then runlog("Going "..loc.." "..steps.."ms",true) end
			dragDrop(center,_G[loc][1])
			wait(0.1+math.max(0,(lagx-1)/5))
			if(move_counter >= enable_bosscheck_counter and top_reg:exists(sense_hostile,0.4+lagx/2)) then bossBattle()
			elseif(not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(exists(revive,0)) then return end ; move_counter = move_counter - 1 ; go(loc,steps) end
		else
			if (not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(exists(revive,0)) then return end end
			for i=1,steps do -- single step click
				if(debug_mode) then runlog("Step #"..i.." of "..steps,true) end
				if(alt_step) then click((_G[loc])[2]) ; wait(0.1)
				else
					setDragDropTiming(100,20)
					dragDrop(center,(_G[loc])[1])
				end
				wait(0.1+math.max(0,(lagx-1)/3))
				if(move_counter >= enable_bosscheck_counter and top_reg:exists(sense_hostile,0.3+lagx/2)) then bossBattle()
				elseif (not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(existsL(revive,0)) then return end end
			end
		end
	end
end

function colosseumBattle()
	local home = Pattern("homeico.png")
	local col = Pattern("colosseum.png")
	local col_h = Pattern("colosseum_h.png")
	local enter = Pattern("colosseum_enter.png")
	local cbattle = backbtn:targetOffset(240,130) -- first colosseum rank
	local fight = Pattern("colosseum_fight.png")
	local no_orbs = Pattern("no_colosseum_orbs.png")
	local col_won = Pattern("colosseum_won.png")
	local home_bottom = Pattern("home_bottom.png")
	local world = Pattern("world.png")
	local world_h = Pattern("world_h.png")
	
	top_reg:existsClick(home); wait(3+(2*lagx))
	bottom_reg:existsClick(col); bottom_reg:existsClick(col_h); wait(3+(2*lagx))
	existsClick(enter); wait(3+(2*lagx))
	for i=0,2 do
		if(exists(no_orbs)) then 
			existsClick(nobtn);wait(3+(2*lagx)); break
		else
			click(cbattle); wait(3+(2*lagx)); click(cbattle); wait(3+(2*lagx))
			existsClick(fight); wait(3+(2*lagx))
			if(exists(no_orbs)) then existsClick(nobtn);wait(3+(2*lagx)); break end
			existsClick(autobtn,3)
			for i=0,45 do
				wait(2)
				existsClick(col_won)
				existsClick(connect_ok) -- Cleared reward
				existsClick(closebtn) -- Daily quest finish
				if(exists(backbtn)) then break end
				connectionCheck()
			end
		end
	end
	colosseumTimer:set() --reset colosseum timer
	bottom_reg:existsClick(home_bottom,1*lagx); wait(3+(2*lagx))
	if(not exists(world)) then bottom_reg:existsClick(home_bottom,1*lagx); wait(3+(2*lagx)) end
	existsClick(world); existsClick(world_h); wait(3+(2*lagx))
	click(center); wait(3+(2*lagx))
end

function gameOver()
	local giveup = Pattern("giveupnow.png")

	usePreviousSnap(false)
	if(exists(revive,lagx/2)) then 
		if (continue_on_gameover) then
			existsClick(nobtn); wait(1+(2*lagx)) 
		else
			scriptExit("Game Over")
		end
	end
	if(exists(giveup,lagx/2)) then existsClick(yesbtn); wait(2+(2*lagx)); gameover_count = gameover_count + 1 end
end

function gameOverNoWait()
	local giveup = Pattern("giveupnow.png")
	
	if(existsL(revive,0)) then 
		if (continue_on_gameover) then
			existsClick(nobtn)
		else
			scriptExit("Game Over")
		end
	end
	if(exists(giveup,0)) then existsClick(yesbtn) ; gameover_count = gameover_count + 1 end
end

function explore2(location)
	battle_counter = 0
	move_counter = 0
	bosses_encountered = 0
	finished_explore = false
	
	if (goldcheck_success == false) then gold_reg = nil end
	
	while(true) do
		connectionCheck()
		if(exists(menu,1)) then break end
	end
	if(debug_mode) then runlog("Explore start",true) end
--	toast("Waiting few moments before starting "..location)
	wait(lagx/4)
	
--	always_findmove = false

	findMove()
	
	for i,v in pairs(getPath(explorePath[location])) do
		if(finished_explore) then	break end
		if(exists(revive,0)) then return end
		
		if(v:split(",")[1]=="battle") then -- find battle
			if(loot) then findBattle(v:split(",")[2],tonumber(v:split(",")[3]),v:split(",")[4]) end
		elseif(v:split(",")[1]=="battleex") then -- find battleEx
			if(loot) then findBattleEx(v:split(",")[2],tonumber(v:split(",")[3]),tonumber(v:split(",")[4]),tonumber(v:split(",")[5]),v:split(",")[6]) end
		elseif(v:split(",")[1]=="findmove") then toast("Hello!") -- update position
		elseif(v:split(",")[1]=="wait") then 
			if(debug_mode) then runlog("Wait "..(tonumber(v:split(",")[2]) * (1+lagx/4)).." ms",true) end
			wait((tonumber(v:split(",")[2]) * (1+lagx/4))/1000) -- wait a while
		elseif(v:split(",")[1]=="transition") then 
			if(debug_mode) then runlog("Transition "..(tonumber(v:split(",")[2]) * (1+lagx/4)).." ms",true) end
			wait((tonumber(v:split(",")[2]) * (1+lagx/4))/1000) -- wait a while
			while (true) do
				if (exists(menu,0)) then break end
				if (findMove()) then break end
			end
		elseif(v:split(",")[1]=="leaveafterboss") then
--			if(debug_mode) then runlog("Leaving after boss",true) end		
			leave_after_boss = true -- leave after boss battle
		elseif(v:split(",")[1]=="bosscheck") then 
--			if(debug_mode) then runlog("Boss checks after move : "..tonumber(v:split(",")[2]),true) end				
			enable_bosscheck_counter = tonumber(v:split(",")[2]) -- boss check counter
		elseif(v:split(",")[1]=="ur" or v:split(",")[1]=="ul" or v:split(",")[1]=="dr" or v:split(",")[1]=="dl") then
			if(tonumber(v:split(",")[2])>20) then
				if(step_mode==2 or move_counter >= enable_bosscheck_counter or tonumber(v:split(",")[2])<1200) then
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.70+(lagx*0.30))))
				elseif(tonumber(v:split(",")[2])<3500) then
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.35+(lagx*0.16))))
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.35+(lagx*0.16))))
				else
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.235+(lagx*0.11))))
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.235+(lagx*0.11))))
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.235+(lagx*0.11))))
				end
			else
				go(v:split(",")[1],tonumber(v:split(",")[2]))  -- single steps
			end
		else
--			if (debug_mode) then runlog(v,true) end
			if(tonumber(v:split(",")[2])>20) then
--				if(step_mode==2 or move_counter >= enable_bosscheck_counter or tonumber(v:split(",")[2])<4000) then
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.70+(lagx*0.30))))
--				elseif(tonumber(v:split(",")[2])<7500) then
--					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.35+(lagx*0.16))))
--					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.35+(lagx*0.16))))
--				else
--					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.235+(lagx*0.11))))
--					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.235+(lagx*0.11))))
--					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.235+(lagx*0.11))))
	--			end
			else
				go(v:split(",")[1],tonumber(v:split(",")[2]))  -- single steps
			end
		end
	end
	finishExplore()
end

function esLBFarm()
	for i=0,60000 do
		if(i%5==0) then connectionCheck() end
		if(exists(autobtn)) then 
			if(debug_mode) then runlog("autobtn") end
			wait(2); click(getLastMatch():offset(135,-660 * aRatio)); click(getLastMatch()) -- single target a mob then auto
		end
		if(top_reg:exists(results_big)) then break end -- battle done
	end
end

function battleChoice(unittype)
	local Esper = Pattern("SB_Esper.png")
	local BackButton = Pattern("backbutton.png"):similar(0.8)

	if (unittype == "esper") then				-- ESPER only
		if(SB_reg:existsClick(Esper,lagx/5)) then 
			if (debug_mode) then runlog("Esper click : ") end
			return true
		else
			SB_reg:existsClick(BackButton,0)
			return false
		end
	else
		local Limit = Pattern("SB_LBFilled.png")
		local Sword = Pattern("SB_Sword.png")
		local Break = Pattern("SB_Break.png")
		local Blast = Pattern("SB_Blast.png")
	--	local Aero = Pattern("SB_Aero.png")
		local Shot = Pattern("SB_Shot.png")
		local Curaja = Pattern("SB_Curaja.png")
	--	local Fire = Pattern("SB_Fire.png")
	--	local Blizzard = Pattern("SB_Blizzard.png")
	--	local Thunder = Pattern("SB_Thunder.png")
	--	local Holy = Pattern("SB_Holy.png")
	--	local Dark = Pattern("SB_Dark.png")
	--	local Drain = Pattern("SB_Drain.png")
	--	local Stone = Pattern("SB_Stone.png")
	--	local Water = Pattern("SB_Water.png")
	--	local Poison = Pattern("SB_Poison.png")
		local Buff = Pattern("SB_Buff.png")
		local Steal = Pattern("SB_Steal.png")
	--	local Kick = Pattern("SB_Kick.png")
		local Cover = Pattern("SB_Cover.png")
		local Damage1 = Pattern("SB_Damage1.png")
		local Damage2 = Pattern("SB_Damage2.png")
		local NoLB = Pattern("SB_NoLB.png"):similar(0.5)
		local InsufficientMP = Pattern("SB_InsufficientMP.png"):similar(0.7)
		local CantEvoke = Pattern("SB_CantEvoke.png"):similar(0.5)	
	end
	
	if (unittype == "healer") then
		if(not SB_reg:existsClick(Limit,0)) then
			usePreviousSnap(true)
			if (debug_mode) then runlog("no limit") end
			if (not SB_reg:exists(NoLB,0)) then
				if (debug_mode) then runlog("error unit healer") end
				return false
			elseif (not SB_reg:exists(CantEvoke,0)) then
				SB_reg:existsClick(Esper,0)
			else
				if (debug_mode) then runlog("no esper") end
				usePreviousSnap(false)
				dragDrop(Location(300,830 * aRatio), Location(300,(650 - math.random(220)) * aRatio))
				wait (1.2+lagx/2)
				if (SB_reg:exists(InsufficientMP,0)) then 
					SB_reg:existsClick(BackButton,0)
					return false
				elseif (not SB_reg:existsClick(Curaja,0)) then
					usePreviousSnap(true)
					if (not SB_reg:existsClick(Buff,0)) then
						if (not SB_reg:existsClick(Damage1,0)) then
							if (not SB_reg:existsClick(Damage2,0)) then
								while (true) do
									if (not SB_reg:exists(BackButton,0)) then break end
									click(Location(math.random(10,550 * aRatio),math.random(550,855 * aRatio)))
									wait(0.2)
									dragDrops(Location(300,750 * aRatio), Location(300,(850 - math.random(200)) * aRatio))
									usePreviousSnap(false)
								end
							end
						end
					else
						wait(lagx/4)
						click(Location(math.random(10,550),math.random(550*aRatio,855*aRatio)))
					end
				else
					wait(lagx/4)
					click(Location(math.random(10,550),math.random(550*aRatio,855*aRatio)))
				end
			end
		end
	elseif (unittype == "physdamage") then
		if(not SB_reg:existsClick(Limit,0.1)) then 
			usePreviousSnap(true)
			SB_reg:existsClick(Esper,0)
			usePreviousSnap(false)
			wait(0.2)
			if (exists(BackButton,0)) then
				usePreviousSnap(false)
				dragDrop(Location(getLastMatch():getX()-width/2,getLastMatch():getY()-100), Location(getLastMatch():getX()-width/2,getLastMatch():getY() - 150 - math.random(height/2 * aRatio)))
				wait (0.8+lagx/2)
				if (SB_reg:exists(InsufficientMP,lagx/5)) then 
					SB_reg:existsClick(BackButton,0)
					usePreviousSnap(false)
					return false
				end
				usePreviousSnap(true)
				if (not SB_reg:existsClick(Damage2,0)) then
					if (not SB_reg:existsClick(Damage1,0)) then
						SB_reg:existsClick(BackButton,0)
						usePreviousSnap(false)
						return false
					end
				end
			end
		end
	end
	
	usePreviousSnap(false)
	wait(0.2)
	SB_reg:existsClick(BackButton,0)
	return true
end

function battleAuto()
	local tempi = 0

	while(true) do
		tempi = tempi + 1
		usePreviousSnap(false)
		if(existsClickL(autobtn,lagx/4) and debug_mode) then runlog("Auto : ") end
		usePreviousSnap(true)
		if(tempi%19==0) then connectionCheckNoWait() end
		if(tempi%17==0 and existsL(revive,0)) then break end
		if(top_reg:exists(results_big,0)) then click(getLastMatch()) ; click(center) ; break end
		if(existsL(questclear,0)) then break end
		if(not existsL(menuinbattle,0)) then break end
	end
	usePreviousSnap(false)

end

function battleEsper()
	local tempi = 0
	local esperfilled = Pattern("SB_EsperFilled.png"):similar(0.7)
	local IsReady = Pattern("SB_MyTurn.png")
	--boss = (boss or false)
	local auto_pressed = false

	while(true) do
		tempi = tempi + 1
		usePreviousSnap(false)
		if (right_reg:exists(esperfilled,lagx/5)) then
			if (debug_mode) then getLastMatch():highlight(0.2); runlog("\tEsper - ") end
			if (not existsClickL(autoonbtn,0)) then
				usePreviousSnap(true)
				if (exists(IsReady,0)) then
					auto_pressed = false
					dragDrop(Location(getLastMatch():getX()+20,getLastMatch():getY()+30),Location(getLastMatch():getX()+250,getLastMatch():getY()+30))
					wait(0.1+lagx/4)
					usePreviousSnap(false)
					battleChoice("esper")
					existsClickL(autobtn,lagx/5+0.1)
				end
			end
			usePreviousSnap(false)
		elseif (tempi > 0 and tempi%49 == 0) then
			auto_pressed = false
		else
			if(not auto_pressed and existsClickL(autobtn,0)) then 
				if (debug_mode) then getLastMatch():highlight(0.2); runlog("\tAuto - ") end
				auto_pressed = true
			elseif (not auto_pressed and existsL(autoonbtn,0)) then
				if (debug_mode) then getLastMatch():highlight(0.2); runlog("\tAuto is on ") end
				auto_pressed = true			
			end
		end
		if(existsL(results,0)) then
			if(debug_mode) then getLastMatch():highlight(0.2) ; runlog("Result screen") end
			click(getLastMatch())
		end
		usePreviousSnap(true)
		if(bottom_reg:exists(menu,0) or top_reg:exists(battle_won,0) or top_reg:exists(battle_won2,0) or top_reg:exists(continue_ask,0)) then break end
		if(tempi%17==0 and exists(revive,0)) then break end
		if(top_reg:exists(results_big,0)) then click(getLastMatch()) ; click(center) ; click(Location(300,890 * aRatio)) ; break end
		if(exists(questclear,0)) then break end
		if(not existsL(menuinbattle,0)) then break end
	end
	usePreviousSnap(false)
end

function smartBattle()
	local tempi = 0
	local num_turns = 0
	local BackButton = Pattern("backbutton.png"):similar(0.8)
	local IsReady = Pattern("SB_MyTurn.png")
	local unit1Error = 0
	local unit2Error = 0
	local unit3Error = 0
	local unit4Error = 0
	local unit5Error = 0
	local unit6Error = 0
	local findUnit = nil

	usePreviousSnap(false)
--	unit1_reg = Region(8,555,286,100)
--	unit2_reg = Region(8,665,286,100)
--	unit3_reg = Region(8,775,286,100)
--	unit4_reg = Region(304,555,286,100)
--	unit5_reg = Region(304,665,286,100)
--	unit6_reg = Region(304,775,286,100)

	while (true) do
		tempi = tempi + 1
		usePreviousSnap(false)
		if(top_reg:exists(results_big,lagx/2)) then click(center) ; click(Location(300,890 * aRatio)) ; break end
		usePreviousSnap(true)
		if(tempi%10==0 and exists(revive,0)) then break end
		if(tempi%13==0) then connectionCheckNoWait() end
		if(exists(questclear,0)) then break end
		
		-- If we accidentaly Libra'd
		existsClick(closebtn,0)
		
		-- If we somehow stuck
		SB_reg:existsClick(BackButton,0)
		
		if(SB_reg:existsClick(autoonbtn,0)) then 
			if (debug_mode) then runlog("Auto off", true) end
		elseif(not SB_reg:exists(IsReady,0)) then 
			if (debug_mode) then runlog("Waiting for turn...", true) end
		elseif not (num_turns%4 == 0) and math.random(100) > 3 and existsClick(repeatbtn,0) then
			num_turns = num_turns + 1
			if (debug_mode) then runlog("Repeating last action.", true) end
		elseif num_turns > 0 and math.random(100) > 98 and SB_reg:existsClick(autobtn,0) then
			num_turns = num_turns + 1
			if (debug_mode) then runlog("Auto.", true) end
		elseif(SB_reg:exists(autobtn,0)) then 
			if (debug_mode) then runlog("smart choice", true) end
			
			findUnit = findAllNoFindException(IsReady)
			for i,u in ipairs(findUnit) do
				dragDrop(Location(u:getX()+10,u:getY()+20),Location(u:getX()+190,u:getY()+20))
				wait(0.3+lagx/3)
				battleChoice("physdamage")
			end
			
			SB_reg:existsClick(BackButton,0.2)
			num_turns = num_turns + 1
			SB_reg:existsClick(autobtn,1+lagx/3)
		end
		wait(0.1+lagx/10)
	end
	usePreviousSnap(false)
end

-- Check version of AnkuLua first.
ALver, ALpro = getALVer()

--toast(ALver)
--if ALpro then toast("Pro") end
	
dialogInit()
farmList = {}

for i,v in pairs(farm) do
	farmList[#farmList+1] = i
end
for i,v in pairs(custom) do
	farmList[#farmList+1] = v
end

addTextView("Farm location:")
addSpinner("farmloc",farmList,"earth_shrine_entrance")
newRow()
addCheckBox("loot", "Find Battle?", false)
if (ALpro) then addCheckBox("dimscreen", "Dim screen?", false) else dimscreen = false end
newRow()
--addCheckBox("colosseumsched", "Colosseum Schedule? **BETA**", false)
--newRow()
addCheckBox("debug_mode", "Debug mode?", false)
addCheckBox("refill", "Refill Energy?", false)
newRow()
addCheckBox("continue_on_gameover", "Retry on GameOver (No Lapis)?", true)
newRow()
addTextView("Companion mode :")
addRadioGroup("comp_mode", 1)
addRadioButton("Any", 1)
addRadioButton("Use Bonus", 2)
addRadioButton("Highest ATK", 3)
newRow()
addTextView("Battle mode :")
addRadioGroup("battle_mode", 1)
addRadioButton("Auto (Default)", 1)
addRadioButton("Use Espers", 2)
newRow()
addTextView("Swipe mode")
addRadioGroup("trace_mode",1)
addRadioButton("1 (Preferred)",1)
addRadioButton("2 (Alternative)",2)
--addRadioButton("3",3)
newRow()
addTextView("Use Click for step:")
addRadioGroup("step_mode",1)
addRadioButton("Single (Preferred)",1)
addRadioButton("Always (Slow)",2)
newRow()
addTextView("Device Lag multiplier:")
addEditNumber("lagx",1.3)
newRow()
addTextView("Depart count (99999 for infinite) :")
addEditNumber("max_depart_count",99999)
newRow()
addCheckBox("help_screen", "Show help?", false)
--addTextView("Network Lag multiplier:")
--addEditNumber("lagc",1.1)

dialogShow(ver)

if (help_screen) then
	dialogInit()
	addTextView("Welcome to ffbeAuto Z Help Screen")
	if (ALver > "6.8.0") then
		addSeparator()
		addSeparator()
	else
		newRow()
		newRow()
	end
	addTextView("First thing first, turn off any Superuser toast messages in your superuser app.")	
	newRow()
	addTextView("If you're using a device, make sure the screen stays awake. This can be done via developer options or other methods.")	
	newRow()
	addTextView("Please reposition the play button somewhere safe, like in the upper leftmost region of the screen.")	
	newRow()
	addTextView("Always start from quest selection screen.")	
	newRow()
	addTextView("Use a reasonable Device Lag Multiplier, minimum 1.0 for high end devices, adjust with device performance.")	
	newRow()
	addTextView("Please note that emulators needs a higher Lag Multiplier due to the inherent choppiness to be safe.")	
	if (ALver > "6.8.0") then
		addSeparator()
		addSeparator()
	else
		newRow()
		newRow()
	end
	addTextView("Thank you and enjoy.")	
	dialogShow("Help")
	scriptExit("Help Finished")
end

config_log = "\nApp Screen size: "..screen:getX().."x"..screen:getY().."\tr_x: "..r_x.."\tr_y: "..r_y.."\tr_w: "..r_w.."\tr_h: "..r_h..":\nTask: "..farmloc.."\nFind Battle: "..tostring(loot).."\nDim: "..tostring(dimscreen).."\nRefill: "..tostring(refill).."\nSwipe mode: "..trace_mode.."\nStep mode: "..step_mode.."\nLagx: "..lagx

if(trace_mode == 1) then
	setDragDropStepCount(50)
	setDragDropStepInterval(1)
	setDragDropTiming(100,20)
elseif(trace_mode == 2) then
	setDragDropStepCount(100)
	setDragDropStepInterval(0.1)
	setDragDropTiming(100,20)
elseif(trace_mode == 3) then
	setDragDropStepCount(100)
	setDragDropStepInterval(1)
	setDragDropTiming(100,20)
end

if(debug_mode) then config_log:save("run.log") end
if(dimscreen) then setBrightness(0) end --dim screen only on pro
if(bonus_unit_menu) then use_bonus_unit = true end
if(battle_mode == 2) then use_esper_battle = true end
if(comp_mode == 2) then use_bonus_unit = true end
if(comp_mode == 3) then use_highest_atk_companion = true end

if(farmloc == "dungeon_finder") then selectDungeon() -- get custom dungeon location
elseif(farmloc == "free_farm") then freeFarm() end 

if (max_depart_count == 99999) then toast("Infinite Depart") end

if (height >= width) then aRatio = (height / width) / 1.6					-- Aspect ratio correction from 960 height 600 width which is 1.6 ratio
else aRatio = (width / height) / 1.6
end

while true do
	depart_count = depart_count + 1
	if (ALver >= "6.6.0") then setStopMessage("Task : "..farmloc.."\n\nDepart : "..depart_count.."\nGame Over : "..gameover_count.."\nLapis Refill : "..lapis_refill_count) end
	if (debug_mode) then runlog("Depart #"..depart_count, true) end
	fFarm(farmloc)
	if (max_depart_count ~= 99999 and depart_count >= max_depart_count) then scriptExit("Finished") end
end