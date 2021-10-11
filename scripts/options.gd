extends Control

func _ready():
	pass # Replace with function body.

func _on_game_options_button_pressed():
	pass # Replace with function body.


func _on_video_options_button_pressed():
	get_tree().change_scene("res://scenes/video.tscn")


func _on_audio_options_button_pressed():
	pass # Replace with function body.


func _on_back_options_button_pressed():
	get_tree().change_scene("res://scenes/control.tscn")

