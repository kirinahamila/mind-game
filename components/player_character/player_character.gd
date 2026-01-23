extends CharacterBody2D

var health

#Base Stats
var maxSpeed = 200
var groundAcceleration = 20

@export var pushForce = 100

func _process(delta: float) -> void:
	movementInputs()
	
	gravity()
	move_and_slide()
	pushingProps()


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
			velocity.x = 0
	
	if abs(velocity.x) > maxSpeed+groundAcceleration:
		if is_on_floor() && abs(velocity.x) >= 20:
			velocity.x /= 1.1
		else:
			velocity.x = 0
		

#Must be AFTER move and slide 
func pushingProps():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_force(-c.get_normal() * pushForce)
		
