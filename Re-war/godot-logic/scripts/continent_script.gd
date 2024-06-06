extends Node2D

#continent name
export var CONTINENT_NAME = "Asia"


#nodes connections
onready var BdF = get_node(".")
onready var TERRITORIES_LAYER = $Territories
onready var LABELS_LAYER = get_node("Labels")

#variables
enum PHASE {DEPLOY, ATTACK, REORG}
onready var running_phase = PHASE.ATTACK
onready var to_update:bool = false
onready var ui_builded = false
onready var hovering = "None"
onready var selected = false
onready var selected_territory = "None"
onready var attacking_territory = "None"

#custom signals
signal Territory_selected(Territory_name)
signal Territory_unselected(Territory_name)

func _on_update_ui():
	to_update = true

func get_territories():
	return TERRITORIES_LAYER.get_children()

func _ready():
	build_ui()
	
	#This for loop execute every connection needed between the Father node
	#and the territories
	for territory in TERRITORIES_LAYER.get_children():
		#This tells its children hisposition and it name
		territory.set_continent(self.get_path())
		territory.connect("update_ui", self, "_on_update_ui")
		territory.connect("Territory_selected", self, "_on_Territory_selected")
		territory.connect("Territory_hovering", self, "_on_Territory_hovering")

func rebuild_ui():
	for pos2d_node in LABELS_LAYER.get_children():
		var label_node:RichTextLabel = pos2d_node.get_child(0)
		set_label_defaults(label_node, label_node.name)

func build_ui():
	#wrapper to build a to set the position for some uis that need
	#to be set programatically.
	if ui_builded:
		#rebuild ui wraps reseting to default some ui elements that aren't
		rebuild_ui()
	else:
		#build for labels aka the names of the territories
		for territory in TERRITORIES_LAYER.get_children():
			var territory_name: String = territory.TERRITORY_NAME
			var label_node:RichTextLabel = RichTextLabel.new()
			var troops_counter_node:Label = Label.new()
			var Label_Position_Node = get_node("Labels/%sLabel" % territory_name)
			set_label_defaults(label_node, territory_name)
			set_counter_defaults(troops_counter_node, territory_name)
			Label_Position_Node.add_child(label_node)
			Label_Position_Node.add_child(troops_counter_node)
	ui_builded = true

func _on_new_phase(P):
	running_phase = P

func _process(delta):
	if to_update:
		for T in get_territories():
			var PosN = get_node("Labels/%sLabel" % T.TERRITORY_NAME)
			var counter = PosN.get_child(1)
			counter.text = String(get_territory_troops(T.TERRITORY_NAME))
		to_update = false

func update_title(Territory: String):
	if Territory == CONTINENT_NAME:
		return 
	if Territory != "None":
		var label_node:RichTextLabel = get_node("Labels/%sLabel/%s" % [Territory, Territory])
		label_node.bbcode_text = "[center][jump] %s [/jump][/center]" % Territory		
	else:
		build_ui()

func get_territory_troops(Territory_Name: String):
	var N =  get_node("Territories/Territory_%s" % Territory_Name)
	return N.troops 

func set_counter_defaults(L:Label , Territory_Name: String):
	L.name = "Counter%s" % Territory_Name
	var default_theme = load("res://default_theme.tres")
	L.theme = default_theme
	L.text = String(get_territory_troops(Territory_Name))

func set_label_defaults(L: RichTextLabel, Territory_Name: String):
	#set all the initial defaults for labels
	#like font size, color and position.
	L.name = "%s" % Territory_Name
	var default_theme = load("res://default_theme.tres")
	L.theme = default_theme
	L.bbcode_enabled = true
	L.bbcode_text = "[center] %s [/center]" % Territory_Name
	L.scroll_active = false
	var jump_effect = load("res://addons/teeb.text_effects/resources/Jump.tres")
	L.custom_effects = [jump_effect]
	L.anchor_right = 1
	L.anchor_bottom = 1
	L.mouse_filter = 2
	var rect_size = Vector2(100,50)
	L.rect_size = rect_size
	var position =  L.rect_position if ui_builded else L.rect_position - rect_size/2
	L.set_position(position)

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
	#triggers the rebuild of the labels
	update_title(hovering)

func _on_Territory_selected(territory):
	selected_territory = territory
func _on_Territory_unselected(territory):
	if territory !=  attacking_territory:
		selected_territory = territory
