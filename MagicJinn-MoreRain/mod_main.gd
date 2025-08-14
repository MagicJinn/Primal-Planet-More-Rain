extends Node

# ! Comments prefixed with "!" mean they are extra info. Comments without them
# ! should be kept because they give your mod structure and make it easier to
# ! read by other modders
# ! Comments with "?" should be replaced by you with the appropriate information

# ! This template file is statically typed. You don't have to do that, but it can help avoid bugs
# ! You can learn more about static typing in the docs
# ! https://docs.godotengine.org/en/3.5/tutorials/scripting/gdscript/static_typing.html

# ? Brief overview of what your mod does...

const MOD_DIR := "MagicJinn-MoreRain" # Name of the directory that this file is in
const LOG_NAME := "MagicJinn-MoreRain:Main" # Full ID of the mod (MagicJinn-MoreRain)

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


# ! your _ready func.
func _init():
	ModLoaderLog.info("Init", LOG_NAME)
	mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(MOD_DIR)
	patch_raindrops()

func patch_raindrops():
	ModLoaderLog.info("Patching raindrops", LOG_NAME)
	ModLoaderMod.install_script_extension(mod_dir_path.path_join("extensions/patch_raindrops.gd"))
	# ModLoaderMod.install_script_extension(mod_dir_path.path_join("extensions/patch_raindrops_falling.gd"))

func _ready():
	ModLoaderLog.info("Ready", LOG_NAME)
