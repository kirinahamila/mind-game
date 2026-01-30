class_name Enemy extends Entity

@onready var tag = preload("res://components/tag/tag.tscn")

var speed
var jumpHeight

var jumping = false

var damage
var attackRange

var attackState = false

var sightBox: Area2D
var hitBox: Area2D
var hurtBox: Area2D
var hpBar: ProgressBar

var targetLocation: Vector2
var baseLocation = Vector2(575,400)

var remTars: Array[Area2D]
var iFrames = 0.5

#Fill this array with behaviors that this enemy will use
var behaviors = []

func Enemy(sightBoxp: Area2D, hitBoxp: Area2D, hurtBoxp: Area2D, hpBarp: ProgressBar, jumpHeightp, maxHealthp, difficultyp):
	sightBox = sightBoxp
	hitBox = hitBoxp
	hurtBox = hurtBoxp
	hpBar = hpBarp
	jumpHeight = jumpHeightp
	#difficulty = difficultyp
	
	maxHealth = maxHealthp
	health = maxHealth
	

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
	hpBar.rotation = -rotation

func damageScan():
	if hurtBox.has_overlapping_areas():
		var f = hurtBox.get_overlapping_areas().size()
		
		for i in f:
			if !remTars.has(hurtBox.get_overlapping_areas()[i]):
				health -= hurtBox.get_overlapping_areas()[i].damage
				createTag(hurtBox.get_overlapping_areas()[i].damage, "damage")
				remTars.append(hurtBox.get_overlapping_areas()[i])
				remTarDecay(hurtBox.get_overlapping_areas()[i])
				
				takeKnockback(hurtBox.get_overlapping_areas()[i])

func remTarDecay(hitBox):
	await get_tree().create_timer(iFrames).timeout
	remTars.erase(hitBox)

func takeKnockback(hitBox):
	var length = global_position - hitBox.global_position
	var impulse = length.normalized() * hitBox.knockback
	
	if impulse.y != 0:
		impulse.y -= 100

	apply_central_impulse(impulse)

func setupHealthBar():
	if health == maxHealth:
		hpBar.hide()
	else:
		hpBar.show()
		hpBar.max_value = maxHealth
		hpBar.value = health

func createTag(text, type):
	var damageTag = tag.instantiate()
	
	get_parent().add_child(damageTag)
	damageTag.Tag(text, type)
	
	damageTag.global_position = global_position

func takeDamage(damageTaken):
	health -= damageTaken
	createTag(damageTaken, "damage")

#Below this point are different universal behaviors. Enemies may have their own unique behaviors

func hopBehavior(power):
	if linear_velocity.y <= 10 && linear_velocity.y >= -10 && !jumping:
		jumping = true
		await get_tree().create_timer(1.0).timeout
		hop(power, targetLocation)
		jumping = false

func flyBehavior(targetHeight):
	if global_position.y > targetHeight && !attackState:
		apply_central_force(Vector2(0,-jumpHeight*10))
	
	if abs(targetLocation.x-global_position.x) > 75:
		var impulse = targetLocation-global_position
		impulse = impulse.normalized()*100
		apply_central_force(Vector2(impulse.x, 0))
	else:
		attackState = true
