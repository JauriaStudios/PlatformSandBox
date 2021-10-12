extends Control


var fadein_timer
var fadeout_timer

var rect_material
var material_cutoff = 0.0

func _init():
	
	fadein_timer = Timer.new()
	add_child(fadein_timer)
	fadein_timer.autostart = false
	fadein_timer.wait_time = 0.05
	fadein_timer.connect("timeout", self, "_fadein")
	
	fadeout_timer = Timer.new()
	add_child(fadeout_timer)
	fadeout_timer.autostart = false
	fadeout_timer.wait_time = 0.05
	fadeout_timer.connect("timeout", self, "_fadeout")


func _ready():
	$fade_in.visible = true
	rect_material = $fade_in.get_material()
	fadein_timer.start()
	
func _fadein():
	rect_material.set_shader_param("cutoff", material_cutoff)
	if (material_cutoff == 1.0):
		fadein_timer.stop()
		return
		
	material_cutoff += 0.1

func _fadeout():
	rect_material.set_shader_param("cutoff", material_cutoff)
	if (material_cutoff == 0.0):
		fadeout_timer.stop()
		return
	material_cutoff -= 0.1



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_SpinBox_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_soundtest_button_mouse_entered():
	$menu_sfx.play()
	
func _on_back_options_button_mouse_entered():
	$menu_sfx.play()

func _on_save_button_mouse_entered():
	$menu_sfx.play()

func _on_back_options_button_pressed():
	fadeout_timer.start()
	get_tree().change_scene("res://scenes/options.tscn")

func _on_soundtest_button_pressed():
	get_tree().change_scene("res://scenes/sound_test.tscn")
