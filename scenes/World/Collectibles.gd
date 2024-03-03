extends Node2D

var branch = preload("res://scenes/Collectibles/branch.tscn")

func _on_timer_timeout():
	print("Створення нової гілки")
	var branch_instance = branch.instantiate()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rand_x = rng.randi_range(0, 1000)
	var rand_y = rng.randi_range(0, 500)
	branch_instance.position = Vector2(rand_x, rand_y)
	add_child(branch_instance)
