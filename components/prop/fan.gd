extends RigidBody2D

@onready var anim = $AnimationPlayer

@onready var fanBox = $fanBox

var propName = "Fan"
@export var propSprite: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("fanSpin")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var force = fanBox.global_position - global_position
	force = force.normalized() * 1000
	
	if fanBox.has_overlapping_bodies():
		for i in fanBox.get_overlapping_bodies().size():
			if fanBox.get_overlapping_bodies()[i] is RigidBody2D:
				fanBox.get_overlapping_bodies()[i].apply_central_force(force)
			if fanBox.get_overlapping_bodies()[i] is CharacterBody2D:
				fanBox.get_overlapping_bodies()[i].velocity += force/100
