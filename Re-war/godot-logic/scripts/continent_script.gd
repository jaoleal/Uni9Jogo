extends Node2D

#continent name
export var CONTINENT_NAME = "Asia"

#nodes connections
onready var TERRITORIES_LAYER = $Territories

#variables
onready var hovering = "None"
onready var selected = false
onready var selected_territory = "None"

#custom signals
signal Territory_selected(Territory_name)
signal Territory_unselected(Territory_name)

func _ready():
	for territory in TERRITORIES_LAYER.get_children():
		territory.connect("Territory_selected", self, "_on_Territory_selected")
		territory.connect("Territory_hovering", self, "_on_Territory_hovering")
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("Territory_selected", selected_territory)
		selected = true
	if selected_territory != hovering and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("Territory_unselected", selected_territory)
		selected_territory = "None"
		selected = false


func _on_Territory_hovering(Territory_name, boolean):
	if boolean:
		hovering = Territory_name
	else:
		hovering = "None"

func _on_Territory_selected(territory):
	selected_territory = territory
func _on_Territory_unselected(territory):
	selected_territory = territory
