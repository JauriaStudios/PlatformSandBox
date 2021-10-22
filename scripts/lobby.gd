extends Control

func _ready():
	$menu_vbox/host_button.grab_focus()

func _on_host_button_mouse_entered():
	$menu_vbox/host_button.grab_focus()
	$menu_sfx.play()


func _on_client_button_mouse_entered():
	$menu_vbox/client_button.grab_focus()
	$menu_sfx.play()


func _on_options_button_mouse_entered():
	$menu_vbox/options_button.grab_focus()
	$menu_sfx.play()


func _on_back_button_mouse_entered():
	$menu_vbox/back_button.grab_focus()
	$menu_sfx.play()


func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/control.tscn")
