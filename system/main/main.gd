extends Node2D

@onready var camera = $Camera2D

@onready var startScreen = $startScreen
@onready var gameWorld = $GameWorld
@onready var playerCharacter = $CharacterBody2D
@onready var propSelectionMenu = $propSelectionMenu
@onready var propPlacementMenu = $propPlacementMenu
@onready var gameOverScreen = $gameOverScreen

var gameplayElements
var startupElements
var propSelectionElements
var propPlacementElements
var gameOverElements

var packageList

#can be changed to a different string to signify which gamestate the game is in
#uses the updateGameState() function
var gameState = ""

#Game Variables:
var inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Scene packages to help us unload and load scenes faster with the appropriate functions:
	#These have to be put into the ready function
	gameplayElements = [gameWorld, playerCharacter]
	startupElements = [startScreen]
	propSelectionElements = [propSelectionMenu, gameWorld]
	propPlacementElements = [propPlacementMenu, gameWorld]
	gameOverElements = [gameOverScreen]
	
	packageList = [gameplayElements, startupElements, propSelectionElements, propPlacementElements, gameOverElements]
	
	changeGameState("startup")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateGamestate():
	
	#Make sure to always use the unload function before the load function
	match gameState:
		"":
			pass
		"startup":
			unloadAllBut(startupElements)
		"gameplay":
			unloadAllBut(gameplayElements)
		"propSelection":
			unloadAllBut(propSelectionElements)
		"propPlacement":
			unloadAllBut(propPlacementElements)
		"gameOver":
			unloadAllBut(gameOverElements)

func unloadAllBut(package):
	var toLoad: Array
	
	var f = packageList.size()
	for i in f:
		if packageList[i] != package:
			unloadScenes(packageList[i])
		else:
			toLoad.append(packageList[i])
	
	var f2 = toLoad.size()
	for i2 in f2:
		loadScenes(toLoad[i2])

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

func changeGameState(newState):
	gameState = newState
	updateGamestate()

func _on_start_screen_start_game() -> void:
		changeGameState("propSelection")

func _on_prop_selection_menu_prop_placement_time() -> void:
	inventory = propSelectionMenu.curDefenses
	changeGameState("propPlacement")
	propPlacementMenu.setCurProps(inventory)

func _on_prop_placement_menu_props_placed() -> void:
	changeGameState("gameplay")
	gameWorld.levelWaves.Wave(gameWorld.enemyPool, 100)
	gameWorld.activeWave = true
	camera.zoom = Vector2(0.75, 0.75)
	camera.position.y -= 200

func _on_character_body_2d_dead() -> void:
	changeGameState("gameOver")
