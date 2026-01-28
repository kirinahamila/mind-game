class_name Prop
extends RigidBody2D

@export var sprite: Sprite2D

# The number and accuracy of the generated polygons; lower is higher.
@export_range(0,10) var collision_detail: float = 2

func generate_collision_mesh() -> void:
	var texture := sprite.texture
	var bitmap := BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())
	
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()), collision_detail)
	
	for poly in polygons:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		add_child(collision_polygon)
		
		if sprite.centered:
			collision_polygon.position -= (bitmap.get_size()/2 as Vector2)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_collision_mesh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
