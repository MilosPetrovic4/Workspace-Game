extends RigidBody2D


export (int) var maxSpeed = 350
export (int) var minSpeed = 150




# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite.playing = true
	#var mob_types = $AnimatedSprite.frames.get_animation_names()
	#$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #destroys node after it exits the screen
