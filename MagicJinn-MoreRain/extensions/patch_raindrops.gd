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
