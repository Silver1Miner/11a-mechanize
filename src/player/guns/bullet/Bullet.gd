extends Node2D

export var speed := 50 # pixels/sec
export var timer := 1.0
export var damage := 10
export var explosion_scale := 2.0
export var explode_on_timeout = true
enum DAMAGE_TYPE {SILVER, IRON}
export var damage_type := DAMAGE_TYPE.SILVER
export (PackedScene) var Explosion = preload("res://src/world/effects/Explosion.tscn")
onready var _timer := $Timer
onready var _attack_range = $BlastArea
var target_position := Vector2.ZERO

func _ready() -> void:
	set_timer(timer)

func set_timer(new_time: float) -> void:
	_timer.wait_time = new_time
	_timer.start()

func set_hit_blast(hit_radius: float, blast_radius: float) -> void:
	$Hitbox/CollisionShape2D.shape.radius = hit_radius
	$BlastArea/CollisionShape2D.shape.radius = blast_radius

func _process(delta: float) -> void:
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("enemy"):
		explode()

func _on_Timer_timeout() -> void:
	if explode_on_timeout:
		explode()
	else:
		queue_free()

func explode() -> void:
	var targets: Array = _attack_range.get_overlapping_areas()
	var explosion_instance = Explosion.instance()
	get_parent().add_child(explosion_instance)
	explosion_instance.position = get_global_position()
	explosion_instance.scale = Vector2(explosion_scale, explosion_scale)
	for t in targets:
		if t.get_parent().is_in_group("enemy"):
			if t.get_parent().has_method("take_damage"):
				t.get_parent().take_damage(damage, damage_type)
	queue_free()
