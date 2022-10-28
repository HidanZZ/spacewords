extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal scene_changed

func In(duration:float):
	self.material.set_shader_param("position", -2.5)
	self.material.set_shader_param("in_out", 0.0)
	self.material.set_shader_param("direction", -1.0)
	var tween=create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(self.material,"shader_param/position",1.0,duration).from(-2.5)
	tween.tween_callback(self,"emit_signal",["scene_changed"])
	tween.tween_callback(self,"print_value",["in"])
	
func Out(duration:float):
	self.material.set_shader_param("position", 1.0)
	self.material.set_shader_param("in_out", 1.0)
	self.material.set_shader_param("direction", 1.0)
	
	var tween=create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self.material,"shader_param/position",-2.5,duration).from(1.0)
	tween.tween_callback(self,"print_value",["out"])
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func print_value(v):
	print(OS.get_time())
	print(v)
	print(self.material.get_shader_param("position"))
	print(self.material.get_shader_param("direction"))
