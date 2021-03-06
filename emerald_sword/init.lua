print("EMERALD SWORD")
local S = minetest.get_translator("mcl_tools")

-- mods/ITEMS/mcl_tools/aliases.lua
--minetest.register_alias("mcl_core:sword_emerald", "mcl_tools:sword_emerald")

-- mods/ITEMS/mcl_tools/crafting.lua
minetest.register_craft({
	output = 'emerald_sword:sword_emerald',
	recipe = {
		{'mcl_core:emerald'},
		{'mcl_core:emerald'},
		{'mcl_core:stick'},
	}
})


-- mods/ITEMS/mcl_tools/init.lua
minetest.register_tool("emerald_sword:sword_emerald", {
--minetest.register_tool("sword_emerald", {
	description = S("Emerald Sword"),
	_doc_items_longdesc = sword_longdesc,
	inventory_image = "default_tool_emeraldsword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		full_punch_interval = 0.205,
		max_drop_level=5,
		groupcaps={
			swordy_dig = {times=mcl_autogroup.digtimes.swordy_dig, uses=2562, maxlevel=0},
			swordy_cobweb_dig = {times=mcl_autogroup.digtimes.swordy_cobweb_dig, uses=2562, maxlevel=0},
		},
		damage_groups = {fleshy=7},
		punch_attack_uses = 2562,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_core:emerald",
})
