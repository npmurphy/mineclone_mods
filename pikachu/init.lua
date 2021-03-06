local S = minetest.get_translator("mobs_mc")

mobs_mc.follow.pikachu =  { mobs_mc.items.apple, mobs_mc.items.golden_apple}

local pikachu = {
	type = "animal",
	spawn_class = "passive",
	--attack_type = "thundershock",
	attack_type = "dogshoot",
	passive = false,
	armor = 50,
	damage = 8,
	reach = 1,

	hp_min = 3,
	hp_max = 3,
	xp_min = 1,
	xp_max = 3,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.49, 0.2},

	visual = "mesh",
	mesh = "mobs_mc_rabbit.b3d",
	textures = { "mobs_mc_rabbit_pikachu.png" },
	visual_size = {x=1.5, y=1.5},
	sounds = {
		random = "mobs_mc_rabbit_random",
		damage = "mobs_mc_rabbit_hurt",
		death = "mobs_mc_rabbit_death",
		attack = "mobs_mc_rabbit_attack",
		eat = "mobs_mc_animal_eat_generic",
		distance = 16,
	},
	makes_footstep_sound = false,
	walk_velocity = 3,
	run_velocity = 6,
	follow_velocity = 3,
	floats = 1,
	runaway = true,
	jump = true,
	drops = {
		{name = mobs_mc.items.rabbit_raw, chance = 1, min = 0, max = 1, looting = "common",},
		{name = mobs_mc.items.rabbit_hide, chance = 1, min = 0, max = 1, looting = "common",},
		{name = mobs_mc.items.rabbit_foot, chance = 10, min = 0, max = 1, looting = "rare", looting_factor = 0.03,},
	},
	fear_height = 4,
	animation = {
		speed_normal = 25,		speed_run = 50,
		stand_start = 0,		stand_end = 0,
		walk_start = 0,		walk_end = 20,
		run_start = 0,		run_end = 20,
	},
	follow = mobs_mc.follow.pikachu,
	view_range = 16,
	-- Eat carrots and reduce their growth stage by 1
	replace_rate = 10,
	replace_what = mobs_mc.replace.rabbit,
	on_rightclick = function(self, clicker)
		-- copy code from wolf (intentionally does NOT use mobs:feed_tame)
		local tool = clicker:get_wielded_item()
		local mypikachu, ent
		if tool:get_name() == mobs_mc.items.apple then

			if not minetest.is_creative_enabled(clicker:get_player_name()) then
				tool:take_item()
				clicker:set_wielded_item(tool)
			end
			local yaw = self.object:get_yaw()
			mypikachu = minetest.add_entity(self.object:get_pos(), "pikachus:mypikachu")
			mypikachu:set_yaw(yaw)
			ent = mypikachu:get_luaentity()
			ent.owner = clicker:get_player_name()
			self.object:remove()
		end
	end,
}

mobs:register_mob("pikachu:pikachu", pikachu)

local pikachu_spawn = {
	name = "pikachu:pikachu",
	nodes = mobs_mc.spawn.grassland,
	neighbors = {"air"},
	chance = 15000,
	active_object_count = 30,
	min_light = 0,
	max_light = minetest.LIGHT_MAX+1,
	min_height = mobs_mc.spawn_height.overworld_min,
	max_height = mobs_mc.spawn_height.overworld_max,
	on_spawn = function(self, pos)
		local texture = "mobs_mc_rabbit_pikachu.png"
		self.base_texture = { "mobs_mc_rabbit_pikachu.png" }
		self.object:set_properties({textures = self.base_texture})
	end
}

mobs:spawn(pikachu_spawn)


-- caught pikachu (aka "mypikachu)
local mypikachu = table.copy(pikachu)
mypikachu.can_despawn = false
mypikachu.passive = true
mypikachu.hp_min = 20
mypikachu.hp_max = 20
mypikachu.owner = ""
mypikachu.order = "roam"
mypikachu.owner_loyal = true
mypikachu.follow_velocity = 3.2
-- Automatically teleport mypikachu to owner
mypikachu.do_custom = mobs_mc.make_owner_teleport_function(12)
mypikachu.follow = mobs_mc.follow.mypikachu
mypikachu.attack_animals = nil
mypikachu.specific_attack = nil


mobs:register_mob("pikachu:mypikachu", mypikachu)




---animal
---/home/nmurphy/coding/MineClone2/mods/ENTITIES/mcl_mobs/api.lua 
-- local do_states = function(self , dtime)
-- 	elseif self.state == "attack" then
-- 		if self.attack_type == "explode" then
-- 		elseif self.attack_type == "thundershock" then
-- 			lightning.strike(p)
-- 		elseif self.attack_type == "shoot"
-- 