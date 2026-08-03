extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	velocity.x = SPEED

	move_and_slide()
	if is_on_wall():
		die()

func _on_hitbox_roja_area_entered(_area: Area2D) -> void:
	print("hola0")
	die()

func die() -> void:
	get_tree().reload_current_scene()
