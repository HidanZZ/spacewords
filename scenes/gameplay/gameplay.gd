extends Node

var elapsed = 0
var bullet = preload("res://scenes/objects/bullet.tscn")
var enemies=[]
# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	var cur_scene: Node = get_tree().current_scene
	print("Current scene is: ", cur_scene.name, " (", cur_scene.filename, ")")
	print("gameplay.gd: pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	
	print("Processing...")
	yield(get_tree().create_timer(2), "timeout")
	print("Done")


# `start()` is called when the graphic transition ends.
func start():
	print("gameplay.gd: start() called")


func _process(delta):
	elapsed += delta
	$ParallaxBackground.scroll_offset.y+=1

func _unhandled_input(e):
	if e is InputEventMouseButton and e.pressed:
		$enemy.position.y=-100
		$enemy.position.x = randi()%700
		var tween = create_tween()
		tween.tween_property($enemy,"position",$Sprite.position,10).set_trans(Tween.TRANS_LINEAR)
		
func _input(ev):
	if ev is InputEventKey and ev.scancode in range(Global.keyrange[0],Global.keyrange[1]+1) and not ev.echo:
		print(char(ev.scancode))
		var angle = rad2deg($Sprite.global_position.angle_to_point($enemy.position))
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Sprite,"rotation_degrees",angle-90,0.2)
		tween.tween_callback(self,"spawn",[angle])

func spawn(angle):
	var b=bullet.instance()
	b.position=$Sprite.position
#	b.transform=$Sprite.transform
	b.rotation_degrees=angle-180
	add_child(b)
