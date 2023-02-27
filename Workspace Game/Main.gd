extends Node

export (PackedScene) var Mob
var score = 0
export (int) var time_left


# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize()
	$Labels.update_time(time_left)
	
	
	

	


func _on_MobTimer_timeout():
	 # Choose a random location on Path2D.
	$MobPath/MobSpawnLocations.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocations.rotation - PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocations.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Choose the velocity.
	mob.set_linear_velocity(Vector2(rand_range(mob.minSpeed, mob.maxSpeed), 0).rotated(direction))


	



func start_game():
	
	$Player.show()
	$MobTimer.start()
	
	$Labels.update_score(score)
	$Countdown.start()


func _game_over():
	$MobTimer.stop()
	$Player.hide()
	$Labels/Start.show()
	$GameTimer.stop()
	$Labels/Time.hide()
	$Labels/Score.hide()
	$Countdown.stop()

func _on_Countdown_timeout():
	time_left -= 1
	$Labels.update_time(time_left)

#Tmer runs out
func _on_GameTimer_timeout():
	_game_over()
