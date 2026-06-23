extends Node2D

var lives

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lives = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Porg':
		get_tree().call_deferred('reload_current_scene')



func _on_porg_die() -> void:
	Game.lives -= 1
	if Game.lives > 0:
		get_tree().call_deferred('reload_current_scene')
	else:
		Game.reset_game()
		get_tree().change_scene_to_file("res://lose_1.tscn")
