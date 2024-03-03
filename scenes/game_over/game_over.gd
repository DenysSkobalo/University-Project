extends Node2D
	
func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://scenes/World/world.tscn")

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu/menu.tscn")
