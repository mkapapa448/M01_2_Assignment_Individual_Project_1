extends CanvasLayer

@onready var lives_label = $Control/HBoxContainer/Lives
@onready var donuts_label = $Control/HBoxContainer/Donuts

func _ready():
	# Update the label text with a basic string
	lives_label.text = "Lives remaining: " + str(Game.lives)
	donuts_label.text = "Donuts collected: " + str(Game.donuts)

func _process(delta):
	# Continuously update the label with a dynamic variable
	# Note: Always wrap non-string variables in str() to prevent crashes
	lives_label.text = "Lives remaining: " + str(Game.lives)
	donuts_label.text = "Donuts collected: " + str(Game.donuts)
