extends Node2D

signal propPlacementTime

@onready var propCard = preload("res://components/classes/prop_card.tscn")

@onready var rock = preload("res://components/prop/rockProp.tscn")

@onready var descBox = $descBox
@onready var grid = $GridContainer

var defenseNum = 5
var curDefenses: Array

var defensesOptions: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defensesOptions = [rock]
	makeCards(defensesOptions)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	findSelectedProp()
	updateDescBox()

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
	var f = propArray.size()
	for i in f:
		var newCard = propCard.instantiate()
		var propType = defensesOptions[i].instantiate()
		grid.add_child(newCard)
		newCard.PropCard(propType.propName, propType.propSprite)

func findSelectedProp():
	if Input.is_action_just_pressed("place") && defenseNum > 0:
		var f = defensesOptions.size()
		for i in f:
			if grid.get_child(i).selected:
				curDefenses.append(defensesOptions[i].instantiate())
				defenseNum -= 1

func _on_remove_button_pressed() -> void:
	if defenseNum < 5:
		defenseNum = 5
		curDefenses.clear()

func _on_continue_button_pressed() -> void:
	emit_signal("propPlacementTime")
