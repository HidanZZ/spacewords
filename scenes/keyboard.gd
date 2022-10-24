extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal key_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(ev):
	if  ev is InputEventKey:
		if Input.is_key_pressed(KEY_A) && !ev.echo:
			emit_signal("key_pressed",KEY_A)
		elif Input.is_key_pressed(KEY_B) && !ev.echo:
			emit_signal("key_pressed",KEY_B)
		elif Input.is_key_pressed(KEY_C) && !ev.echo:
			emit_signal("key_pressed",KEY_C)
		elif Input.is_key_pressed(KEY_D) && !ev.echo:
			emit_signal("key_pressed",KEY_D)
		elif Input.is_key_pressed(KEY_E) && !ev.echo:
			emit_signal("key_pressed",KEY_E)
		elif Input.is_key_pressed(KEY_F) && !ev.echo:
			emit_signal("key_pressed",KEY_F)
		elif Input.is_key_pressed(KEY_G) && !ev.echo:
			emit_signal("key_pressed",KEY_G)
		elif Input.is_key_pressed(KEY_H) && !ev.echo:
			emit_signal("key_pressed",KEY_H)
		elif Input.is_key_pressed(KEY_I) && !ev.echo:
			emit_signal("key_pressed",KEY_I)
		elif Input.is_key_pressed(KEY_J) && !ev.echo:
			emit_signal("key_pressed",KEY_J)
		elif Input.is_key_pressed(KEY_K) && !ev.echo:
			emit_signal("key_pressed",KEY_K)
		elif Input.is_key_pressed(KEY_L) && !ev.echo:
			emit_signal("key_pressed",KEY_L)
		elif Input.is_key_pressed(KEY_M) && !ev.echo:
			emit_signal("key_pressed",KEY_M)
		elif Input.is_key_pressed(KEY_N) && !ev.echo:
			emit_signal("key_pressed",KEY_N)
		elif Input.is_key_pressed(KEY_O) && !ev.echo:
			emit_signal("key_pressed",KEY_O)
		elif Input.is_key_pressed(KEY_P) && !ev.echo:
			emit_signal("key_pressed",KEY_P)
		elif Input.is_key_pressed(KEY_Q) && !ev.echo:
			emit_signal("key_pressed",KEY_Q)
		elif Input.is_key_pressed(KEY_R) && !ev.echo:
			emit_signal("key_pressed",KEY_R)
		elif Input.is_key_pressed(KEY_S) && !ev.echo:
			emit_signal("key_pressed",KEY_S)
		elif Input.is_key_pressed(KEY_T) && !ev.echo:
			emit_signal("key_pressed",KEY_T)
		elif Input.is_key_pressed(KEY_U) && !ev.echo:
			emit_signal("key_pressed",KEY_U)
		elif Input.is_key_pressed(KEY_V) && !ev.echo:
			emit_signal("key_pressed",KEY_V)
		elif Input.is_key_pressed(KEY_W) && !ev.echo:
			emit_signal("key_pressed",KEY_W)
		elif Input.is_key_pressed(KEY_X) && !ev.echo:
			emit_signal("key_pressed",KEY_X)
		elif Input.is_key_pressed(KEY_Y) && !ev.echo:
			emit_signal("key_pressed",KEY_Y)
		elif Input.is_key_pressed(KEY_Z) && !ev.echo:
			emit_signal("key_pressed",KEY_Z)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
