extends RigidBody2D


export (int) var maxSpeed
export (int) var minSpeed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite.playing = true
	#var mob_types = $AnimatedSprite.frames.get_animation_names()
	#$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #destroys node after it exits the screen
