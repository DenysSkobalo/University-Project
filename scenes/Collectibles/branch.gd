extends Area2D

var branch = preload("res://scenes/Collectibles/branch.tscn")

func _on_body_entered(body):
	if body is Player:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
		body.pick_up()
