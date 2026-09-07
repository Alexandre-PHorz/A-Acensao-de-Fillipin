class_name LinearMovimentComponent extends Node

@export var body: Node2D = null
@export var speed: float = 400.0


func _process(delta: float) -> void:
	if body:
		# 1. Obtemos a direção "para frente" baseada na rotação do corpo.
		# No Godot 2D, o "frente" padrão é o eixo X positivo (Vector2.RIGHT). [3]
		var velocity = Vector2.RIGHT.rotated(body.rotation) * speed
		
		# 2. Aplicamos o movimento à posição global do corpo.
		# Multiplicamos por 'delta' para que a velocidade seja constante, 
		# independente da taxa de quadros (FPS) do computador. [4]
		body.global_position += velocity * delta
