extends Control

func _ready():
	pass

func _on_host_button_mouse_entered():
	$menu_sfx.play()


func _on_client_button_mouse_entered():
	$menu_sfx.play()


func _on_options_button_mouse_entered():
	$menu_sfx.play()


func _on_back_button_mouse_entered():
	$menu_sfx.play()


func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/control.tscn")
