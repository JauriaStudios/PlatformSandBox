extends Spatial

func _ready():
	# Play standing forever
	var anim = $AnimationPlayer.get_animation("standing")
	anim.set_loop(true)
	
	$AnimationPlayer.play("standing")
	pass # Replace with function body.

#func _process(delta):
#	pass
