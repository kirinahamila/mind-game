extends Node2D

@onready var kickBall = preload("res://components/classes/enemies/kickball.tscn")

@onready var spawn1 = $enemySpawner1
@onready var spawn2 = $enemySpawner2

var spawning = false
var activeWave = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	spawnCycle()

func spawnCycle():
	if !spawning && activeWave:
		spawning = true
		var newKickball = kickBall.instantiate()
		get_parent().add_child(newKickball)
		
		var spawner = randi_range(1, 2)
		if spawner == 1:
			newKickball.global_position = spawn1.global_position
		else:
			newKickball.global_position = spawn2.global_position
		
		await get_tree().create_timer(2.0).timeout
		spawning = false
