extends Control

onready var _clock = $ClockRecord/Clock

func update() -> void:
	$Coins.update_coins(PlayerData.mission_coins)
	$UpgradeList/IronRevolver/Label.text = "Level " + str(PlayerData.player_upgrades[0])
	$UpgradeList/SilverSMG/Label.text = "Level " + str(PlayerData.player_upgrades[1])
	$UpgradeList/IronSlug/Label.text = "Level " + str(PlayerData.player_upgrades[2])
	$UpgradeList/SilverChain/Label.text = "Level " + str(PlayerData.player_upgrades[3])
	$UpgradeList/IronRocket/Label.text = "Level " + str(PlayerData.player_upgrades[4])
	$UpgradeList/SilverFlamer/Label.text = "Level " + str(PlayerData.player_upgrades[5])
	$UpgradeList/IronRevolver/Label.visible = PlayerData.player_upgrades[0] > 0
	$UpgradeList/SilverSMG/Label.visible = PlayerData.player_upgrades[1] > 0
	$UpgradeList/IronSlug/Label.visible = PlayerData.player_upgrades[2] > 0
	$UpgradeList/SilverChain/Label.visible = PlayerData.player_upgrades[3] > 0
	$UpgradeList/IronRocket/Label.visible = PlayerData.player_upgrades[4] > 0
	$UpgradeList/SilverFlamer/Label.visible = PlayerData.player_upgrades[5] > 0
	$Close.visible = true
	$Quit.visible = false
	_clock.update_clock(PlayerData.delta_time)

func _on_Close_pressed() -> void:
	get_tree().paused = false
	visible = false

func activate_death() -> void:
	update()
	get_tree().paused = true
	_clock.update_clock(PlayerData.delta_time)
	$Coins.update_coins(PlayerData.mission_coins)
	visible = true
	$Close.visible = false
	$Quit.visible = true

func _on_Quit_pressed() -> void:
	get_tree().paused = false
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to load world")
