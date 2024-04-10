---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by michieal.
--- DateTime: 11/19/22 7:13 AM
---

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by michieal.
--- DateTime: 10/23/22 4:50 AM
---
-- LOCALIZATION

local S = minetest.get_translator("mcl_hamburger")

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local table = table
local DEBUG = false

local enable_burger = minetest.settings:get_bool("mcl_enable_hamburger",true)
local use_alt = minetest.settings:get_bool("mcl_hamburger_alt_texture",false)

local HAMBURGER_NAME = "mcl_hamburger:hamburger"

mcl_hamburger = {}

if DEBUG then
	minetest.log("MCL_Hamburger::START.")
end

-- call to register your hamburger.
function mcl_hamburger.register_burger_craft(cooked_meat)
	minetest.register_craft({
		type = "fuel",
		recipe = HAMBURGER_NAME,
		burntime = 2,
	})

	minetest.register_craft({
		output = HAMBURGER_NAME,
		recipe = {
			{ "mcl_farming:bread"},
			{ cooked_meat }, -- "mcl_mobitems:cooked_beef" for a reg hamburger. Grind up clowns for a Big Mac.
			{ "mcl_farming:bread" },
		},
	})
	minetest.register_craft({
		output = HAMBURGER_NAME,
		recipe = {
			-- "mcl_mobitems:cooked_beef" for a reg hamburger. Grind up clowns for a Big Mac.
			{ "mcl_farming:bread", cooked_meat, "mcl_farming:bread"},
		},
	})

end

local hamburger_def = {
	description = S("A Hamburger"),
	_doc_items_longdesc = S("A tasty hamburger that is sure to lure villagers around like a lead. Can be eaten."),
	_doc_items_usagehelp = S("Wield this item to pull villagers to you."),
	_tt_help = S("A tasty hamburger that is sure to lure villagers. 'I'll gladly pay you Tuesday, for a hamburger today.' - Wimpy."),
	inventory_image = "mcl_hamburger.png",
	wield_image = "mcl_hamburger.png",
	on_place = minetest.item_eat(8),
	on_secondary_use = minetest.item_eat(8),
	groups = { food = 2, eatable = 8 },
	_mcl_saturation = 13.8,
}

if not enable_burger then
	hamburger_def.groups.not_in_creative_inventory = 1
end

if use_alt == false then
	minetest.register_craftitem(HAMBURGER_NAME, hamburger_def)
else
	local hamburger_alt = table.copy(hamburger_def)
	hamburger_alt.inventory_image = "mcl_hamburger_alt.png"
	hamburger_alt.wield_image = "mcl_hamburger_alt.png"
	minetest.register_craftitem(HAMBURGER_NAME, hamburger_alt)
end

local function register_achievements()

	awards.register_achievement(HAMBURGER_NAME, {
		title = S("Burger Time!"),
		description = S("Craft a Hamburger."),
		icon = "mcl_hamburger_alt.png",
		trigger = {
			type = "craft",
			item = HAMBURGER_NAME,
			target = 1
		},
		type = "Advancement",
		group = "Overworld",
	})

end

local function register_doc_entry()

	-- register Doc entry
	if minetest.get_modpath("doc") then
		doc.add_entry_alias("craftitems", HAMBURGER_NAME, "craftitems", HAMBURGER_NAME)
	end

end

if enable_burger then
	-- make the villagers follow the item
	local villager = minetest.registered_entities["mobs_mc:villager"]

	table.insert(villager.follow, HAMBURGER_NAME)

	local original_rightclick = villager.on_rightclick

	local new_on_rightclick = function(self, clicker)
		--minetest.log("In wrapper function")

		local item = clicker:get_wielded_item()
		if item:get_name() == HAMBURGER_NAME then
			if self.nofollow == true then
				--minetest.log("Turn off nofollow")
				self.nofollow = false
			elseif self.nofollow == false then
				--minetest.log("Turn on nofollow")
				self.nofollow = true
			end
		else
			--minetest.log("Not holding burger")
			if self.nofollow == false then
				--minetest.log("Turn on nofollow")
				self.nofollow = true
			end
			original_rightclick(self, clicker)
		end
		--minetest.log("Finishing wrapper")
	end

	villager.on_rightclick = new_on_rightclick

	mcl_hamburger.register_burger_craft("mcl_mobitems:cooked_beef")
	minetest.register_alias("hamburger", HAMBURGER_NAME)

	register_achievements()
	register_doc_entry()
end

