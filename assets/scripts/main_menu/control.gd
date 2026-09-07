extends Control

@export var Start_Scene: PackedScene = null
@export var Config_Scene: PackedScene = null
@onready var start_button = $menu/StartButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	

func _on_config_button_pressed() -> void:
	get_tree().change_scene_to_packed(Config_Scene)


func _on_start_button_pressed() -> void:
	MenuMusic.stop()
	get_tree().change_scene_to_packed(Start_Scene)
