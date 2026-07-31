extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	velocity.x = SPEED

	move_and_slide()


func _on_hitbox_roja_area_entered(_area: Area2D) -> void:
	die()


func _on_hitbox_roja_body_entered(_body: Node2D) -> void:
	die()


func die() -> void:
	get_tree().reload_current_scene()
