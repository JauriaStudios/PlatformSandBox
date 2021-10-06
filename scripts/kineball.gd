extends KinematicBody

#var rand_generate = RandomNumberGenerator.new()
var vec_pos = Vector3(0,0,0) 
var speed = 20
var rotspeed = 9
var gravity = -5
#var wind = 0.0
var jump_force = 105

var max_jumps = 3
var jumps_count = 0

var player_rotation = 0
var rotating_left = false
var rotating_right = false

func _ready():
	pass

# Physics Loop
func _physics_process(_delta):
	
	
	var y = 0
	
	# input handler
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vec_pos.z=0
		
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		vec_pos.z=-speed
		
		$personaje3/AnimationPlayer.play("crouch_walk_forward-loop")
		
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		vec_pos.z=speed
		
		$personaje3/AnimationPlayer.play("crouch_walk_back-loop")
		
	elif Input.is_action_pressed("ui_right"):
		vec_pos.z=-speed
		if $personaje3.rotation.y <= 90 and $personaje3.rotation.y <= 0:
			rotating_right = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
			
		$personaje3/AnimationPlayer.play("walk_forward-loop")
		
	elif Input.is_action_pressed("ui_left"):
		vec_pos.z=speed
		if $personaje3.rotation.y >= 0 and $personaje3.rotation.y <= 90:
			rotating_left = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		$personaje3/AnimationPlayer.play("walk_backward-loop")
		
	elif Input.is_action_pressed("ui_down"):
		$personaje3/AnimationPlayer.play("crouch-loop")
		vec_pos.z= lerp(vec_pos.z,0,0.2)
		
	else:
		$personaje3/AnimationPlayer.play("fall_down-loop")
		vec_pos.z= lerp(vec_pos.z,0,0.2)
	
	if $personaje3.rotation.y >= 0 and rotating_right == true:
		rotating_right = false
	elif $personaje3.rotation.y <= 180 and rotating_left == true:
		rotating_left = false
		
	if rotating_right == true:
		$personaje3.rotate(Vector3(0, 1, 0), _delta * rotspeed)
	elif rotating_left == true:
		$personaje3.rotate(Vector3(0, 1, 0), _delta * rotspeed)
	
	# wind = rand_generate.randf_range(-1.0, 1.0)
	
	vec_pos.y += gravity
	#vec_pos.z += wind
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vec_pos.y = jump_force
		
	vec_pos = move_and_slide(Vector3(0, vec_pos.y, vec_pos.z),Vector3.UP)


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
