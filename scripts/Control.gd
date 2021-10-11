extends Control


func _ready():
	pass

func _on_video_options_button_pressed():
	get_tree().change_scene("res://scenes/video.tscn")


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		OS.set_window_fullscreen(true)
	else:
		OS.set_window_fullscreen(false)
