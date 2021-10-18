extends ColorRect

var fadein_timer

var rect_material
var material_cutoff = 0.0

func _init():
	fadein_timer = Timer.new()
	add_child(fadein_timer)
	fadein_timer.autostart = false
	fadein_timer.wait_time = 0.05
	fadein_timer.connect("timeout", self, "_fadein")

func _ready():
	self.visible = true
	rect_material = self.get_material()
	fadein_timer.start()
	
func _fadein():
	rect_material.set_shader_param("cutoff", material_cutoff)
	if (material_cutoff == 1.0):
		fadein_timer.stop()
		return

	material_cutoff += 0.1
