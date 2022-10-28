extends Node2D


func _ready():
	$Button.rect_position.y=Game.size.y/2 - $Button.rect_size.y/2 +100
	$Button.rect_position.x=Game.size.x/2 - $Button.rect_size.x/2
	$Highscore.text="Best : %s"%str(Global.highscore)
	pass


func _on_Button_pressed():
	var tween=create_tween()
	tween.tween_property($player,"position:y",-100.0,0.3)
	Game.change_scene("res://scenes/gameplay/gameplay.tscn")
	pass # Replace with function body.

func _process(delta):
	$ParallaxBackground.scroll_offset.y+=1
