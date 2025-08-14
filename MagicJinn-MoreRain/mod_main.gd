extends Node

# ! Comments prefixed with "!" mean they are extra info. Comments without them
# ! should be kept because they give your mod structure and make it easier to
# ! read by other modders
# ! Comments with "?" should be replaced by you with the appropriate information

# ! This template file is statically typed. You don't have to do that, but it can help avoid bugs
# ! You can learn more about static typing in the docs
# ! https://docs.godotengine.org/en/3.5/tutorials/scripting/gdscript/static_typing.html

# ? Brief overview of what your mod does...

const MOD_DIR := "AuthorName-ModName" # Name of the directory that this file is in
const LOG_NAME := "AuthorName-ModName:Main" # Full ID of the mod (AuthorName-ModName)

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


# ! your _ready func.
func _init() -> void:
	ModLoaderLog.info("Init", LOG_NAME)
	mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(MOD_DIR)
	patch_raindrops()

func patch_raindrops() -> void:
	ModLoaderLog.info("patching raindrops", LOG_NAME)
	ModLoader.install_script_extension("res://mods-unpacked/MagicJinn-MoreRain/extensions/patch_raindrops.gd")

func _ready() -> void:
	ModLoaderLog.info("Ready", LOG_NAME)
