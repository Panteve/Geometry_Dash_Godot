extends Area2D
var nave_scene = preload("res://scenes/Ship.tscn") #cargar escena

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
		
func _on_body_entered(body: Node2D) -> void:
	if body.get_parent() and body.get_parent().name.begins_with("Player"): # verif. si fue el cubo
		var player_body = body # Este es el CharacterBody2D que realmente se movió por el nivel
		var player_node = body.get_parent() # Este es el Node2D raíz que se quedó en el inicio
		
		var nueva_nave = nave_scene.instantiate() #copia de la nave
		nueva_nave.position = player_node.position # conservar posición del nodo raíz (suele ser estática)
		nueva_nave.scale = player_node.scale # conservar el mismo tamaño del cubo (0.3)
		
		# ¡AQUÍ ESTÁ LA CLAVE! Copiamos la posición de lo que realmente se movió (el CharacterBody2D)
		var ship_body = nueva_nave.get_node("CharacterBody2D")
		ship_body.position = player_body.position
		
		# Pasar la posición fija de la cámara para que no haya un salto al cambiar de personaje
		if "fixed_camera_y" in player_body:
			ship_body.fixed_camera_y = player_body.fixed_camera_y
			
		player_node.get_parent().call_deferred("add_child", nueva_nave) # poner nave en el nivel de forma segura
		player_node.queue_free()#quitar el cubo completamente
