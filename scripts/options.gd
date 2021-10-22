extends Control

var menu_enabled = 0
var menu_index = 0

func _ready():
	$menu_vbox/game_options_button.grab_focus()

func _on_game_options_button_mouse_entered():
	$menu_vbox/game_options_button.grab_focus()
	$menu_sfx.play()

func _on_video_options_button_mouse_entered():
	$menu_vbox/video_options_button.grab_focus()
	$menu_sfx.play()

func _on_audio_options_button_mouse_entered():
	$menu_vbox/audio_options_button.grab_focus()
	$menu_sfx.play()

func _on_back_options_button_mouse_entered():
	$menu_vbox/back_options_button.grab_focus()
	$menu_sfx.play()


func _on_game_options_button_pressed():
	pass # Replace with function body.

func _on_video_options_button_pressed():
	get_tree().change_scene("res://scenes/video.tscn")

func _on_audio_options_button_pressed():
	get_tree().change_scene("res://scenes/audio.tscn")

func _on_back_options_button_pressed():
	get_tree().change_scene("res://scenes/control.tscn")



