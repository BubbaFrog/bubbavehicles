dofile(minetest.get_modpath("vehicles").."/api.lua")

minetest.register_entity("bubbavehicles:bubbabike", {
	visual = "mesh",
	mesh = "lightcycle.b3d",
	textures = {"bubbavehicles_frogcycle.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		self.sound_ready = true
		end
	end,
	on_activate = function(self)
		self.nitro = true
	end,
	on_punch = vehicles.on_punch,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 20, 
			decell = 0.85,
			boost = true,
			boost_duration = 4,
			boost_effect = "vehicles_nitro.png",
			place_node = "bubbavehicles:light_frog",
			place_trigger = true,
			death_node = "vehicles:light_barrier",
			handling = {initial=3, braking=2.2}
		})
	end,
})

vehicles.register_spawner("bubbavehicles:bubbabike", ("Frog Lightcycle"), "bubbavehicles_greentron_inv.png")
