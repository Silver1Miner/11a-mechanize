extends Control

var last_level = 1

func _on_Player_hp_changed(new_hp, max_hp) -> void:
	$HPDisplay/HPBar.max_value = max_hp
	$HPDisplay/HPBar.value = new_hp

func _on_Player_xp_changed(new_xp, max_xp, level) -> void:
	print(new_xp, max_xp, level)
	$ExpBar.max_value = max_xp
	$ExpBar.value = new_xp
	$Level.text = "Level " + str(level)
	if level != last_level:
		$UpgradeScreen.activate()
		$"../Joystick".reset()
		last_level = level

func _on_Player_coins_changed(coins) -> void:
	$Coins.text = coins
