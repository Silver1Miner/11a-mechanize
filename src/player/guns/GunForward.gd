extends Node2D

export var is_hitscan := true
enum GUN_NAME {REVOLVER, SMG, SHOTGUN, CHAINGUN, ROCKET, FLAMER}
export var gun_id := GUN_NAME.REVOLVER
enum DAMAGE_TYPE {SILVER, IRON}
export var damage_type := DAMAGE_TYPE.SILVER
export var attack_damage := 1.0
export var attack_cooldown := 1.0

onready var _laser_sight := $Line2D
onready var _raycast := $RayCast2D
onready var _shoot_sound = $AudioStreamPlayer2D
onready var _cooldown_timer := $Timer
onready var _shot_effect := $AnimatedSprite

var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	add_to_group("guns")
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.default_color = Database.type_colors[damage_type]
	update_level()

var current_level = 0
func update_level() -> void:
	var new_level = PlayerData.player_upgrades[gun_id]
	if new_level != current_level:
		current_level = new_level
		if current_level < len(Database.upgrades[gun_id]["damage"]):
			attack_damage = Database.upgrades[gun_id]["damage"][PlayerData.player_upgrades[gun_id]]
		if current_level < len(Database.upgrades[gun_id]["cooldown"]):
			attack_cooldown = Database.upgrades[gun_id]["cooldown"][PlayerData.player_upgrades[gun_id]]

func _process(_delta: float) -> void:
	if _raycast.is_colliding():
		var target = _raycast.get_collider()
		#if target.is_in_group("detection") or target.is_in_group("player"):
		#	_raycast.add_exception(target)
		if target.is_in_group("enemy"):
			_laser_sight.points[1] = to_local(_raycast.get_collision_point())
		if target.position.y > 64 and _cooldown_timer.is_stopped():
			shoot_at(target)
	else:
		_laser_sight.points[1] = _raycast.cast_to

func shoot_at(target: Area2D) -> void:
	_shot_effect.frame = 0
	_shot_effect.play()
	_shoot_sound.play()
	if is_hitscan:
		if target.has_method("take_damage"):
			target.take_damage(attack_damage, damage_type)
	_cooldown_timer.start(attack_cooldown)
