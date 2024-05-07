@tool
class_name Ngon
extends Node2D

@export_range(3, 99) var n := 3
@export var radius := 100.0
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

func _ready():
	reset()

func _process(delta_t):
	if polygon.polygon.size() != n or polygon.polygon[0].x != radius:
		reset()

func reset():
	# TODO: try the other one.
	actually_reset()
	#bad_reset()

func bad_reset():
	if n < 3:
		n = 3
	print('resetting ngon to radius ', radius, ' with ', n, ' sides')
	polygon.polygon.clear()
	print("polygon size after clear ", polygon.polygon.size())  # this is still 1 (or whatever $Polygon2D started with)
	for i in n:
		var angle = i * TAU / n
		print("  adding ", i, ' / ', n, ' angle = ', round(rad_to_deg(angle)))
		polygon.polygon.append(radius * Vector2(cos(angle), sin(angle)))
	print("new polygon size ", polygon.polygon.size()) # this is still 1 (or whatever $Polygon2D started with)

func actually_reset():
	if n < 3:
		n = 3
	var array: Array[Vector2] = []
	for i in n:
		var angle = i * TAU / n
		array.append(radius * Vector2(cos(angle), sin(angle)))
	polygon.polygon = PackedVector2Array(array)
