extends Area2D

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
		
func _on_body_entered(body: Node2D) -> void:
	if body.get_parent() and body.get_parent().name.begins_with("Player"):
		body.final()
		
