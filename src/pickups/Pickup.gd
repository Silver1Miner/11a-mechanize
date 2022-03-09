extends Area2D

var Database: Resource = preload("res://data/Database.tres")
export var pickup_type := 0
export (PackedScene) var FCT = preload("res://src/effects/FCT.tscn")

func _ready() -> void:
	add_to_group("pickup")

func _on_Pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.pickup_effect(pickup_type)
		var fct = FCT.instance()
		get_parent().add_child(fct)
		fct.rect_position = get_global_position() + Vector2(0,-16)
		fct.show_value(Database.pickup_effect_text[pickup_type], Vector2(0,-8), 1, PI/2, false)
		queue_free()
