extends Node2D

onready var SpawnPoints := $Navigation2D/SpawnPoints
onready var EnemySpawn := $Navigation2D/EnemySpawner
onready var Player := $Navigation2D/Player
onready var GUIDisplay := $GUI/StatusDisplay

func _ready() -> void:
	PlayerData.delta_time = 0.0

var timer_accumulated = 0
var spawn_accumulated = 0
var spawn_timer = 300
var spawn_limit = 40
func _process(delta: float) -> void:
	PlayerData.delta_time += delta
	spawn_accumulated += 1
	timer_accumulated += 1
	if timer_accumulated >= 60:
		$GUI/StatusDisplay.update_clock(PlayerData.delta_time)
		timer_accumulated = 0
	if spawn_accumulated >= spawn_timer:
		spawner()

var fiend_cut = 7
var headdress_cut = 8
var armor_cut = 9
var fast_cut = 10
func spawner() -> void:
	if SpawnPoints.get_children().size() > 0 and EnemySpawn.get_children().size() <= spawn_limit:
		randomize()
		var spawn_index = round(rand_range(0, SpawnPoints.get_children().size() - 1))
		var spawn_position = SpawnPoints.get_children()[spawn_index]
		var spawn_choice = rand_range(0, 10)
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
		if spawn_timer >= 40:
			spawn_timer -= 20
			if spawn_timer >= 200:
				fiend_cut = 3
				headdress_cut = 7
				armor_cut = 8
				fast_cut = 9
			elif spawn_timer >= 100:
				fiend_cut = 3
				headdress_cut = 5
				armor_cut = 7
				fast_cut = 7
			else:
				fiend_cut = 0
				headdress_cut = 3
				armor_cut = 5
				fast_cut = 7


func _on_Player_player_died() -> void:
	$GUI/LoadoutScreen.activate_death()
