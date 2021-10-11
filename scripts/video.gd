extends Control

var settings = {"width":1024,"height":720,"fullscreen":false}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_CheckBox_toggled(button_pressed):
	settings["fullscreen"] = button_pressed


func _on_width_spin_box_value_changed(value):
	settings["width"] = value

func _on_height_spinbox_value_changed(value):
	settings["height"] = value

func _on_save_button_pressed():
	var resolution = Vector2(settings["width"], settings["height"])
	OS.set_window_size(resolution)

	if settings["fullscreen"]:
		OS.set_window_fullscreen(true)
	else:
		OS.set_window_fullscreen(false)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_options_button_pressed():
	get_tree().change_scene("res://scenes/options.tscn")
