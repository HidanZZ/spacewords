extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal shoot_self
signal destroyed
var dest:Vector2
var word:String
var initial_size
var is_on_screen=false
var rotation_cross=false
var just_focused=false
var speed=200
var original_word:String
var stop=false
export var deathParticle:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	original_word=word
	scale_astreoid()
	var text=" "+str(original_word)+" "
	$"%text".bbcode_text=text
	var size=$"%text".get_font("normal_font").get_string_size(text)
	$"%text".set_size(size)
	$"%text".margin_bottom=0

func scale_astreoid():
	var perc=original_word.length()*0.25
	$Sprite.scale+=$Sprite.scale*perc
	$CollisionShape2D.scale+=$CollisionShape2D.scale*perc
	
func _change_text():
	var text=original_word.substr(0,original_word.length()-word.length())
	text=" "+"[color=#DC5F00]%s[/color]"%text+word+" "
	$"%text".bbcode_text=text
	

func _physics_process(delta):
	if !stop:
		$Sprite.rotate(delta)
		position=position.move_toward(dest,speed*delta)

func stop():
	stop=true
	explode()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func explode():
	var _p = deathParticle.instance()
	_p.position=global_position
	_p.rotation=global_rotation
	_p.emitting=true
	get_tree().current_scene.add_child(_p)
	queue_free()
func check(character):
	if word.length()!=0:
		if !just_focused:
			_show_cross(true)
			just_focused=true
		if character == word[0]:
			word=word.substr(1)
			_change_text()
			var last_bullet= word.length()==0
			emit_signal("shoot_self",position,last_bullet,self)
			return true
		else:
			return false
		
		
func _on_enemy_area_entered(area):
	if area.has_method("hit"):
		area.hit()
		
		queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	is_on_screen=true # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	is_on_screen=false # Replace with function body.


func _on_enemy_body_entered(body):
	
	if body.target==self:
		if body.last_bullet and word.length()==0:
			emit_signal("destroyed")
			explode()
			
		push_back()
		_show_cross()
		body.queue_free()
		 # Replace with function body.

func push_back():
	var vec=(position-dest)
	var tween=create_tween().set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self,"position",Vector2.UP.rotated(vec.angle())*2,0.1).as_relative().from_current()

func rotate_cross():
	var _sign=-1 if rotation_cross else 1
	
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).set_loops(1)
	tween.connect("finished",self,"_on_cross_rotate")
	tween.tween_property($cross,"rotation_degrees",_sign*45.0,0.3).as_relative().from_current()
	tween.tween_property($cross,"rotation_degrees",_sign*-45.0,0.3).as_relative().from_current()
	rotation_cross=!rotation_cross
	
func _on_cross_rotate():
	rotate_cross()

func _show_cross(init=false):
	print('show')
	
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	if !init:
		tween.tween_property($cross,"scale",Vector2(1,1),0.3)
	tween.tween_property($cross,"scale",Vector2(0.5,0.5),0.15 if init else 0.3)
	just_focused=true
#	rotate_cross()
