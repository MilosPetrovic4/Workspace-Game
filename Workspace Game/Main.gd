extends Node

export (PackedScene) var Mob
export (PackedScene) var Task
var score = 0
export (int) var time_left = 90
var time = time_left


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
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


	

func create_task():
	$TaskPath/TaskSpawnLocations.set_offset(randi() )

	var task = Task.instance()
	add_child(task)
	
	task.position = $TaskPath/TaskSpawnLocations.position



func start_game():
	
	$Player.show()
	$MobTimer.start()
	$GameTimer.start()
	
	$Labels.update_score(score)
	$Countdown.start()
	$Labels/Time.show()
	$Labels/Score.show()
	
	$Labels.update_time(time)
	time_left = time
	
	$Labels.update_score(0)
	score = 0
	
	$TaskTimer.start()


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

#When player collects a task item
func _on_Player_taskComplete():
	score += 1
	print(score)
	$Labels.update_score(str(score) )
	create_task()


func _on_TaskTimer_timeout():
	create_task()
