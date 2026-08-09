extends Control

func _ready():
	visible = false

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		visible = not visible
		get_tree().paused = visible

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MenuPrincipal.tscn")

func _on_play_pressed():
	visible = false
	get_tree().paused = false

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
# corregir posición de botones
