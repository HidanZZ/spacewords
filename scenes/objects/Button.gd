extends TextureButton


# Declare member variables here. Examples:
# var a = 2

# var b = "text"
export(Color) var font_color:Color
export(int) var font_size:int
export(String) var text: String 
export(int, "White", "Red", "Yellow") var tex
var _texture_x_region=[57.502,363.079,657.473]
var textu:AtlasTexture
# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/Label.text=str(text)
	$CenterContainer/Label.get_font("font").size=font_size
	$CenterContainer/Label.add_color_override("font_color",font_color)
	self.texture_normal.region.position.x=_texture_x_region[tex]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
