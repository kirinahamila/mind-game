extends Prop

@onready var anim = $AnimationPlayer

var propName = "Flamethrower"
@export var propSprite: Texture2D

var propDesc = "The Flamethrower shoots a pillair of fire into the sky. \nIt is great for taking out flying enemies!"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("fire")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
