extends Control

func _ready() -> void:
	$StoreMenu.visible = false
	$Manual.visible = false

func _on_Start_pressed() -> void:
	PlayerData.fresh_restart()
	if get_tree().change_scene_to(PlayerData.world) != OK:
		push_error("fail to load world")

func _on_Store_pressed() -> void:
	$StoreMenu.activate_shop()

func _on_Manual_pressed() -> void:
	$Manual.activate_manual()

func _on_Back_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to go to main menu")
