class_name AttackRangedComponent extends Node2D

@export var bullet_scene: PackedScene
@export var amount: int = 1         # Quantidade de balas no disparo
@export var directions: int = 4     # Quantidade de direções fixas permitidas (ex: 4, 8, 12, 16)
@export var spread_width: float = 20.0 # Distância lateral total entre a primeira e a última bala
@export var spawn_distance: float = 30.0
@export var fire_rate: float = 0.5
@export var timer: Timer


func fire(direction: Vector2) -> void:
	if not timer.is_stopped() or not bullet_scene or direction == Vector2.ZERO:
		return
		
	timer.start(fire_rate)
	
	# 1. Ajusta a direção para o degrau fixo mais próximo entre N direções
	var dir_quantizada := quantizar_direcao(direction, directions)
	
	# 2. Vetor perpendicular para o deslocamento lateral
	var perp_dir := Vector2(-dir_quantizada.y, dir_quantizada.x).normalized()
	
	# 3. Caso de bala única
	
	if amount <= 1:
		_create_instance(dir_quantizada, perp_dir, 0.0)
	else:
		# Cálculo de espaçamento uniforme entre as balas
		var spacing := spread_width / (amount - 1)
		var start_offset := -spread_width / 2.0
		
		for i in range(amount):
			var current_offset := start_offset + (i * spacing)
			_create_instance(dir_quantizada, perp_dir, current_offset)


## Função para travar qualquer vetor de entrada em N direções fixas
func quantizar_direcao(vetor_entrada: Vector2, num_direcoes: int) -> Vector2:
	if num_direcoes <= 0:
		return vetor_entrada.normalized()
		
	var passo_angulo := (2.0 * PI) / num_direcoes
	var angulo_quantizado := snappedf(vetor_entrada.angle(), passo_angulo)
	
	return Vector2.RIGHT.rotated(angulo_quantizado)


func _create_instance(dir: Vector2, perp: Vector2, offset: float) -> void:
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet) 
	
	var base_pos = global_position + (dir.normalized() * spawn_distance)
	bullet.global_position = base_pos + (perp * offset)
	bullet.rotation = dir.angle()
	
	# Passa a direção travada para a bala caso ela tenha a variável
	if "direction" in bullet:
		bullet.direction = dir
