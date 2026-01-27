class_name Enemy extends Entity

var speed
var jumpHeight

var damage
var attackRange

var sightBox: Area2D

var targetLocation: Vector2
var baseLocation: Vector2

func Enemy(sightBoxp: Area2D):
	sightBox = sightBoxp

func findPlayer():
	if sightBox.has_overlapping_areas():
		targetLocation = sightBox.get_overlapping_areas()[0].global_position
	else:
		targetLocation = baseLocation

func moveToTarget():
	if abs(targetLocation.x-position.x) > attackRange:
		pass

func hop(power, direction:Vector2):
	direction.normalized()
	var impulse = direction * power
	apply_central_impulse(impulse)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
