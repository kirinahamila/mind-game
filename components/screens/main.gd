extends Node2D

@onready var startScreen = $startScreen
@onready var gameWorld = $GameWorld
@onready var playerCharacter = $CharacterBody2D

var gameplayElements
var startupElements

#can be changed to a different string to signify which gamestate the game is in
#uses the updateGameState() function
var gameState = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Scene packages to help us unload and load scenes faster with the appropriate functions:
	#These have to be put into the ready function
	gameplayElements = [gameWorld, playerCharacter]
	startupElements = [startScreen]
	
	gameState = "startup"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateGamestate()

func updateGamestate():
	#Make sure to always use the unload function before the load function
	match gameState:
		"":
			pass
		"startup":
			unloadScenes(gameplayElements)
			loadScenes(startupElements)
		"gameplay":
			unloadScenes(startupElements)
			loadScenes(gameplayElements)

func loadScenes(scenePackage: Array):
	var f = scenePackage.size()
	for i in f:
		scenePackage[i].show()
		scenePackage[i].process_mode = 0

func unloadScenes(scenePackage: Array):
	var f = scenePackage.size()
	for i in f:
			scenePackage[i].hide()
			scenePackage[i].process_mode = 4


func _on_start_screen_start_game() -> void:
		gameState = "gameplay"
