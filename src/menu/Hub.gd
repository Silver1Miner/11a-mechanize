extends Control

func _on_Start_pressed() -> void:
	PlayerData.fresh_restart()
	if get_tree().change_scene_to(PlayerData.world) != OK:
		push_error("fail to load world")

func _on_Store_pressed() -> void:
	$StoreMenu.activate_shop()

func _on_Manual_pressed() -> void:
	pass # Replace with function body.

func _on_Back_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to go to main menu")
