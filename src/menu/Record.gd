extends ColorRect

func _update_records() -> void:
	$Grid/Clock.update_clock(PlayerData.highest_time)
	$Grid/Level.text = str(PlayerData.highest_level)
	$Grid/Gems.text = str(PlayerData.total_exp)
	$Grid/Coins.text = str(PlayerData.total_coins)

func _on_Back_pressed() -> void:
	visible = false
