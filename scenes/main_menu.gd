extends Node2D

func _ready() -> void:
	$"CenterContainer/Main boutons\"SettingsMenu\"/fullscreene".button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else false
	$CenterContainer/SettingsMenu/VolumeBare.value = db_to_linear(AudioServer.get_bus_index("Master"))
	$CenterContainer/SettingsMenu/MusicBare.value = db_to_linear(AudioServer.get_bus_index("MUSIC"))
	$CenterContainer/SettingsMenu/SFXBare.value = db_to_linear(AudioServer.get_bus_index("SFX"))

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/base_flipper.tscn"))


func _on_settings_pressed() -> void:
	$"CenterContainer/Main boutons".visible = false
	$"CenterContainer/Settings Menu".visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	$"CenterContainer/Main boutons".visible = true
	$"CenterContainer/SettingsMenu".visible = false


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_volume_bare_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"),value)


func _on_music_bare_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"),value)


func _on_sfx_bare_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"),value)
