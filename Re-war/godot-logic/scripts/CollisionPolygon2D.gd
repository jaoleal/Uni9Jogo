extends Node2D

onready var parent_polygon_transform = get_node("../../Polygon2d")

func _ready():
	
	print(parent_polygon_transform)
	#set_position()
