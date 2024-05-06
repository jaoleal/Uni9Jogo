extends Node2D

export var CONTINENT_NAME = "Asia"

onready var TWEEN_CHILD = $Main_Continent/Main_sprite_tween
onready var COLLISION_AREA_NODE = $Main_Continent/mouse_area/CollisionPolygon2D
onready var TERRITORIES_LAYER = $Sub_territories
onready var selected = false
onready var is_hovering = false

#custom signals
signal continent_selected(continent)
signal continent_unselected(continent)

func _ready():
	for territory in TERRITORIES_LAYER.get_children():
		territory.connect("mouse_entered_territory", self, "_on_mouse_entered_territory")
		territory.connect("mouse_exited_territory", self, "_on_mouse_exited_territory")

func _input(event):
	if is_hovering and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("continent_selected", CONTINENT_NAME)
		selected = true
		
	elif !is_hovering and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("continent_unselected", CONTINENT_NAME)
		selected = false
		
func hover(is_hovering):
	if (is_hovering):
		TWEEN_CHILD.interpolate_property($Main_Continent/Main_sprite_tween/Main_Sprite, "modulate", Color("#ffffff"), Color("#dcdcdc"), TWEEN_CHILD.TRANS_LINEAR,TWEEN_CHILD.EASE_IN_OUT)
	else:
		TWEEN_CHILD.interpolate_property($Main_Continent/Main_sprite_tween/Main_Sprite, "modulate", Color("#dcdcdc"), Color("#ffffff"), TWEEN_CHILD.TRANS_LINEAR,TWEEN_CHILD.EASE_IN_OUT)
	TWEEN_CHILD.start()


func _on_mouse_entered_territory(Continent):
	
func _on_mouse_exited_territory(Continent):
	


func _on_mouse_area_mouse_entered():
	is_hovering = true
	hover(true)
func _on_mouse_area_mouse_exited():
	is_hovering = false
	hover(false)
