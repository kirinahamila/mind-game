extends Node2D

@onready var label = $Label

var text
var tagType


func Tag(textp, tagTypep):
	await get_tree().create_timer(1.0/60.0).timeout
	
	text = textp
	tagType = tagTypep
	
	match tagType:
		"damage":
			label.set("theme_override_colors/font_color", Color(255, 0, 0))
			label.text = "-" + str(text)
		"effect":
			label.set("theme_override_colors/font_color", Color(255, 255, 255))
			label.text = str(text)

func _ready():
	for i in 60:
		await get_tree().create_timer(1.0/60.0).timeout
		global_position.y -= 3
		label.modulate -= Color(0,0,0,0.01)
	
	queue_free()
