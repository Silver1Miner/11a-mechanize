extends Node2D

var last_player_position := Vector2.ZERO
onready var nav_2d: Navigation2D = $Navigation2D

func _ready() -> void:
	last_player_position = $Player.position

func _on_Player_player_moved(player_position) -> void:
	if player_position == last_player_position:
		return
