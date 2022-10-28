extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal completed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func animate():
	self.scale=Vector2.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2.ONE,1.0)
	tween.tween_property(self,"scale",Vector2.ZERO,1.0).set_delay(1.5).set_ease(Tween.EASE_IN)
	tween.tween_callback(self,"set_visible",[false])
	tween.tween_callback(self,"emit_signal",["completed"])

func set_visible(value):
	self.visible=value
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
