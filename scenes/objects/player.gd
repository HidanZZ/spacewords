extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal hit
export var deathParticle:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func hit():
	emit_signal('hit')

func error():
	$AnimationPlayer.play("error")

func death():
	var _p = deathParticle.instance()
	_p.modulate=Color.white
	_p.position=global_position
	_p.rotation=global_rotation
	_p.emitting=true
	get_tree().current_scene.add_child(_p)
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
