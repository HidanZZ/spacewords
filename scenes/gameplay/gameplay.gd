extends Node

var elapsed = 0
var bullet = preload("res://scenes/objects/bullet.tscn")
var enemy = preload("res://scenes/objects/enemy.tscn")
var enemies
var levels
var focused
var current_level=1
var max_enemy
var enemy_destroyed
# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	randomize()
	Keyboard.connect("key_pressed",self,"_on_key_pressed")
	var file = File.new()	
	file.open("res://assets/words.json", file.READ)
	var json = file.get_as_text()
	levels =  JSON.parse(json).result
	file.close()
	
	
	var cur_scene: Node = get_tree().current_scene
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	
	

func change_counter():
	var counter = $"%counterLabel"
	counter.text=str(enemy_destroyed)+"/"+str(max_enemy)
	print(counter.text)
# `start()` is called when the graphic transition ends.
func start():
	max_enemy=15+(current_level-1)*5
	enemy_destroyed=0
	$level.set_desc(max_enemy)
	$level.set_level(current_level)
	$player.position.y=1380
	change_counter()
	$level.start()


func _process(delta):
	elapsed += delta
	$ParallaxBackground.scroll_offset.y+=1
	
func get_parameter(parameter):
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				var url_string = window.location.href;
				var url = new URL(url_string);
				url.searchParams.get("%s");
			"""%parameter)
	return null

func _on_key_pressed(key):
	var character= char(key)
	if !is_instance_valid(focused):
		var used= get_used_words()
		for i in range(used.size()):
			if character==used[i][0]:
				if get_tree().get_nodes_in_group("enemies")[i].is_on_screen:
					focused=get_tree().get_nodes_in_group("enemies")[i]
	if is_instance_valid(focused):
#		if character==focused.word[0]:
#			var angle = rad2deg($"%player".global_position.angle_to_point(focused.position))
#			var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
#			tween.tween_property($"%player","rotation_degrees",angle-90,0.1)
#			tween.tween_callback(self,"spawn",[angle,focused])
#			yield(get_tree().create_timer(0.15),"timeout")
		if !focused.check(character):
			$error.play(0)
			$player.error()
		

func get_random_word():
	var words_array=levels["level"+str(current_level)]
	return words_array[randi()%words_array.size()]
	
	
func _unhandled_input(e):
	if e is InputEventMouseButton and e.pressed:
		print(get_tree().get_nodes_in_group("enemies").size())

		

#	if ev is InputEventKey and ev.scancode in range(Global.keyrange[0],Global.keyrange[1]+1) and not ev.echo:
#		print(char(ev.scancode))
#		var angle = rad2deg($"%player".global_position.angle_to_point($enemy.position))
#		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
#		tween.tween_property($"%player","rotation_degrees",angle-90,0.2)
#		tween.tween_callback(self,"spawn",[angle])

func spawn(angle,pos,last,target):
	var b=bullet.instance()
	b.position=$"%player".position
#	b.pos=pos
	b.target=target
	b.last_bullet=last
#	b.rotation_degrees=angle-180
	add_child(b)

func get_used_words():
	var used = []
	for i in get_tree().get_nodes_in_group("enemies"):
		used.append(i.word)
	return used
	
	
func next_level():
	current_level+=1
	if current_level>3:
		pass
	else:
		start()

func spawn_enemy():
	var e = enemy.instance()
	e.position=Vector2(randi()%700,-100.0)
	var used=get_used_words()
	var word=get_random_word()
	var first_char_array =[]
	for i in used:
		if i.length()>0:
			first_char_array.append(i[0])
	while word in get_used_words() or word[0] in first_char_array:
		word = get_random_word()
	e.word=word
	e.initial_size=word.length()
	e.dest=$"%player".position
	e.connect("shoot_self",self,"_on_enemy_shoot")
	e.connect("destroyed",self,"_on_enemy_destroyed")
	add_child(e)
func _on_enemy_shoot(position,last,target):
	var angle = rad2deg($"%player".global_position.angle_to_point(position))
#	Engine.time_scale=0.5
	spawn(angle,position,last,target)
	_play_audio()

func _on_enemy_destroyed():
	$explode.play(0)
	enemy_destroyed+=1
	change_counter()
	animate_counter()
	if enemy_destroyed==max_enemy:
		get_tree().call_group("enemies","stop")
		$spawner.stop()
		$level.completed()

func animate_counter():
	var counter= $"%counterLabel"
	var tween=create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(counter,"rect_scale",Vector2.ONE/2.0,0.2).as_relative().from_current()
	tween.tween_property(counter,"rect_scale",Vector2.ONE,0.2)
	

func _on_spawner_timeout():
	if (get_tree().get_nodes_in_group("enemies").size()<6):
		spawn_enemy()
	var all=[]
	for i in get_tree().get_nodes_in_group("enemies"):
		all.append(i.word)
	$spawner.start(rand_range(1.5-(current_level*0.3),2.0-(current_level*0.3)))
	 # Replace with function body.
func _play_audio():
	if !focused:
		return
	var audio = $shoot
	audio.pitch_scale=1.75-((1.0/focused.initial_size)*(focused.word.length()+1))
	print("initial ",focused.initial_size)
	print("current ",focused.word.length())
	print("mult ",(0.75/focused.initial_size)*(focused.word.length()+1))
	print(audio.pitch_scale)
	audio.play(0)
	


func _on_player_hit():
	var tween = create_tween()
	tween.tween_property($hp,"value",-20.0,0.3).as_relative().from_current()# Replace with function body.


func _on_level_finished_trans():
	var tween= create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($player,"position:y",1171.0,0.5)
	tween.tween_property($hp,"value",100.0,0.5)
	tween.tween_property($UI/counter,"position:x",0.0,0.3)
	tween.tween_callback($spawner,"start",[rand_range(1.5-(current_level*0.3),2.0-(current_level*0.3))])


func _on_level_finished_comp():
	var tween= create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($player,"position:y",-100.0,2.0)
	tween.tween_callback(self,"next_level")# Replace with function body.
