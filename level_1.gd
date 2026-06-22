extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Porg':
		get_tree().call_deferred('reload_current_scene')



func _on_porg_die() -> void:
	get_tree().call_deferred('reload_current_scene')
