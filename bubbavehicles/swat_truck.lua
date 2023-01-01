dofile(minetest.get_modpath("vehicles").."/api.lua")

minetest.register_entity("bubbavehicles:swat_truck", {
	visual = "mesh",
	mesh = "ambulance.b3d",
	textures = {"bubbavehicles_swat_truck.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.4, 0, -1.4, 1.4, 2, 1.4},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
		clicker:set_attach(self.object, clicker, {x=0, y=5, z=4}, false, {x=0, y=7, z=10})
		self.rider = true
		clicker:set_hp(20)
		elseif self.driver and clicker ~= self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=7, z=14})
		minetest.sound_play("engine_start", 
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
			speed = 13, 
			decell = 0.6,
			moving_anim = {x=1, y=3},
			stand_anim = {x=1, y=1},
			driving_sound = "engine",
			sound_duration = 11,
			handling = {initial=1.3, braking=2},
			brakes = true,
		},
		function()
			if not self.siren_ready then
				minetest.sound_play("police_siren", 
				{pos=self.object:getpos(), gain = 0.1, max_hear_distance = 3, loop = false})
				self.siren_ready = true
				minetest.after(4, function()
					self.siren_ready = false
				end)
			end
		end)
	end,
})

vehicles.register_spawner("bubbavehicles:swat_truck", ("swat truck"), "bubbavehicles_swat_truck_inv.png")

