extends Node2D
onready var Continents = get_children()
func _ready():
	for Continent in Continents:
		Continent.connect("continent_clicked", self, "_on_continent_clicked")

func _on_continent_clicked(continent):
	print(continent)
