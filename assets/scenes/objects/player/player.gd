class_name Player extends CharacterBody2D

var _state_machine

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var attack_renged_component: AttackRangedComponent = %AttackRangedComponent
@onready var _animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	health_component.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	input_component.update()
	update_sprite()
	movement_component.directing = input_component.move_dir
	
	_animation_tree["parameters/idle/blend_position"] = input_component.last_dir
	_animation_tree["parameters/walk/blend_position"] = input_component.move_dir
	
	movement_component.tick(delta)
	
	if input_component.attack_button:
		#
		attack_renged_component.fire(input_component.last_dir)


func _on_died() -> void:
	_state_machine.travel("died")
	get_tree().quit()
	
func update_sprite() -> void:
	if velocity.length() > 1:
		_state_machine.travel("walk")
		return
	
	_state_machine.travel("idle")
	pass
