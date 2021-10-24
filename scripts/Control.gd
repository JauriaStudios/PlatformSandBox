extends Control

var menu_enabled = 0
var menu_index = 0

func _ready():
	$menu_hbox/game_button.grab_focus()

	
func _on_game_button_mouse_entered():
	$menu_hbox/game_button.grab_focus()
	$menu_sfx.play()

func _on_lobby_button_mouse_entered():
	$menu_hbox/lobby_button.grab_focus()
	$menu_sfx.play()

func _on_options_button_mouse_entered():
	$menu_hbox/options_button.grab_focus()
	$menu_sfx.play()

func _on_quit_button_mouse_entered():
	$menu_hbox/quit_button.grab_focus()
	$menu_sfx.play()

func _on_game_button_pressed():
	get_tree().change_scene("res://scenes/levels/stage_1.tscn")

func _on_lobby_button_pressed():
	get_tree().change_scene("res://scenes/menu/lobby.tscn")

func _on_options_button_pressed():
	get_tree().change_scene("res://scenes/menu/options.tscn")

func _on_quit_button_pressed():
	get_tree().set_auto_accept_quit(false)
	get_tree().quit()




