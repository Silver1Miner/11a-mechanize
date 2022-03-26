extends Node2D

onready var SpawnPoints := $Navigation2D/SpawnPoints
onready var EnemySpawn := $Navigation2D/EnemySpawner
onready var Player := $Navigation2D/Player
onready var GUIDisplay := $GUI/StatusDisplay
var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	PlayerData.delta_time = 0.0

var timer_accumulated = 0
var spawn_accumulated = 0
var spawn_timer = 300
func _process(delta: float) -> void:
	PlayerData.delta_time += delta
	spawn_accumulated += 1
	timer_accumulated += 1
	if timer_accumulated >= 60:
		$GUI/StatusDisplay.update_clock(PlayerData.delta_time)
		timer_accumulated = 0
	if spawn_accumulated >= Database.spawn_schedule["spawn_pace"][spawn_level]:
		spawner()

var spawn_level = 0
func spawner() -> void:
	if SpawnPoints.get_children().size() > 0 and \
	EnemySpawn.get_children().size() <= Database.spawn_schedule["spawn_limit"][spawn_level]:
		randomize()
		var spawn_index = round(rand_range(0, Database.spawn_schedule["spawn_points"][spawn_level] - 1))
		var spawn_position = SpawnPoints.get_children()[spawn_index]
		var spawn_choice = rand_range(0, 10)
		var fiend_cut = Database.spawn_schedule["spawn_distribution"][spawn_level][0]
		var headdress_cut = Database.spawn_schedule["spawn_distribution"][spawn_level][1]
		var armor_cut = Database.spawn_schedule["spawn_distribution"][spawn_level][2]
		var fast_cut = Database.spawn_schedule["spawn_distribution"][spawn_level][3]
		if spawn_choice >= fiend_cut and spawn_choice < headdress_cut:
			EnemySpawn.spawn_monster(spawn_position.position, 1)
		elif spawn_choice >= headdress_cut and spawn_choice < armor_cut:
			EnemySpawn.spawn_monster(spawn_position.position, 2)
		elif spawn_choice >= armor_cut and spawn_choice < fast_cut:
			EnemySpawn.spawn_monster(spawn_position.position, 3)
		elif spawn_choice > fast_cut:
			EnemySpawn.spawn_monster(spawn_position.position, 4)
		else:
			EnemySpawn.spawn_monster(spawn_position.position, 0)
		spawn_accumulated = 0
		if spawn_timer >= 300 and spawn_level < Database.spawn_schedule.max_level - 1:
			spawn_level += 1
			print("spawn level is now ", str(spawn_level))


func _on_Player_player_died() -> void:
	$GUI/LoadoutScreen.activate_death()
