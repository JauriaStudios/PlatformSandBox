class_name Player

extends KinematicBody


var speed = Vector3(0.0, 10.0, 12.0)
var velocity = Vector3.ZERO
var falling_slow = false
var falling_fast = false
var no_move_horizontal_time = 0.0

onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var rotspeed = 10

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

var camera_move = 0
var camera_move_max = 0.36

var shoot_rate_timer
var shot_rate = 0.5
var shooting = false

var multiplier = 5

var walk_scale = 2.5
var run_scale = 1.25


var Bullet = preload("res://prefabs/bullet_test.tscn")

func _init():
	shoot_rate_timer = Timer.new()
	add_child(shoot_rate_timer)
	shoot_rate_timer.autostart = false
	shoot_rate_timer.wait_time = shot_rate
	shoot_rate_timer.connect("timeout", self, "shoot_end")
	

func _ready():
	pass
	
func shoot_end():
	shooting = false

func shoot():
	shooting = true
	shoot_rate_timer.start()
	var b = Bullet.instance()
	add_child(b)
	b.transform = $Flare.transform
	b.velocity = -b.transform.basis.z * b.muzzle_velocity

# Physics Loop
func _physics_process(delta):
	
	velocity.y -= gravity * delta
	
	
	if Input.is_action_pressed("shoot"):

		if camera_move < camera_move_max:
			camera_move += 0.02
			$Camera.translate(Vector3(camera_move,0,0))
		if !shooting:
			shoot()
	else:
		if camera_move > 0:
			camera_move -= 0.02
			$Camera.translate(Vector3(-camera_move,0,0))

	# input handler
	# Jump
	if Input.is_action_pressed("jump"):
		jumps_count = 1
	else:
		jumps_count = 0

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = speed.y
		$player/AnimationPlayer.play("fall_down-loop")
	else:
		pass
	# No move
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.z = 0

	elif Input.is_action_pressed("run") and Input.is_action_pressed("ui_left"):

		velocity.z = speed.z * Input.get_action_strength("ui_left")
		if $player.rotation.y <= 90 and $player.rotation.y <= 0:
			rotating_right = true
			player_rotation = delta * rotspeed
			$player.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$player/AnimationPlayer.play("Run")
			$player/AnimationPlayer.set_speed_scale(Input.get_action_strength("ui_left") * run_scale)
			

	elif Input.is_action_pressed("run") and Input.is_action_pressed("ui_right"):
		velocity.z = -speed.z * Input.get_action_strength("ui_right")
		if $player.rotation.y >= 0 and $player.rotation.y <= 90:
			rotating_left = true
			player_rotation = delta * rotspeed
			$player.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$player/AnimationPlayer.play("Run")
			$player/AnimationPlayer.set_speed_scale(Input.get_action_strength("ui_right") * run_scale)
			

	# Crouch Right
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		velocity.z = speed.z * Input.get_action_strength("ui_left") / 3
		if $player.rotation.y <= 90 and $player.rotation.y <= 0:
			rotating_right_crouch = true
			player_rotation = delta * rotspeed
			$player.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$player/AnimationPlayer.play("crouch_walk_forward-loop")
			$player/AnimationPlayer.set_speed_scale(Input.get_action_strength("ui_left") * walk_scale)
			

	# Crouch Left
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		velocity.z = -speed.z * Input.get_action_strength("ui_right") / 3
		if $player.rotation.y >= 0 and $player.rotation.y <= 90:
			rotating_left_crouch = true
			player_rotation = delta * rotspeed
			$player.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$player/AnimationPlayer.play("crouch_walk_forward-loop")
			$player/AnimationPlayer.set_speed_scale(Input.get_action_strength("ui_right") * walk_scale)
			

	# Move Right
	elif Input.is_action_pressed("ui_left"):
		velocity.z = speed.z * Input.get_action_strength("ui_left") / 3
		if $player.rotation.y <= 90 and $player.rotation.y <= 0:
			rotating_right = true
			player_rotation = delta * rotspeed
			$player.rotate(Vector3(0, 1, 0), player_rotation)

		if jumps_count == 0:
			$player/AnimationPlayer.play("Walk")
			$player/AnimationPlayer.set_speed_scale(Input.get_action_strength("ui_left") * walk_scale)
			

	# Move Left
	elif Input.is_action_pressed("ui_right"):
		velocity.z = -speed.z * Input.get_action_strength("ui_right") / 3
		if $player.rotation.y >= 0 and $player.rotation.y <= 90:
			rotating_left = true
			player_rotation = delta * rotspeed
			$player.rotate(Vector3(0, 1, 0), player_rotation)
		if jumps_count == 0:
			$player/AnimationPlayer.play("Walk")
			$player/AnimationPlayer.set_speed_scale(Input.get_action_strength("ui_right") * walk_scale)

	# Crouch
	elif Input.is_action_pressed("ui_down"):
		crouching = true

		if jumps_count == 0:
			$player/AnimationPlayer.play("crouch-loop")

#		vec_pos.z= lerp(vec_pos.z,0,0.5)
#
#
#		$ballColl.scale.z = $ballColl.scale.z / 2
#		$ballColl.translation.y = $ballColl.translation.y / 2


	else:
		$player/AnimationPlayer.play("Idle")
		velocity.z = lerp(velocity.z,0,0.2)


	# Stop rotation when player in position
	if $player.rotation.y >= 0 and rotating_right == true:
		rotating_right = false
	elif $player.rotation.y <= 0 and rotating_left == true:
		rotating_left = false

	if $player.rotation.y >= 0 and rotating_right_crouch == true:
		rotating_right_crouch = false
	elif $player.rotation.y <= 0 and rotating_left_crouch == true:
		rotating_left_crouch = false

	# keep rotation if button released before reach the end of the animation
	if rotating_right_crouch == true:
		$player.rotate(Vector3(0, 1, 0), delta * rotspeed)
		$player/AnimationPlayer.play("crouch_walk_forward-loop")
	elif rotating_left_crouch == true:
		$player.rotate(Vector3(0, 1, 0), delta * rotspeed)
		$player/AnimationPlayer.play("crouch_walk_forward-loop")

	# keep rotation if button released before reach the end of the animation
	if rotating_right == true:
		$player.rotate(Vector3(0, 1, 0), delta * rotspeed)
		$player/AnimationPlayer.play("walk_forward-loop")
	elif rotating_left == true:
		$player.rotate(Vector3(0, 1, 0), delta * rotspeed)
		$player/AnimationPlayer.play("walk_forward-loop")


	velocity = move_and_slide(Vector3(0.0, velocity.y, velocity.z), Vector3.UP)

