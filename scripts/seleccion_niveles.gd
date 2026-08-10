extends Control
#cambiar pngs y agregar animación de scroll y otro nivel
@onready var hitbox_nivel = $HitboxNivel
@onready var hitbox_volver = $HitboxVolver

func _ready():
	hitbox_nivel.pressed.connect(_al_presionar_nivel)
	hitbox_volver.pressed.connect(_al_presionar_volver)

func _al_presionar_nivel():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _al_presionar_volver():
	get_tree().change_scene_to_file("res://scenes/MenuPrincipal.tscn")
