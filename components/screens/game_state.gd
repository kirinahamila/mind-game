class_name GameState
extends Node

var rounds: Array[Round]


func end_game(isVictory: bool) -> void:
	pass

class Wave:
	var enemies: Array
	
	func end():
		pass

class Round:
	var waves: Array[Wave]
	
	func start() -> void:
		pass
	func end() -> void:
		pass
