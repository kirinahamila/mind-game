class_name PropCard extends Button

@onready var label = $Label
@onready var texture = $TextureRect

var propCardName
var propCardSprite

var selected = false

func PropCard(propCardNamep, propCardSpritep):
	propCardName = propCardNamep
	propCardSprite = propCardSpritep
	
	label = $Label
	label.set_text(propCardName)
	
	texture = $TextureRect
	texture.texture = propCardSprite

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
