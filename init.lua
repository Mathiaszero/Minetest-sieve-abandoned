print("Mod successfully loaded.")

minetest.register_on_prejoinplayer(function(name, ip)
sievePlayerName= tostring(name)
end)


--local timer= minetest.get_node_timer(pos)
--local timer=0
--local incr=0
--local debounce=false
local fuel=0
local punches=0
minetest.register_node("sieve:g", {
	description = "sieve",
	tiles= {"s_old2.png"},
	groups = {cracky = 1},
	--on_punch= function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
	--[[
	on_step= function(self, dtime)	
		timer=timer+1
		minetest.chat_send_all(tostring(timer))
	end
	--]]
	--end
	--[[
	on_activate=function(self,staticdata, dtime_s)
	minetest.chat_send_all("HI")
	end
	--]]
	
	minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
		--local checkLava= tostring(minetest.serialize(minetest.get_node(vector.subtract(pos, {x=0,y=1,z=1}))))
		--local checkLava= string.sub(tostring(minetest.serialize(minetest.get_node(vector.subtract(pos, {x=0,y=1,z=1})))),37,60)
		
		
		local checkNode= string.sub(tostring(minetest.serialize(node)),37,43)
		--minetest.chat_send_all(checkNode)
		--minetest.chat_send_all(checkLava)
		if checkNode=="sieve:g" then
			punches=punches+1
			--minetest.chat_send_all(punches)	
			
			if punches>=10 then
				--minetest.show_formspec(sievePlayerName, "popup",
				--"size[0,0]",
				--"image[0.5,1;1,1;s.png]"
				--"image_button[0,0;10,10;s.png;test;test]"
				--"background[1,1;10,10;s.png]"
				--)
				--minetest.chat_send_all(sievePlayerName)
				
				--[[
				thePlayer= minetest.get_player_by_name(sievePlayerName)
				--thePlayer= sievePlayerName
				portraitHUD= thePlayer:hud_add({
					hud_elem_type= "image",
					position= {x=0.75,y=0.75},
					offset= {x=-220,y=0},
					text="portrait.png",
					scale={x=1,y=1},
					alignment={x=1,y=0}
				})
				--]]
			end
		end
	end)

})

local function checkCoal()
	fuel=100
	--local fuelStr= tostring(fuel)
	--minetest.chat_send_all(fuelStr)
	--minetest.chat_send_all(fuel)
	--minetest.chat_send_player(player,tostring(fuel))
	--minetest.display_chat_message(tostring(fuel))
	--print("HELLO")
	--local k= minetest.get_player_by_name(tostring(player))
	--minetest.chat_send_all(k)
	--minetest.register_craft_predict(function(itemstack, player, old_craft_grid, craft_inv)
		--minetest.chat_send_all(tostring(player))
		--local k= minetest.write_json(player)
		--minetest.chat_send_all(tostring(k))
	--end)
	--local k= minetest.get_player_name(player)
	minetest.chat_send_player(sievePlayerName,fuel)
	handle1= minetest.sound_play("light",{
			pos= globalPos,
			--pos=
			max_hear_distance= 5
			})
end

minetest.register_abm({
	nodenames= {"sieve:g"},
	interval= 3,
	chance=1,
	action=function(pos, node, active_object_count, active_object_count_wider)
		globalPos=pos
		--[[
		thePlayer= minetest.get_player_by_name(sievePlayerName)
				--thePlayer= sievePlayerName
				portraitHUD= thePlayer:hud_add({
					hud_elem_type= "image",
					position= {x=-1,y=-1},
					offset= {x=-220,y=0},
					text="portrait.png",
					scale={x=1,y=1},
					alignment={x=1,y=0}
				})
		if fuel==98 then
		thePlayer:hud_change(portraitHUD,"position",{x=0.75,y=0.75})
		end
			--]]	
		local pos1 = vector.add(pos, {x = 0, y = 1, z = 0})
		local nodename = minetest.get_node(pos1)
		local nodename2 = tostring(minetest.serialize(nodename))
		local nt= string.sub(nodename2, 37, 50)
		local nt1= "default:gravel"
		--minetest.chat_send_all(nodename_target)
		if punches>0 then 
			punches=punches-1
			--minetest.chat_send_all(punches)
			if punches<10 then
				--getPlayer:hud_remove(portraitHUDf)
			end
		end
		
		local posCoal1= vector.add(pos, {x=1,y=0,z=0})
		local posCoal2= vector.add(pos, {x=0,y=0,z=1})
		local posCoal3= vector.subtract(pos, {x=1,y=0,z=0})
		local posCoal4= vector.subtract(pos, {x=0,y=0,z=1})
		
		local ifCoal1= minetest.get_node(posCoal1)
		local ifCoal2= minetest.get_node(posCoal2)
		local ifCoal3= minetest.get_node(posCoal3)
		local ifCoal4= minetest.get_node(posCoal4)
		
		local ifCoal1Ser = minetest.serialize(ifCoal1)
		local ifCoal2Ser = minetest.serialize(ifCoal2)
		local ifCoal3Ser = minetest.serialize(ifCoal3)
		local ifCoal4Ser = minetest.serialize(ifCoal4)

		local c1Str = string.sub(ifCoal1Ser, 37, 53)
		local c2Str = string.sub(ifCoal2Ser, 37, 53)
		local c3Str = string.sub(ifCoal3Ser, 37, 53)
		local c4Str = string.sub(ifCoal4Ser, 37, 53)
		
		local a= "default:coalblock"
		--minetest.chat_send_all(c1Str)
		
		if c1Str==a then 
			minetest.remove_node(vector.add(pos, {x=1,y=0,z=0}))
			--fuel==99
			checkCoal()
		end
		if c2Str==a then
			minetest.remove_node(vector.add(pos, {x=0,y=0,z=1}))
			--fuel==99
			checkCoal()
		end
		if c3Str==a then
			minetest.remove_node(vector.subtract(pos, {x=1,y=0,z=0}))
			--fuel=99
			checkCoal()
		end
		if c4Str==a then
			minetest.remove_node(vector.subtract(pos, {x=0,y=0,z=1}))
			--fuel=99
			checkCoal()
		end
		
		if nt==nt1 and fuel>0 then
			fuel=fuel-1
			
			--minetest.chat_send_all(fuel)
			--minetest.dislay_chat_message(fuel)
			minetest.chat_send_player(sievePlayerName,fuel)
			--[[
			minetest.after(1,function()
				local node= minetest.get_node(pos)
				local node2= minetest.set_node(vector.subtract(pos,{x=0,y=0.33,z=0}),node)
				minetest.after(1,function()
					local node3= minetest.get_node(node2)
					minetest.set_node(vector.subtract(pos,{x=0,y=0.33,z=0}),node3)
				end)
			end)
				--]]
			--minetest.after(1,function()
			--
			--end)
			minetest.remove_node(vector.add(pos, {x=0, y=1,z=0}))
			handle1= minetest.sound_play("gravel_short",{
			pos= globalPos,
			--pos=
			max_hear_distance= 5
			})
			local rand= math.random(100)
			local probItem= ""
			if rand>=98 and rand<=99 then
				probItem= "default:gold_lump"
			elseif rand==100 then 
				probItem= "default:diamond"
			elseif rand>=50 and rand<=72 then
				probItem= "default:gravel"
			elseif rand>=1 and rand<=49 then
				probItem= "default:sand"
			elseif rand>=80 and rand<=85 then 
				probItem= "default:iron_lump"
			elseif rand>=73 and rand<=79 then 
				probItem="default:coal_lump"
			elseif rand>=95 and rand<=97 then
				probItem="default:mese_crystal"
			elseif rand>=86 and rand<=90 then
				probItem="default:copper_lump"
			elseif rand>=91 and rand<=94 then
				probItem="default:tin_lump"
			else
				probItem= nil
			end
			minetest.spawn_item(pos,probItem)
		end
	end
})

minetest.register_craft({
type="shaped",
output="sieve:g",
recipe={
{"","",""},
{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
{"default:wood","","default:wood"}
}
})

local checkAdd=0
minetest.register_chatcommand("sieve",{
func=function(name,param)
--minetest.chat_send_all("HI")
	if checkAdd==0 then
		thePlayer= minetest.get_player_by_name(sievePlayerName)
				--thePlayer= sievePlayerName
				portraitHUD= thePlayer:hud_add({
					hud_elem_type= "image",
					position= {x=0.75,y=0.75},
					offset= {x=-220,y=0},
					text="mathias.png",
					scale={x=1,y=1},
					alignment={x=1,y=0}
				})
	checkAdd=1
	end
end
})

minetest.register_chatcommand("rsieve",{
func=function(name,param)
--minetest.chat_send_all("HI")
	if thePlayer then
		thePlayer:hud_remove(portraitHUD)
		checkAdd=0
	end
end
})



--[[
minetest.register_chatcommand("boom",{
func=function(name,param)
	minetest.sound_play("bomb",{
	pos= globalPos
	
	})
	minetest.remove_node(globalPos)
end
})
--]]
--[[
--somehow timer is nil
local timer= minetest.get_node_timer(pos)
timer:start(10)	

--code below works
minetest.register_abm({
	nodenames= {"sieve:g"},
	interval= 5,
	chance=1,
	action=function(pos, node, active_object_count, active_object_count_wider)
	nodePos= tostring(minetest.serialize(pos))
	minetest.chat_send_all(nodePos)
	local xv=string.match(nodePos,"%d+")
	--minetest.chat_send_all("xv is: "..xv)
	local yv=string.match(nodePos,"%d+.-(%d+)")
	--minetest.chat_send_all("yv is: "..yv)
	local zv=string.match(nodePos,"%d+.-%d+.-(%d+)")
	--minetest.chat_send_all("zv is: "..zv)
	xv=tonumber(xv)
	yv=tonumber(yv)
	zv=tonumber(zv)
	end
})

		 sievePlayerName:hud_add({
         hud_elem_type = "image",
         position = {x=0.5,y=0.5},
         scale = 1,
         text = "portrait2.png",
         alignment = {x=0,y=0},
      })

hud_add({
    hud_elem_type = "statbar",
    position = {x=0,y=1},
    size = "",
    text = "ui_heart_bg.png",
    number = 20,
    alignment = {x=0,y=1},
    offset = {x=0, y=-32},
})

minetest.register_chatcommand("play",{
func=function(name,param)
	if globalPos then
		handle= minetest.sound_play("FamiliarRoads",{
		--pos= globalPos,
		pos= {x=0,y=0,z=0},
		max_hear_distance= 5
		})
	end
end
})

minetest.register_chatcommand("stop",{
func=function(name,param)
	if handle then
		minetest.sound_stop(handle)
	end
end
})

--]]

