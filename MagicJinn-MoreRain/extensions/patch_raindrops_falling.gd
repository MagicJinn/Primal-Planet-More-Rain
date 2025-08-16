extends "res://actors/specialfx/particles/fx_particle_raindrop.gd"

@onready var group = get_instance_id() % 100; # Assign a group which decides whether the particle should burst
const MIN_BURST = 25
var burst_percentage

@onready var mod = ModLoader.get_node("MagicJinn-MoreRain")
@onready var rain_multiplier = mod.rain_multiplier

func _ready():
	burst_percentage = clamp(100.0 / rain_multiplier * 3, 1, 100)
	super ()

func _on_area_2d_particle_raindrop_body_entered(body):
	var is_terrain = (
		"tilemap_water" in body.name or
		"tilemap_inside" in body.name
	)

	# Always burst if hitting terrain
	if is_terrain:
		burst = true
		return

	# Chance-based burst for everything else
	var burst_chance = group < burst_percentage

	if "player1" in body.name and control_main.player1_alive and not control_main.player1_campfire and control_main.move_allowed:
		if burst_chance:
			burst = true
			if control_main.player1_flamingweapon:
				control_main.player1_flamingweapon = false
				body.funcsound_water_extinguish()

	elif "dino" in body.name and body.alive and body.id_species == 9:
		if burst_chance:
			burst = true
			if body.flamingweapon:
				body.flamingweapon = false
				body.funcsound_water_extinguish()

	elif ("dino" in body.name and body.alive) or ("npc" in body.name and body.alive) or ("player2" in body.name and control_main.player2_alive):
		if burst_chance:
			burst = true

# func _physics_process(delta):
# 	ModLoaderLog.info("Patching raindrops", "LOG_NAME")
# 	super (delta)
