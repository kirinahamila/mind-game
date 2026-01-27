extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Enemy($sightBox, $hitBox, 250)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	findPlayer()
	hopBehavior(100)
