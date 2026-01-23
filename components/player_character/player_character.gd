extends CharacterBody2D

var health

#Base Stats
var maxSpeed = 200
var groundAcceleration = 20

func _process(delta: float) -> void:
	movementInputs()
	
	gravity()
	move_and_slide()


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
			velocity.x /= 2
		else:
			velocity.x = 0
