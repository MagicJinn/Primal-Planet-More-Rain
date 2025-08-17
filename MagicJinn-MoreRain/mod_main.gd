extends Node

var rain_multiplier = 15

var raindrop_pool_active = []
var raindrop_pool_inactive = []

const MOD_DIR := "MagicJinn-MoreRain" # Name of the directory that this file is in
const LOG_NAME := MOD_DIR + ":Main" # Full ID of the mod (MagicJinn-MoreRain)

var mod_dir_path := ""

func _init():
	ModLoaderLog.info("Init", LOG_NAME)
	mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(MOD_DIR)
	patch_raindrops()


func patch_raindrops():
	ModLoaderLog.info("Patching raindrops", LOG_NAME)
	ModLoaderMod.install_script_extension(mod_dir_path.path_join("extensions/patch_raindrops.gd"))
	ModLoaderMod.install_script_extension(mod_dir_path.path_join("extensions/patch_raindrops_falling.gd"))
