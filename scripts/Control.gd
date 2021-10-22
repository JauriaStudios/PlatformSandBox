extends Control

var menu_enabled = 0
var menu_index = 0

func _ready():
	pass
	
func _process(delta):

	if Input.is_action_pressed("ui_down"):
		menu_enabled = true
	elif Input.is_action_pressed("ui_up"):
		menu_enabled = false
	elif Input.is_action_pressed("ui_left"):
		if menu_enabled and menu_index > 0:
			menu_index -= 1
	elif Input.is_action_pressed("ui_right"):
		if menu_enabled and menu_index < 4:
			menu_index += 1
			
	if menu_enabled:
		if menu_index == 0:
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
	get_tree().change_scene("res://scenes/stage_1.tscn")

func _on_lobby_button_pressed():
	get_tree().change_scene("res://scenes/lobby.tscn")

func _on_options_button_pressed():
	get_tree().change_scene("res://scenes/options.tscn")

func _on_quit_button_pressed():
	get_tree().set_auto_accept_quit(false)
	get_tree().quit()




