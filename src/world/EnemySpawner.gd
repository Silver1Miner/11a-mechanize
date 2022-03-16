extends Node2D

export (PackedScene) var Enemy = preload("res://src/enemy/Enemy.tscn")
export (PackedScene) var Fiend = preload("res://src/enemy/Fiend.tscn")
export (PackedScene) var Winged = preload("res://src/enemy/FiendWinged.tscn")
export (PackedScene) var Shaman = preload("res://src/enemy/FiendHeaddress.tscn")
export (PackedScene) var Armor = preload("res://src/enemy/FiendArmor.tscn")

func spawn_monster(spawn_position, type) -> void:
	var monster
	match type:
		0:
			monster = Enemy.instance()
		1:
			monster = Fiend.instance()
		2:
			monster = Winged.instance()
		3:
			monster = Shaman.instance()
		4:
			monster = Armor.instance()
	randomize()
	var new_type = randi()%2
	monster.assign_color_type(new_type)
	monster.position = spawn_position
	monster.active = true
	add_child(monster)
	#print("spawned monster of type ", new_type)
