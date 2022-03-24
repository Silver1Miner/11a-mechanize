extends Node

var music_db := 0.4
var sound_db := 0.2
var delta_time := 0.0

var total_coins := 0
var current_coins := 0
var mission_coins := 0
var total_exp := 0
var highest_level := 1
var highest_time := 0.0

var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	pass # Replace with function body.

var main_menu = preload("res://src/menu/MainMenu.tscn")
var hub = preload("res://src/menu/Hub.tscn")
var world = preload("res://src/world/World.tscn")

var player_upgrades := { #upgrade_id: level,
	-1: 0, # coin
	0: 1, # Forward Gun 1, Iron Revolver
	1: 1, # Forward Gun 2, Silver SMG
	2: 0, # Turret Gun 1, Iron Slug
	3: 0, # Turret Gun 2, Silver Chain Gun
	4: 0, # Turret Gun 3, Iron Rocket
	5: 0, # Turret Gun 4, Silver Flame
}

var bought_upgrades := { #upgrade_id: level,
	0: 0, # Max Health Bonus
	1: 0, # Regeneration Bonus
	2: 0, # Damage Bonus
	3: 0, # Critical Bonus
}

signal player_upgraded()
func upgrade(upgrade_id: int) -> void:
	if upgrade_id < 0: # coin
		PlayerData.total_coins += 1
		PlayerData.current_coins += 1
		PlayerData.mission_coins += 1
	elif player_upgrades[upgrade_id] < Database.upgrades[upgrade_id]["max_level"]:
		player_upgrades[upgrade_id] += 1
	emit_signal("player_upgraded")

func fresh_restart() -> void:
	delta_time = 0.0
	mission_coins = 0
	player_upgrades = { #upgrade_id: level,
		-1: 0, # coin
		0: 1, # Forward Gun 1, Iron Revolver
		1: 1, # Forward Gun 2, Silver SMG
		2: 0, # Turret Gun 1, Iron Slug
		3: 0, # Turret Gun 2, Silver Chain Gun
		4: 0, # Turret Gun 3, Iron Rocket
		5: 0, # Turret Gun 4, Silver Flame
	}

func load_player_data() -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://mechanize.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://mechanize.save", File.READ)
	total_coins = parse_json(save_game.get_line())
	current_coins = parse_json(save_game.get_line())
	music_db = parse_json(save_game.get_line())
	sound_db = parse_json(save_game.get_line())
	save_game.close()

func save_player_data() -> void:
	var save_game = File.new()
	save_game.open("user://mechanize.save", File.WRITE)
	save_game.store_line(to_json(total_coins))
	save_game.store_line(to_json(current_coins))
	save_game.store_line(to_json(music_db))
	save_game.store_line(to_json(sound_db))
	save_game.close()

func clear_player_data() -> void:
	total_coins = 0
	current_coins = 0
	mission_coins = 0
	var dir = Directory.new()
	dir.remove("user://mechanize.save")
