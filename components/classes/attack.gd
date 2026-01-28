class_name Attack extends Area2D

@export var damage = 0
@export var knockback = 0

@export var effect = ""

func Attack(damagep, knockbackp):
	damage = damagep
	knockback = knockbackp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
