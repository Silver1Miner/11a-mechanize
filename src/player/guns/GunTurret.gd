extends Node2D

export var is_hitscan := true
enum DAMAGE_TYPE {SILVER, IRON}
export var damage_type := DAMAGE_TYPE.SILVER
export var attack_damage := 10.0
export var attack_cooldown := 1.0
export var attack_radius := 10.0

onready var _laser_sight := $Line2D
onready var _raycast := $Sprite/RayCast2D
onready var _shoot_sound = $AudioStreamPlayer2D
onready var _attack_range := $AttackZone
onready var _hit_radius := $AttackZone/CollisionShape2D
onready var _cooldown_timer := $Timer
onready var _shot_effect := $Sprite/AnimatedSprite

func _ready() -> void:
	add_to_group("guns")
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.default_color = Database.type_colors[damage_type]

func _process(_delta: float) -> void:
	var targets: Array = _attack_range.get_overlapping_areas()
	if targets.empty():
		_laser_sight.points[1] = Vector2.ZERO
		return
	var target
	for t in targets:
		if t.is_in_group("enemy"):
			target = t
			break
	if target != null:
		$Sprite.look_at(target.global_position)
		_laser_sight.points[1] = target.global_position - global_position
		var cast_point = _raycast.cast_to
		_raycast.force_raycast_update()
		if _raycast.is_colliding():
			cast_point = to_local(_raycast.get_collision_point())
		_laser_sight.points[1] = cast_point
		if _cooldown_timer.is_stopped():
			shoot_at(target)
	else:
		_laser_sight.points[1] = Vector2.ZERO

func shoot_at(target: Area2D) -> void:
	_shot_effect.frame = 0
	_shot_effect.play()
	_shoot_sound.play()
	if is_hitscan:
		if target.has_method("take_damage"):
			target.take_damage(attack_damage, damage_type)
	else:
		print("projectiles not yet implemented")
	_cooldown_timer.start(attack_cooldown)
