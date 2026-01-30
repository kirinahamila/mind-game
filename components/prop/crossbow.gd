extends Prop

@onready var arrow = preload("res://components/prop/arrow.tscn")
@onready var arrowSpawn = $arrowSpawn

var shooting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !shooting:
		shooting = true
		var newArrow = arrow.instantiate()
		newArrow.setDirection(arrowSpawn.global_position - global_position)
		newArrow.global_position = arrowSpawn.global_position
		get_parent().add_child(newArrow)
		await get_tree().create_timer(3.0).timeout
		shooting = false
