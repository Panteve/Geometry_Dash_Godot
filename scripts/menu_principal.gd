extends Control

@onready var boton_jugar = $ContenedorAnimacion/BotonJugar
@onready var contenedor_animacion = $ContenedorAnimacion

func _ready():
	boton_jugar.pressed.connect(_al_presionar_jugar)


func _al_presionar_jugar():
	get_tree().change_scene_to_file("res://scenes/SeleccionNiveles.tscn")
# agregar selección de personajes
