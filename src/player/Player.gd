extends Area2D

export var max_hp := 100.0
export var hp := 100.0 setget set_hp
export var max_xp := 2
export var xp := 0
export var speed := 100
var velocity := Vector2.ZERO
var active := true
var Database: Resource = preload("res://data/Database.tres")
signal hp_changed(hp, max_hp)
signal xp_changed(xp, max_xp, level)
signal coins_changed()
signal player_died()

func _ready() -> void:
	PlayerData.current_level = 1
	if PlayerData.connect("player_upgraded", self, "_on_player_upgraded") != OK:
		push_error("player upgrade signal connect fail")
	_on_player_upgraded()
	emit_signal("hp_changed", hp, max_hp)
	emit_signal("coins_changed")
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
	#if velocity != Vector2.ZERO:
	#	$Sprite.rotation = velocity.normalized().angle()
	velocity = velocity.normalized() * speed

var timer = 0
func _process(delta) -> void:
	if active:
		get_input()
		position += velocity * delta
		if position.x < 0 + 16:
			position.x = 0 + 16
		if position.x > 360 - 16:
			position.x = 360 - 16
		if position.y < (1 * 64) + 64:
			position.y = (1 * 64) + 64
		if position.y > (8 * 64) - 16:
			position.y = (8 * 64) - 16
		timer += 1
		if timer > 60: # bought upgrade 1 = health regeneration
			if hp < max_hp:
				set_hp(hp + PlayerData.bought_upgrades[1])
			timer = 0

func _on_Player_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("enemy"):
		set_hp(hp - area.get_parent().attack)

func set_hp(new_hp: float) -> void:
	if new_hp > hp:
		print("heal")
	hp = clamp(new_hp, 0.0, max_hp)
	emit_signal("hp_changed", hp, max_hp)
	if hp <= 0.0:
		player_death()

func player_death() -> void:
	emit_signal("player_died")
	active = false

func pickup_effect(pickup_type) -> void:
	match pickup_type:
		Database.PICKUPS.GEM:
			increase_xp(1)
		Database.PICKUPS.COIN:
			PlayerData.total_coins += 1
			PlayerData.current_coins += 1
			PlayerData.mission_coins += 1
			emit_signal("coins_changed")
		Database.PICKUPS.TEXT:
			if PlayerData.lore_collected < PlayerData.max_lore_entries:
				PlayerData.lore_collected += 1

func increase_xp(xp_amount) -> void:
	xp += xp_amount
	PlayerData.total_exp += xp_amount
	if xp >= max_xp:
		PlayerData.current_level += 1
		xp = xp - max_xp
		max_xp = PlayerData.current_level*2
	emit_signal("xp_changed", xp, max_xp, PlayerData.current_level)

func _on_player_upgraded() -> void:
	$GunForward.update_level()
	$GunForward2.update_level()
	$GunTurret.update_level()
	$GunTurret2.update_level()
	$GunTurret3.update_level()
	$GunTurret4.update_level()
	max_hp += PlayerData.bought_upgrades[0] * 5 # 0 = max_hp
	set_hp(hp + PlayerData.bought_upgrades[0] * 5)
	emit_signal("hp_changed", hp, max_hp)
	emit_signal("coins_changed")
