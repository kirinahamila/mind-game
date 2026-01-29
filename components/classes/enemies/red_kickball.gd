extends Enemy

@onready var anim = $AnimationPlayer

var difficulty = 25

var launched = false
var waitingForExplode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Enemy($sightBox, $hitBox, $hurtBox, $ProgressBar, 200, 150, 25)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	damageScan()
	setupHealthBar()
	
	findPlayer()
	
	if abs(targetLocation.x-global_position.x) > 250 && !waitingForExplode:
		hopBehavior(80)
	else:
		attackBehavior()
	
	if health <= 0:
		queue_free()

func attackBehavior():
	if !launched:
		launched = true
		var impulse = targetLocation - global_position
		impulse = impulse.normalized() * 500
		apply_central_impulse(impulse)
	
	if !waitingForExplode:
		waitingForExplode = true
		await get_tree().create_timer(3.0).timeout
		anim.play("explode")
		await get_tree().create_timer(0.6).timeout
		queue_free()
