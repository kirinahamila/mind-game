extends CharacterBody2D

@onready var hurtBox = $hurtBox
@onready var anim = $AnimationPlayer
@onready var weapons = $weapons

@onready var baseballBat = $weapons/baseballBat

var health = 100

#Base Stats
var maxSpeed = 200
var groundAcceleration = 20

#Upgrades:
var curWeapon = "baseballBat"

@export var pushForce = 100

#Iframe vars
var remTars: Array[Area2D]
var iFrames = 0.25


func _process(delta: float) -> void:
	damageScan()
	movementInputs()
	attack()
	
	gravity()
	move_and_slide()
	pushingProps()

func damageScan():
	if hurtBox.has_overlapping_areas():
		var f = hurtBox.get_overlapping_areas().size()
		
		for i in f:
			if !remTars.has(hurtBox.get_overlapping_areas()[i]):
				health -= hurtBox.get_overlapping_areas()[i].damage
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
	
	velocity += impulse

func movementInputs():
	if Input.is_action_pressed("right") && velocity.x <= maxSpeed:
		velocity.x += groundAcceleration
	if Input.is_action_pressed("left") && velocity.x >= -maxSpeed:
		velocity.x += -groundAcceleration
	if Input.is_action_just_pressed("up") && is_on_floor():
		velocity.y -= 500

func gravity():
	if !is_on_floor() && velocity.y < 500:
		velocity.y += 10
	if Input.is_action_just_released("up") && velocity.y < 0:
		velocity.y /= 3
	
	if !Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
		if is_on_floor() && abs(velocity.x) >= 20:
			velocity.x /= 1.1
		else:
			velocity.x /= 1.1
	
	if abs(velocity.x) > maxSpeed+groundAcceleration:
		if is_on_floor() && abs(velocity.x) >= 20:
			velocity.x /= 1.1
		else:
			velocity.x /= 1.1
	
	if velocity.y < -500:
		velocity.y = -500

#Must be AFTER move and slide 
func pushingProps():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_force(-c.get_normal() * pushForce)

func attack():
	if Input.is_action_just_pressed("place"):
		match curWeapon:
			"baseballBat":
				baseballBatAttack()
			"":
				baseballBat.hide()
				baseballBat.monitorable = false

func baseballBatAttack():
	weapons.look_at(get_global_mouse_position())
	anim.play("baseballBatAttack")

func _ready() -> void:
	$weapons/baseballBat/Sprite2D.hide()
	$weapons/baseballBat/CollisionShape2D.disabled = true
