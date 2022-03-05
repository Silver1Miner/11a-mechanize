extends Area2D

export var max_hp := 100.0
export var hp := 100.0 setget set_hp
export var speed := 100
var velocity := Vector2.ZERO
var active := true
signal hp_changed(hp)
signal player_died()

func _ready() -> void:
	add_to_group("player")

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
		if position.x > 720 - 16:
			position.x = 720 - 16
		if position.y < 0 + 16:
			position.y = 0 + 16
		if position.y > 1280 - 16:
			position.y = 1280 - 16

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		set_hp(hp - area.hp)

func set_hp(new_hp: float) -> void:
	if new_hp > hp:
		print("heal")
	hp = clamp(new_hp, 0.0, max_hp)
	print(hp)
	emit_signal("hp_changed", hp)
	if hp <= 0.0:
		player_death()

func player_death() -> void:
	emit_signal("player_died")
	print("player died")
	active = false
