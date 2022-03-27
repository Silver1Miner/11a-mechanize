extends Node2D

export var is_hitscan := true
enum GUN_NAME {REVOLVER, SMG, SHOTGUN, CHAINGUN, ROCKET, FLAMER}
export var gun_id := GUN_NAME.REVOLVER
enum DAMAGE_TYPE {SILVER, IRON}
export var damage_type := DAMAGE_TYPE.SILVER
export var attack_damage := 1.0
export var attack_cooldown := 1.0
export var shot_sound = preload("res://assets/audio/Shot.ogg")

onready var _laser_sight := $Line2D
onready var _raycast := $RayCast2D
onready var _shoot_sound = $AudioStreamPlayer2D
onready var _cooldown_timer := $Timer
onready var _shot_effect := $AnimatedSprite

var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	add_to_group("guns")
	$AudioStreamPlayer2D.stream = shot_sound
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)
	var r = Database.type_colors[damage_type+3].r
	var g = Database.type_colors[damage_type+3].g
	var b = Database.type_colors[damage_type+3].b
	_laser_sight.default_color = Color(r, g, b, 0.6)
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
		if target and target.get_parent() and target.get_parent().is_in_group("enemy"):
			_laser_sight.points[1] = to_local(_raycast.get_collision_point())
		if target and target.get_parent() and _cooldown_timer.is_stopped():
			if target.get_global_position().y < (18 * 30) - 16 and \
			target.get_global_position().y > (3 * 30) + 16 and \
			target.get_global_position().x > 0 + 16 and \
			target.get_global_position().x < 360 - 16:
				shoot_at(target)
	else:
		_laser_sight.points[1] = _raycast.cast_to

func shoot_at(target: Area2D) -> void:
	_shot_effect.frame = 0
	_shot_effect.play()
	_shoot_sound.play()
	if is_hitscan:
		if target.get_parent().has_method("take_damage"):
			target.get_parent().take_damage(attack_damage, damage_type)
	_cooldown_timer.start(attack_cooldown)
