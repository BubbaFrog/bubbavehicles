dofile(minetest.get_modpath("vehicles").."/api.lua")

minetest.register_entity("bubbavehicles:general_lee", {
	visual = "mesh",
	mesh = "musting.b3d",
	textures = {"bubbavehicles_general_lee.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		minetest.sound_play("general_lee_engine", 
		{to_player=self.driver:get_player_name(), gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = vehicles.on_punch,
	on_activate = function(self)
		self.nitro = true
	end,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 17, 
			decell = 0.99,
			boost = true,
			boost_duration = 4,
			boost_effect = "vehicles_nitro.png",
			driving_sound = "engine",
			sound_duration = 11,
			brakes = true,
		})
	end,
})

vehicles.register_spawner("bubbavehicles:general_lee", ("General Lee"), "bubbavehicles_general_lee_inv.png")
