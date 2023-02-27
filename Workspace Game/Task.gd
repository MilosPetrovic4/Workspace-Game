extends StaticBody2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass 



func _on_Area2D_body_entered(_body):
	queue_free()
