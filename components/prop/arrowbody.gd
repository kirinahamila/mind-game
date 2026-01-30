extends Prop

@onready var hitBox = $hitBox

var direction: Vector2

var timerStart = false

func setDirection(directionp: Vector2):
	direction = directionp.normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_central_impulse(direction * 1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hitBox.has_overlapping_areas()||hitBox.has_overlapping_bodies():
		queue_free()
	
	if !timerStart:
		timerStart = true
		await get_tree().create_timer(3.0).timeout
		queue_free()
	
