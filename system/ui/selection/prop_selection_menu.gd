extends Node2D

signal propPlacementTime

@onready var propCard = preload("res://system/ui/prop_card/prop_card.tscn")

@onready var rock = preload("res://components/prop/rock.tscn")
@onready var crossbow = preload("res://components/prop/crossbow.tscn")
@onready var spring = preload("res://components/prop/spring.tscn")
@onready var platForm = preload("res://components/prop/platform.tscn")
@onready var fan = preload("res://components/prop/fan.tscn")
@onready var flameThrower = preload("res://components/prop/flame_thrower.tscn")
@onready var plank = preload("res://components/prop/plank.tscn")
@onready var sack = preload("res://assets/textures/props/large/sack.png")
@onready var slab = preload("res://components/prop/slab.tscn")


@onready var descBox = $descBox
@onready var grid = $GridContainer

var defenseNum = 5
var totalDefenses = 5
var curDefenses: Array

var defensesOptions: Array

var midGameOptions: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defensesOptions = [rock, crossbow, spring, platForm, fan, flameThrower]
	midGameOptions.append_array(defensesOptions)
	makeCards(defensesOptions)

func restart():
	defenseNum = 5
	totalDefenses = 5
	midGameOptions.append_array(defensesOptions)
	makeCards(defensesOptions)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	findSelectedProp()
	updateDescBox()

func midWaveSetup():
	defenseNum = 3
	totalDefenses = 3
	midGameOptions.clear()
	for i in 3:
		var random = randi_range(0, defensesOptions.size()-1)
		if !midGameOptions.has(defensesOptions[random]):
			midGameOptions.append(defensesOptions[random])
	
	makeCards(midGameOptions)

func updateDescBox():
	descBox.text = ""
	
	descBox.text += "You Have " + str(defenseNum) + " Defenses Remaining! \n\n\n"
	descBox.text +=  "Here Are Your Current Defenses: \n\n"
	
	for i in 5:
		if curDefenses.size() >= i+1:
			descBox.text += "- " + curDefenses[i].propName + "\n\n"
		else:
			descBox.text += "- \n\n"

func makeCards(propArray):
	clearGrid()
	curDefenses.clear()
	var f = propArray.size()
	for i in f:
		var newCard = propCard.instantiate()
		var propType = propArray[i].instantiate()
		grid.add_child(newCard)
		newCard.PropCard(propType.propName, propType.propSprite, propType.propDesc)

func findSelectedProp():
	if Input.is_action_just_pressed("place") && defenseNum > 0:
		var f = grid.get_children().size()
		for i in f:
			if grid.get_child(i).selected:
				curDefenses.append(midGameOptions[i].instantiate())
				defenseNum -= 1

func clearGrid():
	var f = grid.get_child_count()
	for i in f:
		grid.get_child(i).queue_free()

func _on_remove_button_pressed() -> void:
	
	if defenseNum < totalDefenses:
		defenseNum = totalDefenses
		curDefenses.clear()

func _on_continue_button_pressed() -> void:
	emit_signal("propPlacementTime")
