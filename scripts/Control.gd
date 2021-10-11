extends Control

func _ready():
	pass


func _on_game_button_pressed():
	get_tree().change_scene("res://scenes/stage_1.tscn")

func _on_options_button_pressed():
	get_tree().change_scene("res://scenes/options.tscn")

func _on_quit_button_pressed():
	get_tree().set_auto_accept_quit(false)
	get_tree().quit()

