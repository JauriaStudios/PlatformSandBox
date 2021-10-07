extends Control


func _ready():
	pass 


func _on_level_button_pressed():
	get_tree().change_scene("res://scenes/Level.tscn")
	
func _on_console_button_pressed():
	get_tree().change_scene("res://scenes/console.tscn")
