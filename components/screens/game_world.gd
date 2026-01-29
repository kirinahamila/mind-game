extends Node2D

@onready var levelWaves = $waveHandler
@onready var label = $Label

@onready var kickBall = preload("res://components/classes/enemies/kickball.tscn")
@onready var seagull = preload("res://components/classes/enemies/seagull.tscn")

@onready var spawn1 = $enemySpawner1
@onready var spawn2 = $enemySpawner2

var spawning = false
var activeWave = false

var enemyPool
var enemySelect
var waveTime

var currentWave = 0
var curWaveDifficulty = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyPool = [kickBall, seagull]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	spawnCycle()
	updateLabel()

func spawnCycle():
	if !spawning && activeWave:
		spawning = true
		
		var newEnemy = levelWaves.chooseEnemy()
		get_parent().add_child(newEnemy)
		
		
		if newEnemy != null:
			var spawner = randi_range(1, 2)
			if spawner == 1:
				newEnemy.global_position = spawn1.global_position
			else:
				newEnemy.global_position = spawn2.global_position
		if currentWave*0.1 < 2.0:
			waveTime = currentWave*0.1
		else:
			waveTime = 1.9
		await get_tree().create_timer(2.0-waveTime).timeout
		spawning = false
		
		if newEnemy == null:
			currentWave += 1
			curWaveDifficulty += 25
			levelWaves.Wave(enemyPool, curWaveDifficulty)
			print(currentWave)

func updateLabel():
	label.text = "Current Wave: " + str(currentWave)
