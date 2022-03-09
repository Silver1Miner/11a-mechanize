extends Node2D

export (PackedScene) var Enemy = preload("res://src/enemy/Enemy.tscn")

func spawn_monster(spawn_position, type) -> void:
	var monster
	match type:
		"monster":
			monster = Enemy.instance()
	randomize()
	var new_type = randi()%2
	monster.assign_color_type(new_type)
	monster.position = spawn_position
	monster.active = true
	add_child(monster)
	print("spawned monster of type ", new_type)
