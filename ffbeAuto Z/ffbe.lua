-- Final Fantasy Brave Exvius: ffbeAuto -  Farming & Exploration
-- by tinotk modded by Sikat
-- Memu 960x600 120dpi
-- Nox
-- http://ankulua.boards.net/thread/167/brave-exvius-ffbeauto-farming-explorations

ver = "ffbeAuto Z13"
ALver = "0"															-- AnkuLua version string
ALpro = true														-- is this AnkuLua a Pro and not trial?

Settings:setCompareDimension(true, 600)
Settings:setScriptDimension(true, 600)
setImmersiveMode(true)

exploration = Pattern("exploration.png"):similar(0.5)
autobtn = Pattern("auto.png"):similar(0.9)
autoonbtn = Pattern("AutoOn.png"):similar(0.8)
repeatbtn = Pattern("SB_Repeat.png"):similar(0.7)
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
giveup = Pattern("giveupnow.png")
esperfilled = Pattern("SB_EsperFilled.png"):similar(0.7)
IsReady = Pattern("SB_MyTurn.png"):similar(0.73)
BackButton = Pattern("backbutton.png"):similar(0.8)
boss = Pattern("bossbattle.png"):similar(0.6)
battle_transition = Pattern("battle_transition.png"):similar(0.75)

buttonreg = { }									-- universal table for button regions learning
buttonreg_learned = { }							-- boolean to set if button is learned. Useful if you want to set button regions manually first then let the script refine it

-- Manually set regions
buttonreg[results_big] = Region(120,30,360,320) -- two locations for results big. Do not learn.
buttonreg[revive] = Region(50,80,495,435)
buttonreg[giveup] = Region(50,80,495,435)
buttonreg[closebtn] = Region(10,225,580,550) -- closebtn multiple locations. Do not learn.
buttonreg[connection_error] = Region(30,340,545,320)
buttonreg[connect_ok] = Region(30,340,545,320)
buttonreg[no_request] = Region(5,635,290,165)
buttonreg[esperfilled] = Region(540,440,60,180)
buttonreg[yesbtn] = Region(5,80,590,760)		-- yesbtn is used in multiple locations. Do not learn.
buttonreg[boss] = Region(0,40,300,440)
buttonreg[battle_transition] = Region(350,80,250,360)

-- Set fixed buttons
buttonreg_learned[results_big] = true
buttonreg_learned[yesbtn] = true
buttonreg_learned[closebtn] = true

findMoveReg = nil
findMoveSet = false
findMoveX = 999999
findMoveY = 999999
findMoveX2 = 0
findMoveY2 = 0
friendsreg = nil
friendsBONUSreg = nil

lagx = 1.0										-- Device lag multiplier value. 1.0 for high end devices.
help_screen = false
use_bonus_unit = false
use_highest_atk_companion = false
companion_used = false							-- True if we successfully used a companion.
use_esper_battle = false
use_smart_battle = false
use_smart_battle_2nd = true
use_smart_battle_2nd_round = 3
use_smart_battle_boss = true
use_smart_battle_boss_2nd = true
use_smart_battle_boss_companion = true
use_smart_battle_boss_companion_2nd = true
use_smart_battle_boss_companion_mp = 30
use_smart_battle_boss_companion_2nd_mp = 30
continue_on_gameover = true
goldcheck_success = false						-- Has gold check ever successful?
leave_after_boss = false						-- Exploration value - leave after boss instead of continuing.
finished_explore = false						-- Used in conjunction of leave after boss to break all exploration functions.
depart_count = 0								-- Count for departing.
max_depart_count = 99999
gameover_count = 0
lapis_refill_count = 0
alt_step=true									-- Deprecated. Always true now. If false will replace single steps with 100ms swipes.
gold_reg = nil									-- Region for gold check in exploration farming
tempbtn = nil									-- Temporary button storage
battle_counter = 0								-- Battle counter in explorations including farming.
move_counter = 0								-- Total move counter in explorations not including farming.
enable_bosscheck_counter = 20					-- When to enable bosscheck on explorations, will be adjusted automatically after a successful run
bosses_encountered = 0							-- When, if, there are explorations with multiple bosses.
screen = getAppUsableScreenSize()
width = screen:getX(); height = screen:getY()
left_reg = Region(0,0,300,1200)
right_reg = Region(300,0,600,1200)
top_reg = Region(0,0,600,480)
bottom_reg = Region(0,480,600,600)
control_reg = Region(0,550,600,520)
debug_reg = Region(40,0,495,35)					-- region to which the script writes debug texts.
r_x = width/4; r_y = height/4; r_w = width/2; r_h = height/2
mid_reg = Region(r_x,r_y,r_w,r_h)
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
step_mode = 1									-- LEGACY options
trace_mode = 1									-- LEGACY options

top = Location(300,150)
bottom = Location(300,750)
rain = {Pattern("rain_up.png"):similar(0.9),Pattern("rain_down.png"):similar(0.9),Pattern("rain_left.png"):similar(0.9),Pattern("rain_right.png"):similar(0.9),
		Pattern("rain_ul.png"):similar(0.9),Pattern("rain_ur.png"):similar(0.9),Pattern("rain_dl.png"):similar(0.9),Pattern("rain_dr.png"):similar(0.9)}

sb_skills = {}
sb_skills["None"] = false
sb_skills["Katana"] = Pattern("SB_Sword.png")
sb_skills["Sword"] = Pattern("SB_Break.png")
sb_skills["Blast"] = Pattern("SB_Blast.png"):similar(0.7)
sb_skills["Aero"] = Pattern("SB_Aero.png")
sb_skills["Shot"] = Pattern("SB_Shot.png")
sb_skills["Cure"] = Pattern("SB_Curaja.png")
sb_skills["Fire"] = Pattern("SB_Fire.png")
sb_skills["Blizzard"] = Pattern("SB_Blizzard.png")
sb_skills["Thunder"] = Pattern("SB_Thunder.png")
sb_skills["Holy"] = Pattern("SB_Holy.png")
sb_skills["Dark"] = Pattern("SB_Dark.png")
sb_skills["Drain"] = Pattern("SB_Drain.png")
sb_skills["Stone"] = Pattern("SB_Stone.png")
sb_skills["Water"] = Pattern("SB_Water.png")
sb_skills["Poison"] = Pattern("SB_Poison.png")
sb_skills["Buff"] = Pattern("SB_Buff.png")
sb_skills["Cheer"] = Pattern("SB_Cheer.png")
sb_skills["Steal"] = Pattern("SB_Steal.png")
sb_skills["Kick"] = Pattern("SB_Kick.png")
sb_skills["Ultima"] = Pattern("SB_Ultima.png")
sb_skills["Provoke"] = Pattern("SB_Provoke.png")
sb_skills["Dance"] = Pattern("SB_Dance.png")
sb_skills["Sing"] = Pattern("SB_Sing.png")
sb_skills["Elements"] = Pattern("SB_Elements.png")
sb_skills["Status"] = Pattern("SB_Status.png"):similar(0.7)
sb_skills["Meteor"] = Pattern("SB_Meteor.png")
sb_skills["Cover (Noctis)"] = Pattern("SB_Cover.png")

-- Not in table
SB_MP = Pattern("SB_MP.png"):similar(0.7)
SB_Raise = Pattern("SB_Raise.png"):similar(0.7)
SB_Damage = {Pattern("SB_Damage1.png"):similar(0.7),Pattern("SB_Damage2.png"):similar(0.7)}

sb_skilluse = {}										-- Skill to use
sb_skillmp = {}											-- MP match
sb_skilluse2 = {}										-- Skill to use
sb_skillmp2 = {}										-- MP match
sb_skilluse_boss = {}									-- Skill to use on boss
sb_skillmp_boss = {}									-- MP match on boss
sb_skilluse_boss2 = {}									-- Skill to use on boss
sb_skillmp_boss2 = {}									-- MP match on boss
sb_regunit = {}											-- unit 1 to 6 specific regions
sb_regunit_num = 0										-- If the party isn't full
sb_reg = nil											-- Region for the entire controls

special_farm = {}
special_farm["dungeon_finder"] = Location(0,0)
special_farm["free_farm"] = exploration
special_farm["earth_shrine_entrance_speedmode"] = Pattern("earth_shrine_entrance.png")
		
-- List of dungeons other than special functions

farm = {}
farm["earth_shrine_entrance"] = Pattern("earth_shrine_entrance.png")
farm["earth_shrine_exit"] = Pattern("earth_shrine_exit.png")
farm["earth_shrine_exploration"] = Pattern("earth_shrine_exploration.png")
farm["phantom_forest_exploration"] = Pattern("phantom_forest_exploration.png")
farm["fulan_pass_exploration"] = Pattern("fulan_pass_exploration.png")
farm["maranda_coast_exploration"] = Pattern("maranda_coast_exploration.png")
farm["wolfsfang_peak_exploration"] = Pattern("wolfsfang_peak_exploration.png")
farm["dwarves_forge_exploration"] = Pattern("dwarves_forge_exploration.png")
--farm["dalnakya_cavern_harvest_exploration"] = Pattern("dalnakya_cavern_harvest.png")
farm["water_shrine_exploration"] = Pattern("water_shrine_exploration.png")
farm["wind_shrine_exploration"] = Pattern("wind_shrine_exploration.png")
farm["fire_shrine_exploration"] = Pattern("fire_shrine_exploration.png")
farm["invincible_interior_exploration"] = Pattern("invincible_interior_exploration.png")
farm["enchanted_maze_BGN"] = Pattern("enchanted_maze_BGN.png")
--farm["orbonne_monastery_vault_exploration"] = Pattern("vault_explore.png")

-- Exploration paths.

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

function pairsByKeys (t, f)
	local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable

    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end

    return iter
    end

function getALVer()
	local ALstring = getVersion()
	local pro = false

	if string.match(ALstring, "pro") then pro = true end

	local temp = ALstring:split("-")
	return temp[1],pro
end

-- existsClick function with self-learning capabilities. Will store button regions for faster searching next time.
-- Warning : USE ONLY with buttons that are always located in one location. Otherwise use the standard function or define region manually first, then set buttonreg_learned[obj] to true.

function existsClickL(obj, howLong)
	
	local returnval = false
	local safetyMargin = 15
	local tX = 0
	local tY = 0
	local tW = 0
	local tH = 0

	if not howLong then howLong = 0 end
	
	if (not buttonreg_learned[obj]) then
		if (existsClick(obj, howLong)) then
			returnval = true
			tX = getLastMatch():getX()
			tY = getLastMatch():getY()
			tW = getLastMatch():getW()
			tH = getLastMatch():getH()
			buttonreg[obj] = Region(tX-safetyMargin,tY-safetyMargin,tW+safetyMargin*2,tH+safetyMargin*2)
			buttonreg_learned[obj] = true
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

-- exists function with self-learning capabilities. Will store button regions for faster searching next time.
-- Warning : USE ONLY with buttons that are always located in one location. Otherwise use the standard function or define region manually first, then set buttonreg_learned[obj] to true.

function existsL(obj, howLong)
	
	local returnval = false
	local safetyMargin = 15
	local tX = 0
	local tY = 0
	local tW = 0
	local tH = 0

	if not howLong then howLong = 0 end
	
	if (not buttonreg_learned[obj]) then
		if (exists(obj, howLong)) then
			returnval = true
			tX = getLastMatch():getX()
			tY = getLastMatch():getY()
			tW = getLastMatch():getW()
			tH = getLastMatch():getH()
			buttonreg[obj] = Region(tX-safetyMargin,tY-safetyMargin,tW+safetyMargin*2,tH+safetyMargin*2)
			buttonreg_learned[obj] = true
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

--Find Rain's position on explorations. Returns false if fails to find any.

function findMove()
	local center = nil
	usePreviousSnap(false)

	for i=1,#rain do 
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
		if(debug_mode) then runlog("Rain not found",true) end
		return false
	end
	return true
end

function selectDungeon()
	toast("Finding available dungeon...")
	dungeonList = regionFindAllNoFindException(left_reg,dungeon)
--	dungeonList = findAllNoFindException(dungeon)
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

-- Random exploration mode only executed when pathing fails. Better than just staying there doing nothing.

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
		if (existsL(revive,0)) then break end
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

-- Old findBattle function, preserved for compatibility.

function findBattle(loot_direction,limit,exit_direction)

	-- store optimization variables
	local lastEnableBossCheck = enable_bosscheck_counter
	local lastMoveCounter = move_counter
	local locBattleCount = 0
	local lapsWithoutBattle = 0

	-- no bosscheck
	enable_bosscheck_counter = 100000
		
	for i=0, 100 do 
		if(existsL(revive,0)) then return end
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

-- New findbattle function.

function findBattleEx(loot_direction,limit,battle_limit,run_length,exit_direction)

	-- store optimization variables
	local lastEnableBossCheck = enable_bosscheck_counter
	local lastMoveCounter = move_counter
	local locBattleCount = 0
	local lapsWithoutBattle = 0

	-- no bosscheck
	enable_bosscheck_counter = 100000
		
	for i=0, 100 do 
		if(existsL(revive,0)) then return end
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
		
	-- restore optimization variables
	enable_bosscheck_counter = lastEnableBossCheck
	move_counter = lastMoveCounter
	
end

-- Gold check function for exploration farming.

function checkGold(limit)
	local gold
	local returnval = false
	
	usePreviousSnap(false)

	for i=1,20 do
		existsClickL(menu,lagx/4)
		wait(lagx/8+0.1)
		if(existsL(gold_coin,lagx/4)) then

--			if(debug_mode) then runlog("Gold coin exists",true) end

			if(gold_reg == nil) then 
				gold_reg = Region(getLastMatch():getX()+40,getLastMatch():getY()+1,135,41*aRatio)
				if(debug_mode) then gold_reg:save("gold_reg.png") end
			else
				if(debug_mode) then gold_reg:highlight(0.25) end
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

-- Handles all result screen shenanigans, including Game Over, Dailies, Rank ups, Companion request buttons.

function resultsExit()
	local numfunc = 6

	if(debug_mode) then runlog("Results exit start",true) end

	-- Handle all the connection stuff and gameovers first.
	for i=0, 3000000 do
		usePreviousSnap(false)
		if(existsClickL(results_big,0)) then break end		
		usePreviousSnap(true)
		if (i%5 == 0) then
			connectionCheckNoWait()
		elseif (i%5 == 1) then
			if(existsL(backbtn,0)) then break end		
		elseif (i%5 == 2) then
			if(existsL(lapis,0)) then break end
		elseif (i%5 == 3) then
			if(existsL(revive,0)) then gameOver(); break end
		elseif (i%5 == 4) then
			if(existsL(giveup,0)) then gameOver(); break end
		end
	end

	-- Then do the clicking
	
	for i=0, 3000000 do
		usePreviousSnap(false)
		if(existsL(backbtn,0)) then break end
		usePreviousSnap(true)
		existsClickL(results_big,0)
		
		if ((existsClickL(nextbtn,0)) and debug_mode) then
			runlog("Next 1")
		elseif ((existsClickL(nextbtn2,0)) and debug_mode) then
			runlog("Next 2")
		elseif ((existsClickL(next_mission,0)) and debug_mode) then
			runlog("Next 3")
		elseif (i%numfunc == 1 and existsClickL(rank_up,0) and debug_mode) then
			runlog("Rank Up")
		elseif (i%numfunc == 3 and existsClickL(closebtn,0) and debug_mode) then
			runlog("Close Button")
		elseif (i%numfunc == 5 and existsClickL(no_request,0) and debug_mode) then
			runlog("No Request")
		end

	end

	usePreviousSnap(false)

	if(debug_mode) then  
		runlog("Results exit done",true)
	else
--		toast("Results exit done")
	end
end

-- Handles battle scenes in explorations

function exploreBattle()
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
		if(existsClickL(results,0)) then
			if(debug_mode) then runlog("Result screen") end
		elseif (use_esper_battle and existsL(esperfilled,0)) then
			if (debug_mode) then getLastMatch():highlight(0.2); runlog("Esper Ready : ") end
			if (not existsClickL(autoonbtn,0)) then
				if (bottom_reg:exists(IsReady,lagx/3)) then
					findUnit = findAllNoFindException(IsReady)

					for i,u in ipairs(findUnit) do
						dragDrop(Location(u:getX()+10,u:getY()+20),Location(u:getX()+190,u:getY()+20))
						wait(0.15+lagx/4)
						if (battleChoice("esper")) then break end
					end
					
					existsClickL(autobtn,lagx/5+0.1)
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
		if(not existsL(menuinbattle,0)) then break end
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

	if(existsL(revive,0)) then return end

	for i=0,900000 do
		click(center)
		usePreviousSnap(false)
		existsClickL(explore_leave,0)
		usePreviousSnap(true)
		existsClickL(explore_yes,0)
		if(existsL(results_big,0)) then break end
		if(existsL(dungeon_clear,0)) then break end
		if(i%49 == 0 and i > 0 and findMove()) then rain_found = rain_found + 1 end
		if(rain_found > 5) then toast("Leave failed!") ; break end
		connectionCheckNoWait()
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
		usePreviousSnap(false)
		existsClickL(explore_yes,0)
		usePreviousSnap(true)
		if(existsL(menuinbattle,0)) then 
			if (use_smart_battle) then
				smartBattle() ; break
			else
				exploreBattle(); break
			end 
		end
		if(existsL(revive,0)) then return end
	end

	usePreviousSnap(false)

	if (bosses_encountered == 0 and enable_bosscheck_counter+4 <= move_counter) then enable_bosscheck_counter = move_counter - 3 end
	
	bosses_encountered = bosses_encountered + 1

	for i=0,30000 do
		if(existsL(revive,0)) then return end
--		usePreviousSnap(false)
		existsClickL(battle_won,0)
--		usePreviousSnap(true)
		existsClickL(battle_won2,0)
		if (leave_after_boss) then
			finished_explore = true
			existsClickL(explore_leave,0)
			break
		elseif(existsClickL(explore_continue,0)) then break end
		if(existsL(menu,0)) then break end
		if(existsL(revive,0)) then return end
	end

	usePreviousSnap(false)

end

function finishExplore()


	if(existsL(revive,0)) then return end

	if(not finished_explore and existsL(sense_hostile)) then 
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
	if(existsL(connection_error, lagx/4)) then 
		if(debug_mode) then runlog("Connection error") end
		if(existsClickL(connect_ok, lagx/4) and debug_mode) then runlog("Connect attempt") end
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
	local lvbegin = Pattern("enchanted_maze_begin.png")
	local lv1 = Pattern("enchanted_maze_lv1.png")
	local lv2 = Pattern("enchanted_maze_lv2.png")
	local lv3 = Pattern("enchanted_maze_lv3.png")
	local lv4 = Pattern("enchanted_maze_lv4.png")
	local lv5 = Pattern("enchanted_maze_lv5.png")
	local lvexit = Pattern("enchanted_maze_exit.png")

	battle_counter = 0
	move_counter = 0
	bosses_encountered = 0
	enable_bosscheck_counter = 100
	
	if (debug_mode) then runlog("Enchanted maze start",true) end

	while(true) do
		if(existsL(lvbegin)) then
			if (debug_mode) then runlog("Enchanted maze begin",true) end
			go("up",3500+lagx*1000)
		end
		if(existsL(lv1)) then
			if (debug_mode) then runlog("Enchanted maze Lv.1",true) end
			go("up",3500+lagx*1000)
		end
		if(existsL(lv2)) then 
			if (debug_mode) then runlog("Enchanted maze Lv.2",true) end
			go("up",3500+lagx*1000) 
		end
		if(existsL(lv3)) then 
			if (debug_mode) then runlog("Enchanted maze Lv.3",true) end
--			go("up",1)
--			go("right",1)
			go("up",3500+lagx*500)
			go("left",3)
			go("up",1000+lagx*500)
		end
		if(existsL(lv4)) then
			if (debug_mode) then runlog("Enchanted maze Lv.4",true) end
--			go("up",1)
--			go("left",1)
			go("up",3500+lagx*500)
			go("right",3)
			go("up",1000+lagx*500)
		end
		if(existsL(lv5)) then
			if (debug_mode) then runlog("Enchanted maze Lv.5",true) end
			go("up",1000+lagx*500)
			go("left",3000+lagx*1000)
			go("up",3000+lagx*1000)
		end
		if(existsL(lvexit)) then
			if (debug_mode) then runlog("Enchanted maze exit",true) end
			go("up",4)
			break
		end
		if(existsL(results_big)) then 
			break
		end
	end
	
	if (debug_mode) then runlog("Enchanted maze done",true) end
end

-- earth shrine entrance SPEED mode. Ignores as much as possible to make it speedy.
-- One big self contained function.

function ese_speed(location)
	local func_state = 0
	local departed = false
	local unit1 = 1
	local unit2 = 3
	
	while (true) do
		if (departed == false) then 
		
			usePreviousSnap(false)
			if (existsL(lapis,0)) then
				usePreviousSnap(true)
			end

			if(existsClickL(special_farm["earth_shrine_entrance_speedmode"],0) and debug_mode) then runlog("Selected",true) end
					
			--out of energy handler
			if(func_state == 12 or existsL(no_nrg,0)) then 
				func_state = 12
				if(debug_mode) then runlog("Out of energy") end
				if(refill) then 
					toast("Burning lapis..."); if(debug_mode) then runlog("Refill lapis") end
					existsClickL(refill_lapis,0); 
					if (existsClickL(yesbtn,0)) then wait(lagx*0.3) ; func_state = 0  ; lapis_refill_count = lapis_refill_count + 1 end
				elseif (bottom_reg:existsClick(backbtn,0)) then -- DIFFERENT POSITION than the usual top left. Do NOT use learning.
					func_state = 0
					math.randomseed(os.time()); toast(waitmsg[math.random(#waitmsg)].. " now... Come back later."); wait(35+lagx*math.random(1,35))
				end
			end

			-- next button
			if(existsL(backbtn,0)) then 
				if(existsClickL(next_i,0) and debug_mode) then runlog("Next!", true) end
			end
		
			-- companion handler
			if(func_state == 21 or top_reg:exists(companion,0)) then				 -- DO NOT LEARN BUTTON LOC with this, as it may learn the button when it is still flying!
				if (func_state ~= 21) then
					func_state = 21
					if (friendsreg == nil) then
						wait(1.75) -- wait for animation
					else
					end
				elseif(friendsreg == nil and exists(friend,0)) then
					friendsreg = Region(getLastMatch():getX()-15,80,getLastMatch():getW()+90,height-60)
					if(debug_mode) then friendsreg:highlight(0.35) end
					friendsreg:existsClick(friend,0)
					if(debug_mode) then runlog("Companion : Standard", true) end
					func_state = 0
				elseif(friendsreg ~= nil and friendsreg:exists(friend,0)) then
					friendsreg:existsClick(friend,0)
					if(debug_mode) then friendsreg:getLastMatch():highlight(0.2) ; runlog("Companion : Standard", true) end
					func_state = 0
				elseif(top_reg:exists(no_companion,0)) then
					tempbtn = top_reg:getLastMatch()
					if(debug_mode) then getLastMatch():highlight(0.2) ; runlog("No Companions", true) end
					click(tempbtn)
					func_state = 0
				else
					if(debug_mode) then runlog("Warning : Unknown Companion", true) end
					click(Location(300,480))
					func_state = 0
				end
			end
			
			-- depart handler
			if(func_state == 31 or bottom_reg:exists(departbtn,0)) then     -- DO NOT LEARN BUTTON LOC with this, as it may learn the button when it is still flying!
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
			
		else	-- departed is true

			usePreviousSnap(false)
			if (existsL(lapis,0)) then
				usePreviousSnap(true)
			end
				-- handle the unit data changed error
			if existsL(unitdatachanged,0) then
				if(debug_mode) then runlog("Depart failed - unit data changed") 	end
				departed = false
				existsClickL(connect_ok, 0)
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

	--waiting for connection here
	while(true) do
		usePreviousSnap(false)
		if(existsL(menuinbattle,0)) then break end
		usePreviousSnap(true)
		if(existsL(menu,0)) then break end
		connectionCheckNoWait()
	end

	--create regions
	while(sb_reg == nil) do
		defineSBreg()
	end
	
    --battle functions
	while(existsL(menuinbattle,0)) do
		click(Location(sb_regunit[unit1]:getX() + sb_regunit[unit1]:getW()/2, sb_regunit[unit1]:getY() + (sb_regunit[unit1]:getH()/2)))		
		click(Location(sb_regunit[unit2]:getX() + sb_regunit[unit2]:getW()/2, sb_regunit[unit2]:getY() + (sb_regunit[unit2]:getH()/2)))		
	end

	-- Handle all the connection stuff and gameovers first.
	for i=0, 3000000 do
		usePreviousSnap(false)
		if(existsClickL(results_big,0)) then break end		
		usePreviousSnap(true)
		connectionCheckNoWait()
	end

	-- Then do the clicking
	
	for i=0, 3000000 do
		usePreviousSnap(false)
		if(existsL(backbtn,0)) then break end
		usePreviousSnap(true)
		existsClickL(results_big,0)
		
		if ((existsClickL(nextbtn,0)) and debug_mode) then
			runlog("Next 1")
		elseif ((existsClickL(nextbtn2,0)) and debug_mode) then
			runlog("Next 2")
		elseif ((existsClickL(next_mission,0)) and debug_mode) then
			runlog("Next 3")
		elseif (i%7 == 4 and existsClickL(rank_up,0) and debug_mode) then
			runlog("Rank Up")
		elseif (i%7 == 6 and existsClickL(closebtn,0) and debug_mode) then
			runlog("Close Button")
		elseif ((i%5 == 2 or buttonreg[no_request] ~= nil) and existsClickL(no_request,0) and debug_mode) then
			runlog("No Request")
		end

	end

	usePreviousSnap(false)
end

-- Main function for everything dungeons, explorations, vortexes, and raids.
-- Always assume start from mission selection screen.

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
	
	companion_used = false
	
	while (true) do
		if (departed == false) then 

			wait(0.1+lagx/10)
			
			usePreviousSnap(false)
			if (existsL(lapis,0)) then
				usePreviousSnap(true)
			end

			if(string.match(location,"custom_")) then 
				if(existsClickL(exploration,0) and debug_mode) then runlog("Custom Exploration",true) end
				tempbtn = getLastMatch()
			elseif(location=="dungeon_finder") then
				--toast("Custom dungeon")
				if (left_reg:exists(dungeon,0)) then
					click(farm[location])
					tempbtn = farm[location]
					if(debug_mode) then runlog("Dungeon Finder",true) end
				end
			else
				if(location=="orbonne_monastery_vault_exploration") then dragDrop(bottom,top);wait(3);dragDrop(bottom,top) end --swipe to vault explore section
				if(existsClickL((farm[location]),0) and debug_mode) then runlog("Selected",true) end
				tempbtn = getLastMatch()
			end
					
			--out of raid orbs handler
			if(func_state == 11 or existsL(insufficient_raid_orbs,0)) then 
				func_state = 11
				if(debug_mode) then runlog("Out of raid orbs") end
				if(refill) then 
					toast("Burning lapis..."); if(debug_mode) then runlog("Refill lapis") end
					existsClickL(refill_lapis,0)
					if (existsClickL(yesbtn,0)) then wait(lagx*0.3) ; func_state = 0 ; lapis_refill_count = lapis_refill_count + 1 end
				elseif(existsClickL(raid_orbs_no,0)) then
					func_state = 0
					math.randomseed(os.time()); toast(waitmsg[math.random(#waitmsg)].. " now... Come back way later."); wait(90+lagx*3*math.random(1,4)*math.random(1,30))
				end
			end

			--out of energy handler
			if(func_state == 12 or existsL(no_nrg,0)) then 
				func_state = 12
				if(debug_mode) then runlog("Out of energy") end
				if(refill) then 
					toast("Burning lapis..."); if(debug_mode) then runlog("Refill lapis") end
					existsClickL(refill_lapis,0); 
					if (existsClickL(yesbtn,0)) then wait(lagx*0.3) ; func_state = 0  ; lapis_refill_count = lapis_refill_count + 1 end
				elseif (bottom_reg:existsClick(backbtn,0)) then -- DIFFERENT POSITION than the usual top left. Do NOT use learning.
					func_state = 0
					math.randomseed(os.time()); toast(waitmsg[math.random(#waitmsg)].. " now... Come back later."); wait(35+lagx*math.random(1,35))
				end
			end

			-- next button
			if(existsL(backbtn,0)) then 
				if(existsClickL(next_i,0) and debug_mode) then runlog("Next!", true) end
			end
		
			-- companion handler
			if(func_state == 21 or exists(companion,0)) then				 -- DO NOT LEARN BUTTON LOC with this, as it may learn the button when it is still flying!
				if (func_state ~= 21) then
					func_state = 21
					if ((use_bonus_unit == true and friendsBONUSreg == nil) and (friendsreg == nil)) then
						wait(0.7 + lagx * 0.5) -- wait for animation
					else
						wait(0.2 + lagx * 0.2)
					end
				elseif use_bonus_unit == true and friendsBONUSreg == nil and left_reg:exists(bonus_unit,0.5+lagx*0.8) then			-- BONUS! image pulses, soooo needs time.
					tempbtn = left_reg:getLastMatch()
					friendsBONUSreg = Region(tempbtn:getX()-30,120,tempbtn:getW()+60,1000)
					if(debug_mode) then friendsBONUSreg:highlight(0.35) ; runlog("Companion : Bonus", true) end
					click(tempbtn)
					companion_used = true
					func_state = 0
				elseif use_bonus_unit == true and friendsBONUSreg ~= nil and friendsBONUSreg:existsClick(bonus_unit,(lagx*1.3)+0.9) then								-- BONUS! image pulses, soooo needs time.
					if(debug_mode) then runlog("Companion : Bonus", true) end
					companion_used = true
					func_state = 0
				elseif(friendsreg == nil and exists(friend,0)) then
					friendsreg = Region(getLastMatch():getX()-15,80,getLastMatch():getW()+30,height-60)
					if(debug_mode) then friendsreg:highlight(0.35) end
					if (use_highest_atk_companion == false) then
						friendsreg:existsClick(friend,0)
						companion_used = true
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
						companion_used = true
						click (highestATKBtn)
					end
					func_state = 0
				elseif(friendsreg ~= nil and friendsreg:exists(friend,0)) then
					if (use_highest_atk_companion == false) then
						friendsreg:existsClick(friend,0)
						companion_used = true
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
						companion_used = true
						click (highestATKBtn)
					end
					func_state = 0
				elseif(top_reg:exists(no_companion,0)) then
					tempbtn = top_reg:getLastMatch()
					if(debug_mode) then getLastMatch():highlight(0.2) ; runlog("No Companions", true) end
					click(tempbtn)
					companion_used = false
					func_state = 0
				else
					if(debug_mode) then runlog("Warning : Unknown Companion", true) end
					click(Location(300,350*aRatio))
					click(tempbtn)
					companion_used = false
					func_state = 0
				end
			end
			
			-- depart handler
			if(func_state == 31 or bottom_reg:exists(departbtn,0)) then     -- DO NOT LEARN BUTTON LOC with this, as it may learn the button when it is still flying!
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
			
		else	-- departed is true

			usePreviousSnap(false)
			if (existsL(lapis,0)) then
				usePreviousSnap(true)
			end
				-- handle the unit data changed error
			if existsL(unitdatachanged,0) then
				if(debug_mode) then runlog("Depart failed - unit data changed") 	end
				departed = false
				existsClickL(connect_ok, 0)
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

	--waiting for connection here
	while(true) do
		usePreviousSnap(false)
		if(existsL(menuinbattle,lagx/3)) then break end
		usePreviousSnap(true)
		if(existsL(menu,0)) then break end
		connectionCheckNoWait()
	end
	
	if(string.match(location,"_exploration") or string.match(location,"custom_")) then explore2(location)
	elseif(location=="enchanted_maze_BGN") then enchantedMaze()
	elseif(use_smart_battle==true) then smartBattle()
	elseif(use_esper_battle==true) then battleEsper()
	else
		battleAuto()
	end
	resultsExit() -- handle results screen
end

-- Go x ms or steps in what direction function for explorations.

function go(loc,steps)
	steps = steps or 1
	move_counter = move_counter + 1
	if(step_mode==2) then  -- always single step
		if(steps > 100) then
			if(debug_mode) then runlog("Going "..loc.." "..(steps/100).." steps",true) end
			for i=1,steps/100 do --convert to single steps
				if (not findMove() and not (existsL(menu,0))) then break
				elseif(move_counter >= enable_bosscheck_counter and existsL(sense_hostile,0)) then break end
				click((_G[loc])[2])
				wait(0.1+math.max(0,(lagx-1)/3))
			end
			usePreviousSnap(false)
--			wait(0.25+lagx/2)
			if((not findMove()) and not (existsL(menu,0))) then 
				exploreBattle()
				if(existsL(revive,0)) then return end
				if (move_counter >= enable_bosscheck_counter) then
					move_counter = move_counter - 1
					go(loc,steps)
				else
					move_counter = move_counter - 1
					go(loc,steps-math.max(0,i-3))
				end
			elseif(move_counter >= enable_bosscheck_counter and existsL(sense_hostile,0.4+lagx/2)) then bossBattle()
			else
				go(loc,steps-math.max(0,i-2))
			end
		else
			if (not findMove() and not (existsL(menu,0))) then exploreBattle() end
			for i=1,steps do
				if(debug_mode) then runlog("Step #"..i.." of "..steps,true) end
				if(alt_step) then click((_G[loc])[2]) ; wait(0.1)
				else
					setDragDropTiming(100,20)
					dragDrop(center,(_G[loc])[1])
				end
				wait(0.1+math.max(0,(lagx-1)/3))
				if(move_counter >= enable_bosscheck_counter and existsL(sense_hostile,0.4+lagx/2)) then bossBattle()
				elseif(not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(existsL(revive,0)) then return end end
			end
		end
	else -- swiping
		if(steps > 20) then -- swiping for ms
			--toast("Going "..loc.." "..steps.."ms")
			setDragDropTiming(100,steps)
			if(debug_mode) then runlog("Going "..loc.." "..steps.."ms",true) end
			dragDrop(center,_G[loc][1])
			wait(0.1+math.max(0,(lagx-1)/5))
			if(move_counter >= enable_bosscheck_counter and existsL(sense_hostile,0.4+lagx/2)) then bossBattle()
			elseif(not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(existsL(revive,0)) then return end ; move_counter = move_counter - 1 ; go(loc,steps) end
		else
			if (not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(existsL(revive,0)) then return end end
			for i=1,steps do -- single step click
				if(debug_mode) then runlog("Step #"..i.." of "..steps,true) end
				if(alt_step) then click((_G[loc])[2]) ; wait(0.1)
				else
					setDragDropTiming(100,20)
					dragDrop(center,(_G[loc])[1])
				end
				wait(0.1+math.max(0,(lagx-1)/3))
				if(move_counter >= enable_bosscheck_counter and existsL(sense_hostile,0.3+lagx/2)) then bossBattle()
				elseif (not findMove() and not (existsL(menu,0))) then exploreBattle() ; if(existsL(revive,0)) then return end end
			end
		end
	end
end

-- Handles game over events. To be called from resultsExit().

function gameOver()
	usePreviousSnap(false)
	if(existsL(revive,lagx/2)) then 
		if (continue_on_gameover) then
			existsClickL(nobtn); wait(0.5+(1.2*lagx)) 
		else
			scriptExit("Game Over")
		end
	end
	if(existsL(giveup,lagx/2)) then existsClickL(yesbtn); wait(1+(1.25*lagx)); gameover_count = gameover_count + 1 end
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
	wait(lagx/4)
	
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
			if(tonumber(v:split(",")[2])>20) then
					go(v:split(",")[1],(tonumber(v:split(",")[2])*(0.70+(lagx*0.30))))
			else
				go(v:split(",")[1],tonumber(v:split(",")[2]))  -- single steps
			end
		end
	end
	finishExplore()
end

-- I guess this is only useful for "esper" for now.

function battleChoice(unittype)
	local Esper = Pattern("SB_Esper.png")

	if (unittype == "esper") then				-- ESPER only
		if(control_reg:existsClick(Esper,lagx*0.2)) then 
			if (debug_mode) then runlog("Esper click : ") end
			return true
		else
			control_reg:existsClick(BackButton,0)
			return false
		end
	end
	
	usePreviousSnap(false)
	wait(0.2)
	control_reg:existsClick(BackButton,0)
	return true
end

-- Auto Battle, the standard way in dungeons.

function battleAuto()
	local tempi = 0

	while(true) do
		tempi = tempi + 1
		usePreviousSnap(false)
		if(existsClickL(autobtn,lagx/4) and debug_mode) then runlog("Auto : ") end
		usePreviousSnap(true)
		if(tempi%19==0) then connectionCheckNoWait() end
		if(tempi%17==0 and existsL(revive,0)) then break end
		if(existsL(results_big,0)) then break end
		if(existsL(questclear,0)) then break end
		if(not existsL(menuinbattle,0)) then break end
	end
	usePreviousSnap(false)

end

-- Dungeon battle with Esper enabled.

function battleEsper()
	local tempi = 0
	--boss = (boss or false)
	local auto_pressed = false

	while(true) do
		tempi = tempi + 1
		usePreviousSnap(false)
		if (existsL(esperfilled,lagx/5)) then
			if (debug_mode) then getLastMatch():highlight(0.2); runlog("\tEsper - ") end
			if (not existsClickL(autoonbtn,0)) then
				usePreviousSnap(true)
				if (bottom_reg:exists(IsReady,0)) then
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
			if(debug_mode) then runlog("Result screen") end
			click(getLastMatch())
		end
		usePreviousSnap(true)
		if(existsL(menu,0) or existsL(battle_won,0) or existsL(battle_won2,0) or existsL(continue_ask,0)) then break end
		if(tempi%17==0 and exists(revive,0)) then break end
		if(existsL(results_big,0)) then click(getLastMatch()) ; click(center) ; click(Location(300,890 * aRatio)) ; break end
		if(existsL(questclear,0)) then break end
		if(not existsL(menuinbattle,0)) then break end
	end
	usePreviousSnap(false)
end

-- New function smart battle will select skills.
-- choose function for smartBattle
-- Needs to have regions defined first

function smartBattle_choose(skilluse, skillmp)
	for i=1, (#sb_regunit-1) do
		if (debug_mode) then sb_regunit[i]:highlight(0.2) end
		if (skilluse[i] == "None") then
		elseif (sb_regunit[i]:exists(IsReady,lagx*0.75)) then
			skillToUse = sb_skills[skilluse[i]]
			skillSuccess = false
			skillTries = 0
			if (debug_mode) then runlog("Unit #"..i.." action. Skill : "..skilluse[i].." - MP : "..skillmp[i], true) end
			setDragDropStepCount(50)
			setDragDropStepInterval(1)
			setDragDropTiming(100,20)
			dragDrop(Location(sb_regunit[i]:getX() + 15, sb_regunit[i]:getY() + (sb_regunit[i]:getH()/2)), Location(sb_regunit[i]:getX() + sb_regunit[i]:getW() - 15, sb_regunit[i]:getY() + (sb_regunit[i]:getH()/2)))
			setDragDropStepCount(145+lagx*75)
			setDragDropStepInterval(1)
			setDragDropTiming(100,400+lagx*50)
			wait(0.2+lagx*0.25)
			while(true) do
				if (skillSuccess) then
					break
				elseif (skillTries > 4) then
					if (debug_mode) then runlog("Exists Click Back",true) end
					if (existsClick(BackButton, 0)) then wait(0.25+lagx*0.35) ; break end
				elseif (sb_reg:exists(skillToUse, 0)) then
					usePreviousSnap(true)
					findSkills = regionFindAllNoFindException(sb_reg,skillToUse)
					for n, m in ipairs(findSkills) do
						if (debug_mode) then m:highlight(0.2) end
						mp_reg = Region(m:getX(), m:getY()+m:getH()*0.8, 60,55*aRatio)
						if (debug_mode) then mp_reg:highlight(0.2) end								
						mp, retval = numberOCRNoFindException(mp_reg,"mp")
						if (retval and debug_mode) then runlog("MP found : "..mp,true) end								
						if (retval and mp == skillmp[i]) then
							click(m)
							skillSuccess = true
							if (skilluse[i] == "Cure" or skilluse[i] == "Buff" or skilluse[i] == "Sing" or skilluse[i] == "Dance" or skilluse[i] == "Elements" or skilluse[i] == "Cover (Noctis)") then
								wait(0.05+lagx*0.05)
								click(Location(sb_regunit[i]:getX() + sb_regunit[i]:getW()/2, sb_regunit[i]:getY() + (sb_regunit[i]:getH()/2)))
							end
							wait(0.2+lagx*0.25)
							break
						end								
					end
					
					if (not skillSuccess) then
						if (debug_mode) then runlog("Found not successful.",true) end
						dragDrop(Location( sb_reg:getX()+sb_reg:getW()/2 , sb_reg:getY()+sb_reg:getH()-33 ) , Location( sb_reg:getX()+sb_reg:getW()/2 , sb_reg:getY()+25 ) ) 
						wait(0.1+lagx*0.15)
						usePreviousSnap(false)
						skillTries = skillTries + 1
					end
					
				else
					if (debug_mode) then runlog("Not found.",true) end
					dragDrop(Location(sb_reg:getX()+sb_reg:getW()/2,sb_reg:getY()+sb_reg:getH()-33 ), Location(sb_reg:getX()+sb_reg:getW()/2,sb_reg:getY()+25))
					wait(0.1+lagx*0.15)
					usePreviousSnap(false)
					skillTries = skillTries + 1
				end
			end
		end
	end

	usePreviousSnap(false)
	setDragDropStepCount(50)
	setDragDropStepInterval(1)
	setDragDropTiming(100,20)

end

-- New function smart battle will select skills for companions.
-- Needs to have regions defined first
-- Just select based on minimum MP. Finds first skill with more than x MP. Then check if it's a Raise or not damage.

function smartBattle_companion(skillmp)
	local selection = nil
	local selectionmp = 0
	local checkValue = 0				-- add all MPs found in a formula and if it's the same then quit (we reached the end of the skill list)
	local checkValue_last = 12345

	if (companion_used == false) then return end 					-- don't use when unit is less than 6.
	
	
	i = #sb_regunit
	if (debug_mode) then sb_regunit[i]:highlight(0.2) end
	
	usePreviousSnap(false)
	if (sb_regunit[i]:exists(IsReady,lagx*0.75)) then
		skillSuccess = false
		skillTries = 0
		if (debug_mode) then runlog("Unit #"..i.." action. MP : "..skillmp, true) end
		setDragDropStepCount(50)
		setDragDropStepInterval(1)
		setDragDropTiming(100,20)
		dragDrop(Location(sb_regunit[i]:getX() + 15, sb_regunit[i]:getY() + (sb_regunit[i]:getH()/2)), Location(sb_regunit[i]:getX() + sb_regunit[i]:getW() - 15, sb_regunit[i]:getY() + (sb_regunit[i]:getH()/2)))
		usePreviousSnap(false)
		setDragDropStepCount(145+lagx*75)
		setDragDropStepInterval(1)
		setDragDropTiming(100,400+lagx*50)
		wait(0.2+lagx*0.25)
		while(true) do
			if (skillSuccess) then
				break
			elseif (sb_reg:exists(SB_MP, 0)) then
				usePreviousSnap(true)
				checkValue = 0
				findSkills = regionFindAllNoFindException(sb_reg,SB_MP)
				for n, m in ipairs(findSkills) do
					if (debug_mode) then m:highlight(0.2) end
					mp_reg = Region(m:getX()+m:getW(), m:getY()-10, 75,m:getH()+20)
					if (debug_mode) then mp_reg:highlight(0.2) end								
					mp, retval = numberOCRNoFindException(mp_reg,"mp")
					if (retval and debug_mode) then runlog("MP found : "..mp,true) end								
					if (retval and mp >= skillmp) then
						icon_reg = Region(m:getX()-20, m:getY()-90, 100,100)
						text_reg = Region(m:getX()-20, m:getY()-90, 290,100)
						if (debug_mode) then icon_reg:highlight(0.2) ; text_reg:highlight(0.2) end														
						if (icon_reg:exists(SB_Raise,0)) then                    -- Skills to NEVER use, i.e Raise type.
							if (debug_mode) then runlog("Exists Raise",true) end														
						else							
							for t=1,#SB_Damage do 
								if(text_reg:exists(SB_Damage[t],0) and mp > selectionmp) then 
									if(debug_mode) then runlog("Select this.", true) end
									selection = text_reg:getLastMatch()
									selectionmp = mp
									skillSuccess = true
									break
								end
							end
						end
					elseif (retval) then
						checkValue = checkValue + mp*n
					end					
				end

				if (skillSuccess) then 
					click(selection)
					wait(0.2+lagx*0.25)
					-- ALWAYS self click to be safe from cure/buff/sing skills etc.
					click(Location(sb_regunit[i]:getX() + sb_regunit[i]:getW()/2, sb_regunit[i]:getY() + (sb_regunit[i]:getH()/2)))
					wait(0.05+lagx*0.05)
					break 
				elseif (skillTries > 5 or checkValue == checkValue_last) then
					if (debug_mode) then runlog("Exists Click Back",true) end
					wait(0.05+lagx*0.05)
					if (existsClick(BackButton, 0)) then wait(0.25+lagx*0.35) ; break end
				else
					if (debug_mode) then runlog("Found not successful.",true) end
					dragDrop(Location(sb_reg:getX()+sb_reg:getW()/2 , sb_reg:getY()+sb_reg:getH()-33 ) , Location( sb_reg:getX()+sb_reg:getW()/2 , sb_reg:getY()+25 ) ) 
					wait(0.1+lagx*0.15)
					usePreviousSnap(false)
					skillTries = skillTries + 1
				end				
				checkValue_last = checkValue
			else
				if (debug_mode) then runlog("Not found.",true) end
				dragDrop(Location(sb_reg:getX()+sb_reg:getW()/2,sb_reg:getY()+sb_reg:getH()-33 ), Location(sb_reg:getX()+sb_reg:getW()/2,sb_reg:getY()+25))
				wait(0.1+lagx*0.15)
				usePreviousSnap(false)
				skillTries = skillTries + 1
			end
		end
	end

	usePreviousSnap(false)
	setDragDropStepCount(50)
	setDragDropStepInterval(1)
	setDragDropTiming(100,20)
end

-- Define Regions first

function defineSBreg()
	local rX = 99999
	local rY = 99999
	local rX2 = 0
	local rY2 = 0
	local foundUnit = 0
		
	if (bottom_reg:exists(IsReady,lagx/3)) then
		usePreviousSnap(true)
		findUnit = regionFindAllNoFindException(left_reg,IsReady)
		for i,u in ipairs(findUnit) do
			if (debug_mode) then u:highlight(0.2); runlog("Unit #"..i.." Match : "..u:getScore(), true) end
			sb_regunit[i] = Region(u:getX()-10,u:getY()-10,295,115)
			if (debug_mode) then sb_regunit[i]:highlight(0.2) end
			if (rX > u:getX()) then rX = u:getX() end
			if (rY > u:getY()) then rY = u:getY() end
			if (rX2 < (u:getX() + u:getW())) then rX2 = u:getX()+u:getW() end
			if (rY2 < (u:getY() + u:getH())) then rY2 = u:getY()+u:getH() end
			sb_regunit_num = sb_regunit_num + 1
		end
		foundUnit = sb_regunit_num
		findUnit = regionFindAllNoFindException(right_reg,IsReady)
		for i,u in ipairs(findUnit) do
			if (debug_mode) then u:highlight(0.2); runlog("Unit #"..(i+foundUnit).." Match : "..u:getScore(), true) end
			sb_regunit[i+foundUnit] = Region(u:getX()-10,u:getY()-10,295,115)
			if (debug_mode) then sb_regunit[i+foundUnit]:highlight(0.2) end
			if (rX > u:getX()) then rX = u:getX() end
			if (rY > u:getY()) then rY = u:getY() end
			if (rX2 < (u:getX() + u:getW())) then rX2 = u:getX()+u:getW() end
			if (rY2 < (u:getY() + u:getH())) then rY2 = u:getY()+u:getH() end
			sb_regunit_num = sb_regunit_num + 1
		end
		sb_reg = Region(rX, rY, rX2-rX+263, rY2-rY+(103))
		if (debug_mode) then sb_reg:highlight(0.2) end
	end
	usePreviousSnap(false)
end

-- Main smartBattle function

function smartBattle()
	local findUnit = nil
	local findSkills = nil
	local skillToUse = nil
	local mp = 0
	local mp_reg = nil
	local retval = false
	local skillSuccess = false
	local skillTries = 0
	local state = 0
	local round = 0
	local boss_found = false
	local boss_battle_check_delay = 0

	while(sb_reg == nil) do
		defineSBreg()
	end

	while(true) do
		usePreviousSnap(false)
		if (existsL(boss,0.25+lagx*0.25+boss_battle_check_delay)) then boss_found = true end
		while (boss_battle_check_delay > 0 and not boss_found) do
			usePreviousSnap(false)
			if (existsL(boss,0.25+lagx*0.25+boss_battle_check_delay)) then boss_found = true end
			usePreviousSnap(true)
			if(sb_reg:exists(IsReady,0)) then boss_battle_check_delay = 0 end
		end
		usePreviousSnap(true)
		if(existsL(revive,0)) then break end
		if(not existsL(menuinbattle,0)) then break end
		if(sb_reg:exists(IsReady,0)) then
			usePreviousSnap(false)
			if(state == 0) then		-- 0-9 are states for first smart battle handling
				wait(0.1)
				smartBattle_choose(sb_skilluse, sb_skillmp)
				wait(0.05+lagx*0.05)
				existsClickL(autobtn,0)
				wait(0.15+lagx*0.15)
				existsClickL(autoonbtn,0)
				state = 9
				round = 1
			elseif(state == 9) then
				usePreviousSnap(true)
				if(use_smart_battle_boss and (boss_found)) then
					state = 20
				elseif(use_smart_battle_2nd and round >= use_smart_battle_2nd_round) then
					state = 10
				else
					existsClickL(repeatbtn,0)
					round = round + 1
				end
			elseif(state == 10) then									-- 10-19 for 2nd smart battle
				wait(0.1)
				smartBattle_choose(sb_skilluse2, sb_skillmp2)
				wait(0.05+lagx*0.05)
				existsClickL(autobtn,0)
				wait(0.15+lagx*0.15)
				existsClickL(autoonbtn,0)
				state = 19
				round = round + 1		
			elseif(state == 19) then				
				usePreviousSnap(true)
				if(use_smart_battle_boss and boss_found) then
					state = 20
				else
					existsClickL(repeatbtn,0)
					round = round + 1
				end
			elseif(state == 20) then
				wait(0.1)
				smartBattle_choose(sb_skilluse_boss, sb_skillmp_boss)
				wait(0.05+lagx*0.05)
				if(use_smart_battle_boss_companion) then
					smartBattle_companion(use_smart_battle_boss_companion_mp)
					wait(0.05+lagx*0.05)
				end
				existsClickL(autobtn,0)
				wait(0.05+lagx*0.05)
				existsClickL(autoonbtn,0)
				wait(0.15+lagx*0.15)
				round = round + 1		
				if (use_smart_battle_boss_2nd) then
					state = 21
				else
					state = 29
				end
				boss_found = false
			elseif(state == 21) then
				wait(0.1)
				smartBattle_choose(sb_skilluse_boss2, sb_skillmp_boss2)
				wait(0.05+lagx*0.05)
				if(use_smart_battle_boss_companion_2nd) then
					smartBattle_companion(use_smart_battle_boss_companion_2nd_mp)
					wait(0.05+lagx*0.05)
				end
				existsClickL(autobtn,0)
				wait(0.05+lagx*0.05)
				existsClickL(autoonbtn,0)
				wait(0.15+lagx*0.15)
				state = 29
				round = round + 1		
			elseif(state == 29) then				
				usePreviousSnap(true)
				if(sb_reg:exists(IsReady,0)) then
					existsClickL(repeatbtn,0)
					round = round + 1
				end
			end
		elseif (existsL(battle_transition,0)) then
			boss_battle_check_delay = 0.65 + lagx*0.65
		else
			boss_battle_check_delay = 0
		end
	end
end

-- Help screen

function helpscreen()
	dialogInit()
	addTextView("Welcome to ffbeAuto Z Help Screen")
	if (ALver >= "6.8.0") then
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
	if (ALver >= "6.8.0") then
		addSeparator()
		addSeparator()
	else
		newRow()
		newRow()
	end
	addTextView("Thank you and enjoy.")	
	newRow()
	newRow()	
	addCheckBox("custom_help_screen", "Show custom battle help?", false)
	dialogShow("Help")
	
	if (custom_help_screen) then
		dialogInit()
		addTextView("Welcome to ffbeAuto Z Custom Battle Help Screen")
		if (ALver >= "6.8.0") then
			addSeparator()
			addSeparator()
		else
			newRow()
			newRow()
		end
		addTextView("Custom Battle is divided into four main action sets : ")	
		newRow()
		addTextView("The first actions are to be performed at dungeon start.")	
		newRow()
		addTextView("The second actions are performed after adjustable rounds in dungeons if there isn't a boss. Boss actions take precedence over this.")	
		newRow()
		addTextView("The first boss actions are performed at the start of a boss. Can optionally try to perform an attack action for companion unit as well.")	
		newRow()
		addTextView("The second boss actions are performed after the first. Also able to perform companion action.")	
		newRow()
		newRow()
		addTextView("After those actions the script will always press repeat and nothing else.")	
		newRow()
		newRow()
		addTextView("The skill chosen is a combination of ICON and MP. You choose an Icon and MP for the script to find.")	
		newRow()
		if (ALver >= "6.8.0") then
			addSeparator()
			addSeparator()
		else
			newRow()
			newRow()
		end
		newRow()
		newRow()
		addCheckBox("skill_help_screen", "Show the list of custom skills?", false)
		dialogShow("Custom Battle Help")
	end

	if (skill_help_screen) then
		dialogInit()
		addTextView("Welcome to ffbeAuto Z Custom Battle Skill Screen")
		if (ALver >= "6.8.0") then
			addSeparator()
			addSeparator()
		else
			newRow()
			newRow()
		end
		addTextView("None (Default) : Autoattack (or limit if it's filled and you have it enabled in game options)")	
		newRow()
		addTextView("Fire, Blizzard, Thunder, Stone, Water, Aero, Holy, Dark, Poison, Drain, Ultima, Meteor, and Cure are icons based on their respective magics")	
		newRow()
		addTextView("Katana icon is for skills such as Mirror of Equity, Barrage, and Tri-Attack.")	
		newRow()
		addTextView("Sword icon is for skills such as Full Break, Undermine, and Divine Ruination.")	
		newRow()
		addTextView("Blast icon is for skills such as Area Blast, Hyperdrive, Hit All, and Red Card.")	
		newRow()
		addTextView("Shot icon is for skills such as True Shot, Burst Shot, Blazing Glory.")	
		newRow()
		addTextView("Buff icon is for skills such as Focus, Protect, and Shell.")	
		newRow()
		addTextView("Cheer icon is for skills such as Cheer and Embolden.")	
		newRow()
		addTextView("Kick icon is for skills such as, well, Kick. And also Raging Fist of course, but it's still a kick.")	
		newRow()
		addTextView("Provoke icon is for those living in the face of enemies taunting them. Of course it's for Provoke.")	
		newRow()
		addTextView("Dance is for all dance skills and Sing is for singing (duh!).")	
		newRow()
		addTextView("Elements is for skills such as Maduin Guard and Omni-Veil.")	
		newRow()
		addTextView("Status is for skills such as Trine and Binding Cold.")	
		newRow()
		addTextView("Cover (Noctis) is self-explanatory.")	
		newRow()
		if (ALver >= "6.8.0") then
			addSeparator()
			addSeparator()
		else
			newRow()
			newRow()
		end
		newRow()
		newRow()
		dialogShow("Custom Battle Skills")
	end

end

-- Custom Battle Menu
-- NOTE THAT skilltable and mptable ARE strings. 'cause addSpinner only accept strings.
-- AnkuLua remembers unique spinner variables between sessions, and token is used to differentiate them.

function cbattlemenu(skilltable, mptable, titletype, token)
	skillsList = {}

	for i,v in pairsByKeys(sb_skills) do
		skillsList[#skillsList+1] = i
	end

	dialogInit()
	addTextView("Set unit skill icons and MP usage below : ")
	newRow()
	newRow()
	if (ALver >= "6.8.0") then
		newRow()
		addSeparator()
		newRow()
	else
		newRow()
		newRow()
		newRow()
	end
	addTextView("Battle Actions : ")
	newRow()
	newRow()
	addTextView("Unit 1 :")
	addSpinner("skill1"..token,skillsList,"None")
	addTextView("MP :")
	addEditNumber("mp1"..token,0)
	newRow()
	addTextView("Unit 2 :")
	addSpinner("skill2"..token,skillsList,"None")
	addTextView("MP :")
	addEditNumber("mp2"..token,0)
	newRow()
	addTextView("Unit 3 :")
	addSpinner("skill3"..token,skillsList,"None")
	addTextView("MP :")
	addEditNumber("mp3"..token,0)
	newRow()
	addTextView("Unit 4 :")
	addSpinner("skill4"..token,skillsList,"None")
	addTextView("MP :")
	addEditNumber("mp4"..token,0)
	newRow()
	addTextView("Unit 5 :")
	addSpinner("skill5"..token,skillsList,"None")
	addTextView("MP :")
	addEditNumber("mp5"..token,0)
	newRow()
	newRow()
	newRow()
	dialogShow(titletype)
	
	skilltable[1] = _G["skill1"..token]
	skilltable[2] = _G["skill2"..token]
	skilltable[3] = _G["skill3"..token]
	skilltable[4] = _G["skill4"..token]
	skilltable[5] = _G["skill5"..token]
	
	mptable[1] = _G["mp1"..token]
	mptable[2] = _G["mp2"..token]
	mptable[3] = _G["mp3"..token]
	mptable[4] = _G["mp4"..token]
	mptable[5] = _G["mp5"..token]
end

------------------------------------------------------------------------------------------------------------
-------------------------------------------- MAIN FUNCTION START -------------------------------------------
------------------------------------------------------------------------------------------------------------

-- Check version of AnkuLua first.
ALver, ALpro = getALVer()

if(ALver >= "6.9.0") then
	setButtonPosition(0,0)
else
	toast("Old version of AnkuLua detected.")
end

dialogInit()
farmList = {}

for i,v in pairsByKeys(special_farm) do
	farmList[#farmList+1] = i
end
for i,v in pairsByKeys(farm) do
	farmList[#farmList+1] = i
end
for i,v in pairsByKeys(custom) do
	farmList[#farmList+1] = v
end

addTextView("Farm location:")
addSpinner("farmloc",farmList,"earth_shrine_entrance")
newRow()
addCheckBox("loot", "Find Battle?", false)
if (ALpro) then addCheckBox("dimscreen", "Dim screen?", false) else dimscreen = false end
newRow()
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
addRadioButton("Just press Auto", 1)
addRadioButton("Use Espers", 2)
addRadioButton("Custom (Dungeons Only)", 3)
newRow()
--[[
addTextView("Swipe mode")
addRadioGroup("trace_mode",1)
addRadioButton("1 (Preferred)",1)
addRadioButton("2 (Alternative)",2)
newRow()
addTextView("Use Click for step:")
addRadioGroup("step_mode",1)
addRadioButton("Single (Preferred)",1)
addRadioButton("Always (Slow)",2)
]]--
newRow()
addTextView("Device Lag multiplier:")
addEditNumber("lagx",1.3)
newRow()
addTextView("Depart count (99999 for infinite) :")
addEditNumber("max_depart_count",99999)
newRow()
addCheckBox("help_screen", "Show help?", false)

dialogShow(ver)

if (help_screen) then
	helpscreen()
	scriptExit("Help Finished")
end

if(farmloc == "dungeon_finder") then selectDungeon() -- get custom dungeon location
elseif(farmloc == "free_farm") then freeFarm() end 

if string.match(farmloc, "speedmode") then
elseif (battle_mode == 3 and (string.match(farmloc, "exploration") or string.match(farmloc, "custom_"))) then 
	toast("Explorations can't use Custom Battle, reverting to Esper mode")
	battle_mode = 2
elseif (battle_mode == 3) then

	use_smart_battle = true

	dialogInit()
	addCheckBox("use_smart_battle_2nd", "Use different actions after x rounds below?", true)
	newRow()
	addTextView("\t\tRounds : ")
	addEditNumber("use_smart_battle_2nd_round",3)
	newRow()
	newRow()
	addCheckBox("use_smart_battle_boss", "Use different actions on BOSS?", true)
	newRow()
	addTextView("\t\t")
	addCheckBox("use_smart_battle_boss_companion", "Use damage skills for companions on above?", true)
	newRow()
	addTextView("\t\t\t\tMP : ")
	addEditNumber("use_smart_battle_boss_companion_mp",25)
	newRow()
	newRow()
	addCheckBox("use_smart_battle_boss_2nd", "Use different actions on 2nd turn of BOSS?", true)
	newRow()
	addTextView("\t\t")
	addCheckBox("use_smart_battle_boss_companion_2nd", "Use damage skills for companions on above?", true)
	newRow()
	addTextView("\t\t\t\tMP : ")
	addEditNumber("use_smart_battle_boss_companion_2nd_mp",25)
	dialogShow("Select custom actions to be performed")
	
	cbattlemenu(sb_skilluse,sb_skillmp,"Custom Battle - First Actions","a")

	if(use_smart_battle_2nd) then
		cbattlemenu(sb_skilluse2,sb_skillmp2,"Custom Battle - Actions after "..use_smart_battle_2nd_round.." turns","b")
	end
	
	if(use_smart_battle_boss) then
		cbattlemenu(sb_skilluse_boss,sb_skillmp_boss,"Custom Battle - Actions on Boss 1st turn","c")
	end

	if(use_smart_battle_boss_2nd) then
		cbattlemenu(sb_skilluse_boss2,sb_skillmp_boss2,"Custom Battle - Actions on Boss 2nd turn","d")
	end
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

if (height >= width) then aRatio = (height / width) / 1.6					-- Aspect ratio correction from 960 height 600 width which is 1.6 ratio
else aRatio = (width / height) / 1.6
end

while true do
	depart_count = depart_count + 1
	if (ALver >= "6.6.0") then setStopMessage("Task : "..farmloc.."\n\nDepart : "..depart_count.."\nGame Over : "..gameover_count.."\nLapis Refill : "..lapis_refill_count) end
	if (debug_mode) then runlog("Depart #"..depart_count, true) end
	if (farmloc == "earth_shrine_entrance_speedmode") then
		ese_speed(farmloc)
	else
		fFarm(farmloc)
	end
	if (max_depart_count ~= 99999 and depart_count >= max_depart_count) then scriptExit("Finished") end
end