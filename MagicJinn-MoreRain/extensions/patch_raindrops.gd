extends "res://actors/specialfx/particles/fx_particles_rain.gd"

@onready var mod = ModLoader.get_node("MagicJinn-MoreRain")
@onready var rain_multiplier = mod.rain_multiplier

func _init():
	# Reload the raindrop tscn to make it patchable
	ResourceLoader.load("res://actors/specialfx/particles/fx_particle_raindrop.tscn", "", ResourceLoader.CACHE_MODE_REPLACE_DEEP)

func _ready():
	particles_rain_max = particles_rain_max * rain_multiplier # Increase max raindrops based on multiplier
	super()

func _process(delta):
	control_main.world_weather_raining = true #$TEMP
	for i in rain_multiplier:
		super (delta)

func spawn_raindrop():
	var stage_width_min = control_main.player1_x - 256
	var stage_width_max = control_main.player1_x + 256
	var stage_height_min = control_main.player1_y - 256
	var stage_height_max = control_main.player1_y - 208

	var particle = get_raindrop()
	
	# Set new position
	var choicex = rng.randi_range(stage_width_min, stage_width_max)
	var choicey = rng.randi_range(stage_height_min, stage_height_max)
	particle.position.x = choicex
	particle.position.y = choicey
	
	# Enable the particle
	particle.show()
	particle.set_physics_process(true)

func get_raindrop():
	if mod.raindrop_pool_inactive.size() == 0:
		return new_raindrop() # Make a new raindrop
	else:
		var drop = mod.raindrop_pool_inactive.pop_front()
		mod.raindrop_pool_active.append(drop)
		return drop # Returns a raindrop that is in the pool of inactive drops.
	
func new_raindrop():
	var drop = PARTICLE.instantiate()
	add_child(drop)
	mod.raindrop_pool_active.append(drop) # add to the pool
	return drop
