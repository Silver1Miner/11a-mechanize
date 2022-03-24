extends Control

var last_level = 1

func _on_Player_hp_changed(new_hp, max_hp) -> void:
	$HPDisplay/HPBar.max_value = max_hp
	$HPDisplay/HPBar.value = new_hp

func _on_Player_xp_changed(new_xp, max_xp, level) -> void:
	$ExpBar.max_value = max_xp
	$ExpBar.value = new_xp
	$Level.text = "Level " + str(level)
	if level != last_level:
		$UpgradeScreen.activate()
		$"../Joystick".reset()
		last_level = level

func _on_Player_coins_changed() -> void:
	$Coins.update_coins(PlayerData.current_coins)

func _on_PauseStatus_pressed() -> void:
	$"../LoadoutScreen".update()
	$"../LoadoutScreen".visible = true
	get_tree().paused = true

func update_clock(delta_time) -> void:
	$Clock.update_clock(delta_time)
