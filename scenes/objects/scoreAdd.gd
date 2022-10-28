extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text="+ "+str(score)
	var tween=create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"rect_position:y",-30.0,0.5).as_relative().from_current()
	tween.parallel().tween_property(self,"modulate",Color(1,1,1,0),0.5)
	tween.tween_callback(self,"queue_free")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
