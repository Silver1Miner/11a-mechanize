extends Area2D

func _ready() -> void:
	add_to_group("pickup")

func _on_Pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("picked up")
		queue_free()
