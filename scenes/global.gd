extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var keyrange=[65,90]
signal stop
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func stop():
	emit_signal("stop")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass