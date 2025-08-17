extends "res://actors/specialfx/particles/fx_particle_raindrop.gd"

@onready var mod = ModLoader.get_node("MagicJinn-MoreRain")
@onready var rain_multiplier = mod.rain_multiplier

@onready var group = get_instance_id() % 100; # Assign a group which decides whether the particle should burst
@onready var burst_percentage = clamp(100.0 / (rain_multiplier/2), 1, 100)
@onready var burst_chance = group < burst_percentage
var this_gravity;

func _ready():
	if drop_foreground:
		this_gravity = control_main.GRAVITY_MAX
	else:
		this_gravity = control_main.GRAVITY_MAX * 0.6

	set_up_direction(control_main.FLOOR)

	super()

func _on_area_2d_particle_raindrop_body_entered(body):
	var is_terrain = (
		"tilemap_water" in body.name or
		"tilemap_inside" in body.name
	)

	# Always burst if hitting terrain
	if is_terrain:
		burst = true
		
	elif "player1" in body.name and control_main.player1_alive and not control_main.player1_campfire and control_main.move_allowed:
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

func _physics_process(delta):
	if control_main.move_allowed == true:
		animatedsprite_particle.play()

		if burst_ended == true:
			reset_droplet_state()
			return;

		if burst == false:
			motion.y =  this_gravity
			
			handle_animation()

			if counter_liftime_current < counter_liftime_max:
				counter_liftime_current += control_main.GAME_FPS * delta
			else:
				counter_liftime_current = 0
				burst_ended = true
		else:
			if on_screen == true and burst_chance:
				motion.x = 0
				motion.y = 0

				animatedsprite_particle.play("burst")
				if animatedsprite_particle.frame >= 4:
					burst_ended = true
			else:
				burst_ended = true

		set_velocity(motion)
		move_and_slide()
		# motion = velocity
	else:
		animatedsprite_particle.pause()

func handle_animation():
	var num = 0
	if !drop_foreground:
		num += 2
 
	if on_screen == true:
		animatedsprite_particle.play("idle")
		if drop_size_small == true:
			animatedsprite_particle.frame = num
		else:
			animatedsprite_particle.frame = num + 1
	else:
		animatedsprite_particle.play("nothing")	

func reset_droplet_state():
	control_main.particles_raindrop_amount -= 1
	mod.raindrop_pool_active.erase(self)
	mod.raindrop_pool_inactive.append(self)
	burst = false
	burst_ended = false
	animatedsprite_particle.visible = false
	set_physics_process(false)
	hide()
