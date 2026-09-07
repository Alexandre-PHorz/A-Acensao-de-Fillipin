class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var speed: float = 200
@export var diretions: int = 8

var directing: Vector2 = Vector2.ZERO


func tick(delta: float) -> void:
	if body == null:
		return
	
	# Trava o vetor de entrada nas N direções configuradas
	var final_direction := quantizar_direcao(directing, diretions)
	
	# Aplica o movimento
	body.velocity = final_direction * speed
	body.move_and_slide()


## Converte qualquer vetor de entrada para N direções fixas
func quantizar_direcao(vetor_entrada: Vector2, num_direcoes: int) -> Vector2:
	if vetor_entrada == Vector2.ZERO:
		return Vector2.ZERO
		
	if num_direcoes <= 0:
		return vetor_entrada.normalized()
		
	var passo_angulo := (2.0 * PI) / num_direcoes
	var angulo_quantizado := snappedf(vetor_entrada.angle(), passo_angulo)
	
	return Vector2.RIGHT.rotated(angulo_quantizado)
