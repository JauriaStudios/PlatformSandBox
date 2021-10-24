extends Spatial

func _ready():
	pass

#func _process(delta):
#	pass

func _on_Button7_pressed():
	get_tree().change_scene("res://scenes/menu/control.tscn")
