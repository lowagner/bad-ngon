@tool
class_name Wobble
extends Node2D

@export var speed := 0.5
@export var amount := 30.0
@export var color: Color:
	get:
		if not is_node_ready():
			await ready
		return polygon.color
	set(new_color):
		if not is_node_ready():
			await ready
		polygon.color = new_color

@onready var polygon: Polygon2D = $Polygon2D

var angle := 0.0

func _ready():
	angle = randf() * TAU

func _process(delta_t: float):
	angle = fmod(angle + delta_t * speed, TAU)
	var unit = Vector2(cos(angle), sin(angle))
	# this behavior works and makes it seem like `Polygon2D.polygon` is a reference.
	polygon.polygon[0] = 50.0 * Vector2(-1, +1) + amount * Vector2(+unit.x, +unit.y)
	polygon.polygon[1] = 50.0 * Vector2(+1, +1) + amount * Vector2(-unit.y, +unit.x)
	polygon.polygon[2] = 50.0 * Vector2(+1, -1) + amount * Vector2(-unit.x, -unit.y)
	polygon.polygon[3] = 50.0 * Vector2(-1, -1) + amount * Vector2(+unit.y, -unit.x)
