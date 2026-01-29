class_name Attack extends Area2D

@export var damage = 0
@export var knockback = 0

@export var effect = ""

@export var shovePower = 0


var remProps: Array


func Attack(damagep, knockbackp):
	damage = damagep
	knockback = knockbackp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	propShoving()

func propShoving():
	if has_overlapping_bodies():
		var props = get_overlapping_bodies()
		for i in props.size():
			if props[i] is RigidBody2D && !remProps.has(props[i]):
				print("pushed")
				var impulse = props[i].global_position - global_position
				impulse = impulse.normalized() * shovePower
				props[i].apply_central_impulse(impulse)
				remProps.append(props[i])
				decayRemProps(props[i])

func decayRemProps(theProp):
	await get_tree().create_timer(0.75).timeout
	remProps.erase(theProp)
