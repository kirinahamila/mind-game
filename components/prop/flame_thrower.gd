extends Prop

@onready var anim = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("fire")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
