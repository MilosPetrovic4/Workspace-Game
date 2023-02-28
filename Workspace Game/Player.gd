extends Area2D

#Signal for when player is hit
#signal hit

export var speed = 400 # Player speed
var screen_size # screensize
signal hit
signal taskComplete 

#Runs once
func _ready():
	screen_size = get_viewport_rect().size
	hide()


#Runs through continously
func _process(delta):
	var velocity = Vector2.ZERO # Player movement
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	#Normalizes vectors since diagonal vectors are longer than horizontal ones
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite.play()
	else:
		#$AnimatedSprite.stop()
		pass



	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Area2D_body_entered(body):
	
	if body is StaticBody2D:
		emit_signal("taskComplete")

	elif body is RigidBody2D:
		emit_signal("hit")
		
	
		
		
		


#	if body extends RigidBody2D:
#		emit_signal("hit")
#		$CollisionShape2D.disabled = true
#	elif body extends StaticBody2D:
#		emit_signal("taskComplete")
		
		



