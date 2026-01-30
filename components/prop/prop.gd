class_name Prop
extends RigidBody2D


@export var propSprite: Texture2D
@export var propName: String
@export_multiline() var propDesc: String



# The number and accuracy of the generated polygons; lower is higher.
#@export_range(0,10) var collision_detail: float = 2


#func generate_collision_mesh() -> void:
	#var texture := propSprite.texture
	#var bitmap := BitMap.new()
	#bitmap.create_from_image_alpha(texture.get_image())
	#
	#var polygons = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()), collision_detail)
	#
	#for poly in polygons:
		#var collision_polygon = CollisionPolygon2D.new()
		#collision_polygon.polygon = poly
		#add_child(collision_polygon)
		#
		#if propSprite.centered:
			#collision_polygon.position -= (bitmap.get_size()/2 as Vector2)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node, source: RigidBody2D) -> void:
	print("COLLIDE")
	if not (body is Enemy):
		return
	
	
	var angle_to_body := self.get_angle_to(body.position)
	var angle_of_movement := self.linear_velocity.angle()
	
	var force = self.linear_velocity.length() * self.mass
	
	var diff = remap(abs(angle_of_movement - angle_to_body), 0, 180, 0, 1) 
	
	var damage = force * diff
	
	body.takeDamage(damage)
