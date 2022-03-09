extends Area2D

export var max_hp := 100.0
export var hp := 100.0 setget set_hp
export var speed := 100
var velocity := Vector2.ZERO
var active := true
var Database: Resource = preload("res://data/Database.tres")
signal hp_changed(hp)
signal player_died()
signal pickup(pickup_type)

func _ready() -> void:
	emit_signal("hp_changed", hp, max_hp)
	add_to_group("player")

func pickup_effect(pickup_type) -> void:
	match pickup_type:
		Database.PICKUPS.GEM:
			PlayerData.session_exp += 10
		Database.PICKUPS.COIN:
			PlayerData.session_coins += 1
	emit_signal("pickup", pickup_type)

func get_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if velocity != Vector2.ZERO:
		$Sprite.rotation = velocity.normalized().angle()
	velocity = velocity.normalized() * speed

func _process(delta) -> void:
	if active:
		get_input()
		position += velocity * delta
		if position.x < 0 + 16:
			position.x = 0 + 16
		if position.x > 768 - 16:
			position.x = 768 - 16
		if position.y < 0 + 16:
			position.y = 0 + 16
		if position.y > 768 - 16:
			position.y = 768 - 16

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		set_hp(hp - area.hp)

func set_hp(new_hp: float) -> void:
	if new_hp > hp:
		print("heal")
	hp = clamp(new_hp, 0.0, max_hp)
	emit_signal("hp_changed", hp, max_hp)
	if hp <= 0.0:
		player_death()

func player_death() -> void:
	emit_signal("player_died")
	print("player died")
	active = false
