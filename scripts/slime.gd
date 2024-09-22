extends Node2D

const SPEED = 60
var direction = 1

@onready var ray_cast_2dl: RayCast2D = $RayCast2DL
@onready var ray_cast_2dr: RayCast2D = $RayCast2DR
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2dr.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		
	if ray_cast_2dl.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	position.x += direction * SPEED * delta
