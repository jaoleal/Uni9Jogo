extends Node2D

#exporting territory info
export var TERRITORY_NAME = "Russia"

#Continent info
onready var All_Father_Node = get_node("../../../Asia")
onready var continent_name = All_Father_Node.CONTINENT_NAME

#child nodes
onready var CollisionPolygon_child = get_node("Sprite2D/territory_area2D/CollisionPolygon2D")
onready var Sprite2dChild = get_node("Sprite2D")
onready var LabelChild = get_node("Label")

#variables
onready var is_selected = false
onready var is_hovering = false

#custom signals
signal Territory_hovering(Territory_name , boolean)
signal Territory_selected(Territory_name)

func _ready():
	#set label text and position
	LabelChild.text = TERRITORY_NAME
	
	#connect signal
	All_Father_Node.connect("Territory_unselected", self, "_on_Territory_unselected")

func animate_Territory(delta):
	#some animation
	#stills deciding if animating with shaders or with sprites
	pass
func hovering(boolean):
	if boolean:
		Sprite2dChild.material.set_shader_param("color", Color("b4b4b4"))
		Sprite2dChild.material.set_shader_param("width", 4.25)
	else:
		Sprite2dChild.material.set_shader_param("width", 3.25)
		Sprite2dChild.material.set_shader_param("color", Color("ffffff"))
	
func select(boolean):
	if boolean:
		Sprite2dChild.material.set_shader_param("color", Color("414141"))
		Sprite2dChild.material.set_shader_param("width", 4.25)
	else:
		Sprite2dChild.material.set_shader_param("width", 3.25)
		Sprite2dChild.material.set_shader_param("color", Color("ffffff"))

#selected border color # 414141
#unselected border color #ffffff

#selected border width 2.25
#unselected border width 1.25

#hover color #b4b4b4
#off-hover color #ffffff

#hover border width 2.25
#off-hover border width 1.25

func _process(delta):
	select(is_selected)
	if !is_selected:
		hovering(is_hovering)

func _on_Territory_unselected(Territory):
	if Territory == TERRITORY_NAME:
		is_selected = false

func _on_territory_area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("Territory_selected", TERRITORY_NAME)
		is_selected = true

func _on_territory_area2D_mouse_entered():
	is_hovering = true
	emit_signal("Territory_hovering",TERRITORY_NAME, true)


func _on_territory_area2D_mouse_exited():
	is_hovering = false
	emit_signal("Territory_hovering",TERRITORY_NAME, false)
