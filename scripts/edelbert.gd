extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Play standing forever
	var anim = $AnimationPlayer.get_animation("standing")
	anim.set_loop(true)
	
	$AnimationPlayer.play("standing")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
