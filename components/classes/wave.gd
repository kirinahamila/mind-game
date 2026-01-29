class_name Wave extends Node2D

var waveEnemies: Array

var totalWaveDifficulty
var curWaveDifficulty = 0

var enemyIterator
var chosenEnemy

func Wave(enemies:Array, totalWaveDifficultyp):
	waveEnemies.clear()
	
	totalWaveDifficulty = totalWaveDifficultyp
	curWaveDifficulty = 0
	
	while curWaveDifficulty < totalWaveDifficulty:
		enemyIterator = randi_range(0, enemies.size()-1)
		var newEnemy = enemies[enemyIterator].instantiate()
		waveEnemies.append(newEnemy)
		curWaveDifficulty += newEnemy.difficulty
		print(newEnemy.difficulty)
	
	print(waveEnemies)

func chooseEnemy():
	if waveEnemies.size() > 0:
		var i = randi_range(0, waveEnemies.size()-1)
		chosenEnemy = waveEnemies[i]
		waveEnemies.erase(chosenEnemy)
		return chosenEnemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
