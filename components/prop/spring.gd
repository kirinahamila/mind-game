extends RigidBody2D

@onready var launchZone = $launchZone

var propName = "Spring"
@export var propSprite: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if launchZone.has_overlapping_bodies():
		for i in launchZone.get_overlapping_bodies().size():
			if launchZone.get_overlapping_bodies()[i] is RigidBody2D:
				launchZone.get_overlapping_bodies()[i].apply_central_impulse(Vector2(0,-250))
			if launchZone.get_overlapping_bodies()[i] is CharacterBody2D:
				launchZone.get_overlapping_bodies()[i].velocity += Vector2(0,-1000)
