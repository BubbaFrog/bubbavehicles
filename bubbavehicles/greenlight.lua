minetest.register_node("bubbavehicles:light_frog", {
	description = ("Frog Tron"),
	tiles = {
	"bubbavehicles_greenblock.png^[transformR90",
	"bubbavehicles_greenblock.png^[transformR90",
	"bubbavehicles_greenblock.png",
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "connected",
			fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
			connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
			connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
			connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
			connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
	},
	connects_to = {"bubbavehicles:light_frog",},
	sunlight_propagates = true,
	walkable = false,
	light_source = 9,
	groups = {cracky=3,dig_immediate=3,not_in_creative_inventory=1},
	on_construct = function(pos, node)
			minetest.get_node_timer(pos):start(4)
		return
	end,
	on_timer = function(pos, elapsed)
		minetest.remove_node(pos)
	end,
})
