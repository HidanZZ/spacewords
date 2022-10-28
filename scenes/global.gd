extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save = "user://data"
var highscore=0
var keyrange=[65,90]
signal stop
# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	pass # Replace with function body.

func load_data():
	var f = File.new()
	if f.file_exists(save):
		f.open(save, File.READ)
		highscore = f.get_16()
		f.close()
	

# call this at game end to store a new highscore
func save_data():
	var f = File.new()
	f.open(save, File.WRITE)
	f.store_16(highscore)
	f.close()

func stop():
	emit_signal("stop")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
