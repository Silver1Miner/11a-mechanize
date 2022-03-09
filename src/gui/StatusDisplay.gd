extends Control

var Database = preload("res://data/Database.tres")

func _ready() -> void:
	pass

func _on_Player_pickup(pickup_type) -> void:
	match pickup_type:
		Database.PICKUPS.GEM:
			update_exp(10)
		Database.PICKUPS.COIN:
			print("coins: ", PlayerData.session_coins)

func _on_Player_hp_changed(new_hp, max_hp) -> void:
	print(new_hp)
	$HPDisplay/HPBar.max_value = max_hp
	$HPDisplay/HPBar.value = new_hp

func update_exp(exp_amount) -> void:
	$ExpBar.max_value = Database.exp_scale[PlayerData.level]
	$ExpBar.value = PlayerData.session_exp
	print("experience gain: ", exp_amount)
