extends Control

@onready var option_button: OptionButton = $ColorRect/config_menu/Languages/languages_disp

# 1. Dicionário mapeando o Nome Visível -> Código do Locale
@export var idiomas: Dictionary = {
	"Português": "pt_BR",
	"English": "en",
	"Español": "es"
}

func _ready() -> void:
	_configurar_opcoes_de_idioma()
	# Conecta o sinal de seleção do OptionButton
	option_button.item_selected.connect(_on_idioma_selecionado)

func _configurar_opcoes_de_idioma() -> void:
	option_button.clear()
	
	# Pega o idioma que o jogo está usando no momento
	var idioma_atual: String = TranslationServer.get_locale()
	var indice_selecionado: int = 0
	var index: int = 0

	# Preenche o OptionButton com as chaves do dicionário
	for nome_idioma in idiomas.keys():
		option_button.add_item(nome_idioma)
		
		# Guarda o código do locale nos metadados do item
		var codigo_locale: String = idiomas[nome_idioma]
		option_button.set_item_metadata(index, codigo_locale)
		
		# Se for o idioma atual, guarda o índice para deixar pré-selecionado
		if codigo_locale == idioma_atual or idioma_atual.begins_with(codigo_locale):
			indice_selecionado = index
			
		index += 1
		
	# Deixa selecionado visualmente o idioma ativo
	option_button.select(indice_selecionado)

func _on_idioma_selecionado(index: int) -> void:
	# Recupera o código do idioma salvo nos metadados da opção escolhida
	var codigo_locale: String = option_button.get_item_metadata(index)
	
	# Define o novo idioma no Godot
	TranslationServer.set_locale(codigo_locale)
	print("Idioma alterado para: ", codigo_locale)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/menus/menu.tscn")
