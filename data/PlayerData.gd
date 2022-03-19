extends Node

var music_db := 0.5
var sound_db := 0.2
var delta_time := 0.0

var total_coins := 0
var total_exp := 0
var highest_level := 1
var highest_time := 0.0

var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	pass # Replace with function body.

var main_menu = preload("res://src/menu/MainMenu.tscn")
var world = preload("res://src/world/World.tscn")

var player_upgrades := { #upgrade_id: level,
	-1: 0, # coin
	0: 1, # Forward Gun 1, Iron Revolver
	1: 1, # Forward Gun 2, Silver SMG
	2: 0, # Turret Gun 1, Iron Slug
	3: 0, # Turret Gun 2, Silver Chain Gun
	4: 0, # Turret Gun 3, Iron Rocket
	5: 0, # Turret Gun 4, Silver Flame
	6: 0, # Max Health
}

signal player_upgraded()
func upgrade(upgrade_id: int) -> void:
	if upgrade_id < 0: # coin
		return
	if player_upgrades[upgrade_id] < Database.upgrades[upgrade_id]["max_level"]:
		player_upgrades[upgrade_id] += 1
	emit_signal("player_upgraded")

func fresh_restart() -> void:
	delta_time = 0.0
	player_upgrades = { #upgrade_id: level,
		-1: 0, # coin
		0: 1, # Forward Gun 1, Iron Revolver
		1: 1, # Forward Gun 2, Silver SMG
		2: 0, # Turret Gun 1, Iron Slug
		3: 0, # Turret Gun 2, Silver Chain Gun
		4: 0, # Turret Gun 3, Iron Rocket
		5: 0, # Turret Gun 4, Silver Flame
		6: 0, # Max Health
	}
