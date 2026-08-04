extends Area2D
var nave_scene = preload("res://scenes/Ship.tscn") #cargar escena
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": # verif. si fue un cubo
		var nueva_nave = nave_scene.instantiate() #copia de la nave
		nueva_nave.global_position = body.global_position #poner nave en la misma posición del cubo
		body.get_parent().add_child(nueva_nave) # poner nave en el nivekl
		body.queue_free()#quitar el cubo
