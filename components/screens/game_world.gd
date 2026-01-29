extends Node2D

@onready var kickBall = preload("res://components/classes/enemies/kickball.tscn")
@onready var seagull = preload("res://components/classes/enemies/seagull.tscn")

@onready var spawn1 = $enemySpawner1
@onready var spawn2 = $enemySpawner2

var spawning = false
var activeWave = false

var enemyPool
var enemySelect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyPool = [kickBall, seagull]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	spawnCycle()

func spawnCycle():
	if !spawning && activeWave:
		spawning = true
		
		
		enemySelect = randi_range(0,enemyPool.size()-1)
		var newEnemy = enemyPool[enemySelect].instantiate()
		print(newEnemy)
		get_parent().add_child(newEnemy)
		
		var spawner = randi_range(1, 2)
		if spawner == 1:
			newEnemy.global_position = spawn1.global_position
		else:
			newEnemy.global_position = spawn2.global_position
		
		await get_tree().create_timer(2.0).timeout
		spawning = false
