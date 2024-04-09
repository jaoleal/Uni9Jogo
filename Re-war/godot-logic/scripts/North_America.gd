extends Node2D

onready var TWEEN_CHILD = $Tween

var event = 0

func _ready():
	pass

func _input(event):
	event = "something"
	pass
func alt_select():
	pass
func hover(is_hovering):
	if (is_hovering):
		TWEEN_CHILD.interpolate_property($Tween/Sprite, "modulate", Color("#ffffff"), Color("#dcdcdc"), TWEEN_CHILD.TRANS_LINEAR,TWEEN_CHILD.EASE_IN_OUT)
	else:
		TWEEN_CHILD.interpolate_property($Tween/Sprite, "modulate", Color("#dcdcdc"), Color("#ffffff"), TWEEN_CHILD.TRANS_LINEAR,TWEEN_CHILD.EASE_IN_OUT)
	TWEEN_CHILD.start()

func _on_mouse_area_mouse_entered():
	hover(true)

func _on_mouse_area_mouse_exited():
	hover(false)
