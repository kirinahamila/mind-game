extends Prop

@onready var anim = $AnimationPlayer

@onready var launchZone = $launchZone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if launchZone.has_overlapping_bodies():
		var unknown_bodies := 0
		var overlapping_bodies = launchZone.get_overlapping_bodies()
		for i in overlapping_bodies.size():
			if overlapping_bodies[i] is RigidBody2D:
				overlapping_bodies[i].apply_central_impulse(Vector2(0,-150))
			elif overlapping_bodies[i] is CharacterBody2D:
				overlapping_bodies[i].velocity += Vector2(0,-1000)
			else:
				unknown_bodies += 1
		## if no bodies have functionality, do not play the animation
		if unknown_bodies == overlapping_bodies.size():
			return
		anim.speed_scale = 2
		anim.play("springLaunch")
