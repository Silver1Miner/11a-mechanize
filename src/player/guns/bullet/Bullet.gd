extends Node2D

export var speed := 50 # pixels/sec
export var timer := 1.0
export var damage := 10
enum DAMAGE_TYPE {SILVER, IRON}
export var damage_type := DAMAGE_TYPE.SILVER
export (PackedScene) var Explosion = preload("res://src/world/effects/Explosion.tscn")
onready var _timer := $Timer
onready var _attack_range = $BlastArea
var target_position := Vector2.ZERO

func _ready() -> void:
	_timer.wait_time = timer
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
	explode()

func explode() -> void:
	var targets: Array = _attack_range.get_overlapping_areas()
	var explosion_instance = Explosion.instance()
	get_parent().add_child(explosion_instance)
	explosion_instance.position = get_global_position()
	explosion_instance.scale = Vector2(0.5, 0.5)
	for t in targets:
		if t.is_in_group("enemy"):
			if t.has_method("take_damage"):
				t.take_damage(damage, damage_type)
	queue_free()
