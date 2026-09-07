class_name InputComponent extends Node

var move_dir: Vector2 = Vector2.ZERO
var last_dir: Vector2 = Vector2.LEFT

var accept_key: bool = false

var attack_button: bool = false


func update() -> void:
	move_dir = Input.get_vector("gm_left","gm_right","gm_up","gm_down")
	if move_dir != Vector2.ZERO:
		last_dir = move_dir
	attack_button = Input.is_action_pressed("gm_attack")
	accept_key = Input.is_action_just_pressed("gm_accept")
	
