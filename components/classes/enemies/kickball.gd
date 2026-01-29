extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Enemy($sightBox, $hitBox, $hurtBox, $ProgressBar, 250, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	damageScan()
	setupHealthBar()
	
	findPlayer()
	hopBehavior(100)
	
	if health <= 0:
		queue_free()
