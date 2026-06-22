extends StaticBody2D

const POWERUP = preload("res://donut.tscn")

var usable = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dispense() -> void:
	if usable == true:
		var power_up = POWERUP.instantiate()
		power_up.global_position = global_position + Vector2(0, -64)
		get_tree().current_scene.call_deferred("add_child", power_up)
		usable = false;
	else:
		pass
