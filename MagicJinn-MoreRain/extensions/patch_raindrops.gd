extends "res://actors/specialfx/particles/fx_particles_rain.gd"

const LOG_NAME := "AuthorName-ModName:Main" # Full ID of the mod (AuthorName-ModName)

func _process(delta: float) -> void:
	counter_raindropspawn_current = counter_raindropspawn_max
	control_main.world_weather_raining = true
	ModLoaderLog.info("Ready", LOG_NAME)
	super (delta)
	super (delta)
	super (delta)
	super (delta)
	super (delta)
