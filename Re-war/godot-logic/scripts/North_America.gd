extends Node2D

onready var TWEEN_CHILD = $Main_sprite_tween
onready var selected = false
onready var is_hovering = false

signal continent_clicked(continent)

func _input(event):
	if is_hovering and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("continent_clicked", "continent_Asia")
func hover(is_hovering):
	if (is_hovering):
		TWEEN_CHILD.interpolate_property($Main_sprite_tween/Main_Sprite, "modulate", Color("#ffffff"), Color("#dcdcdc"), TWEEN_CHILD.TRANS_LINEAR,TWEEN_CHILD.EASE_IN_OUT)
	else:
		TWEEN_CHILD.interpolate_property($Main_sprite_tween/Main_Sprite, "modulate", Color("#dcdcdc"), Color("#ffffff"), TWEEN_CHILD.TRANS_LINEAR,TWEEN_CHILD.EASE_IN_OUT)
	TWEEN_CHILD.start()

func _on_mouse_area_mouse_entered():
	is_hovering = true
	hover(true)

func _on_mouse_area_mouse_exited():
	is_hovering = false
	hover(false)
