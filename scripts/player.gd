extends KinematicBody

#var rand_generate = RandomNumberGenerator.new()
var vec_pos = Vector3(0,0,0) 
var speed = 4
var run_mult = 3
var rotspeed = 10
var gravity = -2
#var wind = 0.0
var jump_force = 36

var max_jumps = 3
var jumps_count = 0

var player_rotation = 0
var rotating_left = false
var rotating_right = false

var player_rotation_crouch = 0
var rotating_left_crouch = false
var rotating_right_crouch = false

var crouching = false
var prev_crouching = false

var slash_timer = 0
var slash_max = 700
var prev_slash = 0
var slash_count = 0

var Bullet = preload("res://scenes/bullet_test.tscn")

func _ready():
	  pass
	
func shoot():
	var b = Bullet.instance()
	add_child(b)
	b.transform = $Flare.transform
	b.velocity = -b.transform.basis.z * b.muzzle_velocity

# Physics Loop
func _physics_process(_delta):
	
	var y = 0
	
	
	if Input.is_action_pressed("shoot"):
		shoot()
	
	
	# input handler
	# Jump
	if Input.is_action_pressed("jump"):
		jumps_count = 1
	else:
		jumps_count = 0

	if Input.is_action_pressed("jump") and is_on_floor():
		vec_pos.y = jump_force
		$personaje3/AnimationPlayer.play("fall_down-loop")
	else:
		vec_pos.y += gravity

	# No move
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vec_pos.z=0
	
	elif Input.is_action_pressed("run") and Input.is_action_pressed("ui_left"):
		
		vec_pos.z = speed * run_mult
		if $personaje3.rotation.y <= 90 and $personaje3.rotation.y <= 0:
			rotating_right = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("run_forward-loop")
	
	elif Input.is_action_pressed("run") and Input.is_action_pressed("ui_right"):
		vec_pos.z = -speed * run_mult
		if $personaje3.rotation.y >= 0 and $personaje3.rotation.y <= 90:
			rotating_left = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("run_forward-loop")

	# Crouch Right
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		vec_pos.z = speed
		if $personaje3.rotation.y <= 90 and $personaje3.rotation.y <= 0:
			rotating_right_crouch = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("crouch_walk_forward-loop")
		
	# Crouch Left
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		vec_pos.z = -speed
		if $personaje3.rotation.y >= 0 and $personaje3.rotation.y <= 90:
			rotating_left_crouch = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("crouch_walk_forward-loop")
	
	# Move Right
	elif Input.is_action_pressed("ui_left"):
		vec_pos.z = speed
		if $personaje3.rotation.y <= 90 and $personaje3.rotation.y <= 0:
			rotating_right = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("walk_forward-loop")
	
	# Move Left
	elif Input.is_action_pressed("ui_right"):
		vec_pos.z = -speed
		if $personaje3.rotation.y >= 0 and $personaje3.rotation.y <= 90:
			rotating_left = true
			player_rotation = _delta * rotspeed
			$personaje3.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("walk_forward-loop")
	
	# Crouch
	elif Input.is_action_pressed("ui_down"):
		crouching = true
		
		if jumps_count == 0:
			$personaje3/AnimationPlayer.play("crouch-loop")
			
#		vec_pos.z= lerp(vec_pos.z,0,0.5)
#
#
#		$ballColl.scale.z = $ballColl.scale.z / 2
#		$ballColl.translation.y = $ballColl.translation.y / 2
		
	
	else:
		$personaje3/AnimationPlayer.play("idle-loop")
		vec_pos.z = lerp(vec_pos.z,0,0.2)
		
	
	# Stop rotation when player in position
	if $personaje3.rotation.y >= 0 and rotating_right == true:
		rotating_right = false
	elif $personaje3.rotation.y <= 0 and rotating_left == true:
		rotating_left = false
	
	if $personaje3.rotation.y >= 0 and rotating_right_crouch == true:
		rotating_right_crouch = false
	elif $personaje3.rotation.y <= 0 and rotating_left_crouch == true:
		rotating_left_crouch = false
	
	# keep rotation if button released before reach the end of the animation
	if rotating_right_crouch == true:
		$personaje3.rotate(Vector3(0, 1, 0), _delta * rotspeed)
		$personaje3/AnimationPlayer.play("crouch_walk_forward-loop")
	elif rotating_left_crouch == true:
		$personaje3.rotate(Vector3(0, 1, 0), _delta * rotspeed)
		$personaje3/AnimationPlayer.play("crouch_walk_forward-loop")
	
	# keep rotation if button released before reach the end of the animation
	if rotating_right == true:
		$personaje3.rotate(Vector3(0, 1, 0), _delta * rotspeed)
		$personaje3/AnimationPlayer.play("walk_forward-loop")
	elif rotating_left == true:
		$personaje3.rotate(Vector3(0, 1, 0), _delta * rotspeed)
		$personaje3/AnimationPlayer.play("walk_forward-loop")
	
	# wind = rand_generate.randf_range(-1.0, 1.0)
	

		#vec_pos.z += wind
	
	vec_pos = move_and_slide(Vector3(0, vec_pos.y, vec_pos.z),Vector3.UP)


#func _on_Abyss_body_entered(body):
#	if body.name == "KineBall":
#		get_tree().change_scene("res://scenes/Level.tscn")
#
#
#func _on_Enemy_body_entered(body):
#	if body.name == "KineBall":
#		get_parent().get_node("Sounds/hurt").play()
#		$Timer2.start()
#
#
#func _on_finish_area_body_entered(body):	
#	get_parent().get_node("Sounds/win").play()
#	$Timer.start()
#
#
#func _on_Timer_timeout():
#	get_tree().change_scene("res://scenes/Control.tscn")
#
#
#func _on_Timer2_timeout():
#	get_tree().change_scene("res://scenes/Level.tscn")
#
#
#func _on_Coin_cn_collected():
#	get_parent().get_node("Sounds/coinsnd").play()
#
#
#func _on_t1_body_entered(body):
#	if body.name == "KineBall":
#		get_parent().get_node("Doors/door1/door1animp").play("d1animp")
##		
#		var material = get_parent().get_node("triggers/t1/MeshInstance").get_surface_material(0)
#		material.albedo_color = Color("14ff00")
#		get_parent().get_node("triggers/t1/MeshInstance").set_surface_material(0, material)
#
#		get_parent().get_node("triggers/t1").set_collision_layer_bit(0,false)
#		get_parent().get_node("triggers/t1").set_collision_mask_bit(0,false)
#
#
#
#func _on_t2_body_entered(body):
#	get_parent().get_node("Doors/door2/leftside/AnimationPlayer").play("d2lsanimp")
#	get_parent().get_node("Doors/door2/rightside/AnimationPlayer").play("d2rsanimp")
#
#	var material = get_parent().get_node("triggers/t2/MeshInstance").get_surface_material(0)
#	material.albedo_color = Color("14ff00")
#	get_parent().get_node("triggers/t2/MeshInstance").set_surface_material(0, material)
#
#	get_parent().get_node("triggers/t2").set_collision_layer_bit(0,false)
#	get_parent().get_node("triggers/t2").set_collision_mask_bit(0,false)
