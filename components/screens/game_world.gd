extends Node2D

signal waveProgress

@onready var levelWaves = $waveHandler
@onready var label = $Label

@onready var kickBall = preload("res://components/classes/enemies/kickball.tscn")
@onready var seagull = preload("res://components/classes/enemies/seagull.tscn")
@onready var redKickball = preload("res://components/classes/enemies/red_kickball.tscn")

@onready var spawn1 = $enemySpawner1
@onready var spawn2 = $enemySpawner2

var spawning = false
var activeWave = false
var waveChanging = false

var enemyPool
var enemySelect
var waveTime

var currentWave = 0
var curWaveDifficulty = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyPool = [kickBall, seagull, redKickball]

func restart():
	currentWave = 0
	curWaveDifficulty = 100
	spawning = false
	activeWave = false
	waveChanging = false
	clearEnemies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	spawnCycle()
	updateLabel()

func spawnCycle():
	if !spawning && activeWave:
		spawning = true
		
		var newEnemy = levelWaves.chooseEnemy()
		levelWaves.add_child(newEnemy)
		
		
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
		
		if newEnemy == null && !waveChanging && currentWave % 5 != 0:
			waveChanging = true
			await get_tree().create_timer(5.0).timeout
			currentWave += 1
			curWaveDifficulty += 25
			levelWaves.Wave(enemyPool, curWaveDifficulty)
			waveChanging = false
		
		if levelWaves.get_children().size() <= 0 && currentWave % 5 == 0:
			waveChanging = true
			currentWave += 1
			curWaveDifficulty += 100
			waveChanging = false
			activeWave = false
			emit_signal("waveProgress")
			
		

func updateLabel():
	label.text = "Current Wave: " + str(currentWave)

func clearEnemies():
	for i in levelWaves.get_children().size():
		levelWaves.get_children()[i].queue_free()
