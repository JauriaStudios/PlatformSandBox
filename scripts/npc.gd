extends KinematicBody


var vec_pos = Vector3(0,0,0) 
var speed = 20
var rotspeed= 9
var gravity= -5
var jump_force = 140



func _ready():
	pass

func _physics_process(_delta):
	# rotate_y(deg2rad(3))
	pass


func _on_Abyss_body_entered(body):
	if body.name == "KineBall":
		get_tree().change_scene("res://scenes/Level.tscn")


func _on_Enemy_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Sounds/hurt").play()
		$Timer2.start()


func _on_finish_area_body_entered(body):	
	get_parent().get_node("Sounds/win").play()
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Control.tscn")


func _on_Timer2_timeout():
	get_tree().change_scene("res://scenes/Level.tscn")





func _on_Coin_cn_collected():
	get_parent().get_node("Sounds/coinsnd").play()


func _on_t1_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Doors/door1/door1animp").play("d1animp")
#		
		var material = get_parent().get_node("triggers/t1/MeshInstance").get_surface_material(0)
		material.albedo_color = Color("14ff00")
		get_parent().get_node("triggers/t1/MeshInstance").set_surface_material(0, material)
		
		get_parent().get_node("triggers/t1").set_collision_layer_bit(0,false)
		get_parent().get_node("triggers/t1").set_collision_mask_bit(0,false)
		


func _on_t2_body_entered(body):
	get_parent().get_node("Doors/door2/leftside/AnimationPlayer").play("d2lsanimp")
	get_parent().get_node("Doors/door2/rightside/AnimationPlayer").play("d2rsanimp")
	
	var material = get_parent().get_node("triggers/t2/MeshInstance").get_surface_material(0)
	material.albedo_color = Color("14ff00")
	get_parent().get_node("triggers/t2/MeshInstance").set_surface_material(0, material)
	
	get_parent().get_node("triggers/t2").set_collision_layer_bit(0,false)
	get_parent().get_node("triggers/t2").set_collision_mask_bit(0,false)
