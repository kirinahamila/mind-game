extends Node2D

signal propsPlaced

@onready var mouse = $mouse
@onready var panel = $SelectionPanel
@onready var grid = $SelectionPanel/grid

@onready var propCard = preload("res://system/ui/prop_card/prop_card.tscn")

var placedPropsSave: Array

var curProps: Array

var heldProp: RigidBody2D

var targetRotation = 0

var placeBuffer = false

func setCurProps(props):
	curProps = props
	updateHotbar()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func restart():
	placeBuffer = false
	clearProps()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	holdProp()
	findSelectedProp()
	
	mouse.global_position = get_global_mouse_position()
	
	if curProps.is_empty() && heldProp == null:
		emit_signal("propsPlaced")


func updateHotbar():
	clearGrid()
	
	var f = curProps.size()
	for i in f:
		var newCard = propCard.instantiate()
		grid.add_child(newCard)
		newCard.PropCard(curProps[i].propName, curProps[i].propSprite, curProps[i].propDesc)

func clearGrid():
	var f = grid.get_child_count()
	for i in f:
		grid.get_child(i).queue_free()

func findSelectedProp():
	if Input.is_action_just_pressed("place"):
		var f = curProps.size()
		for i in f:
			if grid.get_child(i).selected:
				placeProp(curProps[i], true)
	
	if Input.is_action_just_pressed("place") && heldProp == null && !placeBuffer:
		print("1")
		
		if mouse.has_overlapping_areas():
			print("2")
			placeProp(mouse.get_overlapping_areas()[0], false)
		if mouse.has_overlapping_bodies():
			print("2")
			placeProp(mouse.get_overlapping_bodies()[0], false)

func placeProp(prop, isFromHotbar):
	panel.hide()
	panel.process_mode = 4
	
	if isFromHotbar:
		get_parent().add_child(prop)
		placedPropsSave.append(prop)
		curProps.erase(prop)
	heldProp = prop

func holdProp():
	if heldProp != null:
		var propMass = heldProp.mass
		heldProp.mass = 0.0
		heldProp.gravity_scale = 0.0
		heldProp.linear_damp = 10
		heldProp.angular_damp = 10
		
		#if heldProp.rotation_degrees != targetRotation:
			#heldProp.constant_torque = (targetRotation - heldProp.rotation) * 10000
			#print(targetRotation)
		
		if Input.is_action_pressed("left"):
			heldProp.apply_torque_impulse(-250.0*heldProp.mass)
			#targetRotation -= 2*(PI/180)
			#if targetRotation <= -PI:
				#targetRotation = PI - 0.1
			
		elif Input.is_action_pressed("right"):
			heldProp.apply_torque_impulse(250.0*heldProp.mass)
			#targetRotation += 2*(PI/180)
			#if targetRotation >= PI:
				#targetRotation = -PI + 0.1
		
		var impulse = get_global_mouse_position() - heldProp.global_position
		impulse = impulse*100*heldProp.mass
		heldProp.apply_central_force(impulse)
		if Input.is_action_just_pressed("place"):
			bufferPlacement()
			heldProp.mass = propMass
			heldProp.gravity_scale = 1.0
			heldProp.linear_damp = 0
			heldProp.angular_damp = 0
			panel.show()
			panel.process_mode = 0
			heldProp = null
			updateHotbar()
		

func bufferPlacement():
	placeBuffer = true
	await get_tree().create_timer(0.25).timeout
	placeBuffer = false

func clearProps():
	var f = placedPropsSave.size()
	for i in f:
		placedPropsSave[i].queue_free()
	placedPropsSave.clear()
