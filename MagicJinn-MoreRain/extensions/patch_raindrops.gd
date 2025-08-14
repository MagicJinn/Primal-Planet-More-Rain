extends "res://actors/specialfx/particles/fx_particles_rain.gd"

func _ready():
	particles_rain_max = 3000
	super()

func _process(delta):
	counter_raindropspawn_current = counter_raindropspawn_max
	control_main.world_weather_raining = true
	for i in 10:
		super (delta)
