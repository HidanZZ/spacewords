extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal finished_trans
signal finished_comp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	var label=$Label
	var desc=$desc
	var lvl=$LVL
	label.rect_position.x=-300
	lvl.rect_position.x=1000
	desc.rect_position.x=-600
	var tween=create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label,"rect_position:x",126.0,0.5)
	tween.parallel().tween_property(lvl,"rect_position:x",316.0,0.5)
	tween.tween_property(desc,"rect_position:x",126.0,0.5)
	tween.tween_property(label,"rect_position:x",-300.0,0.5).set_delay(1.0)
	tween.parallel().tween_property(lvl,"rect_position:x",1000.0,0.5).set_delay(1.0)
	tween.parallel().tween_property(desc,"rect_position:x",-600.0,0.5).set_delay(1.0)
	tween.tween_callback(self,"emit_signal",["finished_trans"])
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_desc(number):
	$desc.bbcode_text="Objectif : Destroy [color=#DC5F00]%s[/color] asteroids"%str(number)

func completed():
	var comp = $Completed
	comp.rect_position.x=720.0
	var tween=create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(comp,"rect_position:x",44.0,0.5)
	tween.tween_property(comp,"rect_position:x",720.0,0.5).set_delay(1.0)
	tween.tween_callback(self,"emit_signal",["finished_comp"])
