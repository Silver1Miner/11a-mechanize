extends Control

func update() -> void:
	$UpgradeList/IronRevolver/Label.text = "Level " + str(PlayerData.player_upgrades[0])
	$UpgradeList/SilverSMG/Label.text = "Level " + str(PlayerData.player_upgrades[1])
	$UpgradeList/IronSlug/Label.text = "Level " + str(PlayerData.player_upgrades[2])
	$UpgradeList/SilverChain/Label.text = "Level " + str(PlayerData.player_upgrades[3])
	$UpgradeList/IronRocket/Label.text = "Level " + str(PlayerData.player_upgrades[4])
	$UpgradeList/SilverFlamer/Label.text = "Level " + str(PlayerData.player_upgrades[5])
	$Close.visible = true
	$Quit.visible = false
	$Clock.update_clock(PlayerData.delta_time)

func _on_Close_pressed() -> void:
	get_tree().paused = false
	visible = false

func activate_death() -> void:
	update()
	get_tree().paused = true
	$Clock.update_clock(PlayerData.delta_time)
	visible = true
	$Close.visible = false
	$Quit.visible = true

func _on_Quit_pressed() -> void:
	get_tree().paused = false
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to load world")
