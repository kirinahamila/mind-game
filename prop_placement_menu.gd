extends Node2D

signal propsPlaced

@onready var panel = $SelectionPanel
@onready var grid = $SelectionPanel/grid

@onready var propCard = preload("res://components/classes/prop_card.tscn")

var curProps: Array

var heldProp

func setCurProps(props):
	curProps = props
	updateHotbar()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	holdProp()
	findSelectedProp()
	
	if curProps.is_empty():
		emit_signal("propsPlaced")


func updateHotbar():
	clearGrid()
	
	var f = curProps.size()
	for i in f:
		var newCard = propCard.instantiate()
		grid.add_child(newCard)
		newCard.PropCard(curProps[i].propName, curProps[i].propSprite)

func clearGrid():
	var f = grid.get_child_count()
	for i in f:
		grid.get_child(i).queue_free()

func findSelectedProp():
	if Input.is_action_just_pressed("place"):
		var f = curProps.size()
		for i in f:
			if grid.get_child(i).selected:
				placeProp(curProps[i])

func placeProp(prop):
	panel.hide()
	panel.process_mode = 4
	
	get_parent().add_child(prop)
	heldProp = prop

func holdProp():
	if heldProp != null:
		heldProp.freeze = true
		heldProp.position = get_global_mouse_position()
		if Input.is_action_just_pressed("place"):
			heldProp.freeze = false
			panel.show()
			panel.process_mode = 0
			curProps.erase(heldProp)
			heldProp = null
			updateHotbar()
