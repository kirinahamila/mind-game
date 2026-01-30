class_name PropCard extends Button

@onready var myTooltip = preload("res://my_tool_tip.tscn")

@onready var label = $Label
@onready var texture = $TextureRect

var propCardName
var propCardSprite
var propCardDesc

var selected = false

func PropCard(propCardNamep, propCardSpritep, propCardDescp):
	propCardName = propCardNamep
	propCardSprite = propCardSpritep
	propCardDesc = propCardDescp
	
	label = $Label
	label.set_text(propCardName)
	
	texture = $TextureRect
	texture.texture = propCardSprite
	
	tooltip_text = propCardDesc
	
	var newStyleBox = StyleBoxFlat.new()
	newStyleBox.set_bg_color(Color(0,0,0))
	newStyleBox.set_border_width_all(1)
	theme.set_stylebox("panel", "TooltipPanel", newStyleBox)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	selected = true

func _on_mouse_exited() -> void:
	selected = false
