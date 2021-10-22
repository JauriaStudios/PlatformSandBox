extends KinematicBody


var rand_generate = RandomNumberGenerator.new()

var player_in_area = false
var wishler_talk = false

var roaming_walk = true
var walking = false
var roaming_walk_timer

var speed = Vector3(0.0, 2.0, 4.0)
var velocity = Vector3.ZERO

onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# Called when the node enters the scene tree for the first time.
func _ready():
	rand_generate.randomize()
	$dialog.hide()

	roaming_walk_timer = Timer.new()
	add_child(roaming_walk_timer)
	roaming_walk_timer.autostart = false
	roaming_walk_timer.connect("timeout", self, "walk_end")


# Loop
func _physics_process(delta):
	
	velocity.y -= gravity * delta
	
	if roaming_walk == true:
		if !walking:
			var walk_time = rand_generate.randi_range(0,2)
			var direction = rand_generate.randi_range(0,1)
			walking = true
			roaming_walk_timer.wait_time = walk_time
			roaming_walk_timer.start()
			if direction:
				velocity.z = speed.z
			else:
				velocity.z = -speed.z

	velocity = move_and_slide(Vector3(0.0, velocity.y, velocity.z), Vector3.UP)
			
func walk_end():
	velocity.z = 0
	walking = false



# Loop
func _process(delta):
	if Input.is_action_pressed("action"):
		if player_in_area == true:
			if wishler_talk == false:
				$dialog.show()
				wishler_talk = true
			else:
				$dialog.hide()



func _on_WishlerEventArea_body_entered(body):
	player_in_area = true

func _on_WishlerEventArea_body_exited(body):
	player_in_area = false
