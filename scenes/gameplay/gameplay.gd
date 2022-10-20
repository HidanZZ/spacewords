extends Node

var elapsed = 0

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
#	
#	$Sprite.position.x = Game.size.x / 2 + 150 * sin(2 * 0.4 * PI * elapsed)
#	$Sprite.position.y = Game.size.y / 2 + 100 * sin(2 * 0.2 *  PI * elapsed)
	$ParallaxBackground.scroll_offset.y+=1

func _unhandled_input(e):
	if e is InputEventMouseButton and e.pressed:
		print('pressded')
		var pos = e.position
		var vector_towards_target = pos - $Sprite.global_position; 
		var angle = rad2deg($Sprite.global_position.angle_to_point(pos))-90
		print('angle',angle)
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Sprite,"rotation_degrees",angle,0.5)
		
