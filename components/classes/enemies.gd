class_name Enemy extends Entity

var speed
var jumpHeight

var jumping = false

var damage
var attackRange

var sightBox: Area2D
var hitBox: Area2D

var targetLocation: Vector2
var baseLocation = Vector2(0,0)

#Fill this array with behaviors that this enemy will use
var behaviors = []

func Enemy(sightBoxp: Area2D, hitBoxp: Area2D, jumpHeightp):
	sightBox = sightBoxp
	hitBox = hitBoxp
	jumpHeight = jumpHeightp

func findPlayer():
	if sightBox.has_overlapping_areas():
		targetLocation = sightBox.get_overlapping_areas()[0].global_position
	else:
		targetLocation = baseLocation

func moveToTarget():
	if abs(targetLocation.x-position.x) > attackRange:
		pass

func hop(power, direction:Vector2):
	var length = direction - global_position
	var impulse = length.normalized() * power
	impulse.y -= jumpHeight
	apply_central_impulse(impulse)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Below this point are different universal behaviors. Enemies may have their own unique behaviors

func hopBehavior(power):
	if linear_velocity.y <= 10 && linear_velocity.y >= -10 && !jumping:
		jumping = true
		await get_tree().create_timer(0.5).timeout
		hop(power, targetLocation)
		jumping = false
