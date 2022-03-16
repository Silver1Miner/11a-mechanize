extends Node2D

onready var SpawnPoints := $Navigation2D/SpawnPoints
onready var EnemySpawn := $Navigation2D/EnemySpawner

func _ready() -> void:
	PlayerData.time = 0.0

var spawn_accumulated = 0
var spawn_timer = 100
var spawn_limit = 40
func _process(delta: float) -> void:
	PlayerData.time += delta
	spawn_accumulated += 1
	if spawn_accumulated >= spawn_timer:
		spawner()

func spawner() -> void:
	if SpawnPoints.get_children().size() > 0 and EnemySpawn.get_children().size() <= spawn_limit:
		randomize()
		var spawn_index = round(rand_range(0, SpawnPoints.get_children().size() - 1))
		var spawn_position = SpawnPoints.get_children()[spawn_index]
		var spawn_species = int(rand_range(0,4))
		EnemySpawn.spawn_monster(spawn_position.position, spawn_species)
		spawn_accumulated = 0


func _on_Player_player_died() -> void:
	$GUI/LoadoutScreen.activate_death()
