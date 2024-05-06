extends Node2D

#exporting territory info
export var TERRITORY_NAME = "Russia"

#Continent info
onready var All_Father_Node = get_node("../../../Father")
onready var continent_name = All_Father_Node.CONTINENT_NAME

#child nodes
onready var CollisionPolygon_child = get_node("Polygon2d/territory_area2D/CollisionPolygon2D")
onready var Polygon2d_child = get_node("Polygon2d")

#variables
onready var is_continent_selected = false
onready var is_hovering = false

signal mouse_entered_territory(Continent)
signal mouse_exited_territory(Continent)

func _ready():
	#I dont trust my mouse :D
	#This just ensures that the collision area position is the same as his parent Polygon2D
	CollisionPolygon_child.transform.x = Polygon2d_child.transform.x
	CollisionPolygon_child.transform.y = Polygon2d_child.transform.y
	
	All_Father_Node.connect("continent_selected", self, "_on_continent_selected")
	All_Father_Node.connect("continent_unselected", self, "_on_continent_unselected")

func _on_continent_unselected(continent):
	toggle_area2d_on()

func _on_continent_selected(continent):
	toggle_area2d_on()
	#toggle area2d on

func toggle_area2d_on():
	is_continent_selected = !is_continent_selected
	CollisionPolygon_child.disabled = is_continent_selected
	
func hovering(boolean, new_color):	
	Polygon2d_child.color = new_color

#hover color #d18d83
#off-hover color #ff715b

func _on_territory_area2D_mouse_entered():
	emit_signal("mouse_entered_territory", TERRITORY_NAME)
	is_hovering = true
	hovering(false, Color("#ff715b"))


func _on_territory_area2D_mouse_exited():
	emit_signal("mouse_exited_territory", TERRITORY_NAME)
	is_hovering = false
	hovering(true, Color("#d18d83"))
