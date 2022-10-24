extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 1500
var target
var pos
var last_bullet
# Called when the node enters the scene tree for the first time.
func _ready():
#	var tween=create_tween().set_ease(Tween.EASE_OUT)
#	var dur=position.distance_to(pos)/1700.0
#	tween.tween_property(self,"position",pos,dur)
	pass # Replace with function body.

func _physics_process(delta):
	look_at(target.global_position)
	position = position.move_toward(target.global_position,speed*delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
