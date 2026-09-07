class_name HealthComponent extends Node

signal health_changed(current: int, max: float)
signal died

@export var max_health: int = 5
var current_health: int= 0.0

func _ready() -> void:
	current_health = max_health
	_emit()

func damage(amount: int) -> void:
	current_health = clamp(current_health - amount,0,max_health)
	_emit()
	if current_health == 0:
		died.emit()

func heal(amount: int) -> void:
	current_health = clamp(current_health + amount,0,max_health)
	_emit()

	
func _emit() -> void:
	health_changed.emit(current_health,max_health)
