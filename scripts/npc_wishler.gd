extends KinematicBody


var player_in_area = false
var wishler_talk = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$dialog.hide()



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
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
