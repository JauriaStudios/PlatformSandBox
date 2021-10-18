extends Control

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SpinBox_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_soundtest_button_mouse_entered():
	$menu_sfx.play()
	
func _on_back_options_button_mouse_entered():
	$menu_sfx.play()

func _on_save_button_mouse_entered():
	$menu_sfx.play()

func _on_back_options_button_pressed():
	get_tree().change_scene("res://scenes/options.tscn")

func _on_soundtest_button_pressed():
	get_tree().change_scene("res://scenes/sound_test.tscn")
