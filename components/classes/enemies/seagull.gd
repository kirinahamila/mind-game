extends Enemy

@onready var anim = $AnimationPlayer
@onready var explosion = $explosion

var waitingForExplosion = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Enemy($sightBox, $hitBox, $hurtBox, $ProgressBar, 100, 30)
	
	$explosion/CollisionShape2D.disabled = true
	explosion.hide()
	
	linear_damp = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dropAttack()
	
	damageScan()
	setupHealthBar()
	
	findPlayer()
	flyBehavior(250)
	
	if health <= 0:
		queue_free()

func dropAttack():
	if attackState:
		if hitBox.has_overlapping_areas() || hitBox.has_overlapping_bodies():
			anim.play("explode")
			await get_tree().create_timer(0.6).timeout
			queue_free()
		
		if !waitingForExplosion:
			waitingForExplosion = true
			await get_tree().create_timer(2.0).timeout
			anim.play("explode")
			await get_tree().create_timer(0.6).timeout
			queue_free()
