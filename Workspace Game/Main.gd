extends Node

export (PackedScene) var Mob
export (PackedScene) var Task
var task
var score = 0
export (int) var time_left = 90
var time = time_left

signal task #used for hiding collected tasks

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Labels.update_time(time_left)
	
#Every second a new mob is added
func _on_MobTimer_timeout():
	 # Choose a random location on the path
	$MobPath/MobSpawnLocations.set_offset(randi())
	# Creates mob instance
	var mob = Mob.instance()
	add_child(mob)
	# Get 
	var direction = $MobPath/MobSpawnLocations.rotation - PI / 2
	# mob position
	mob.position = $MobPath/MobSpawnLocations.position
	# Make direction random
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Velocity
	mob.set_linear_velocity(Vector2(rand_range(mob.minSpeed, mob.maxSpeed), 0).rotated(direction))

#Spawns a task in a random spot 
func create_task():
	$TaskPath/TaskSpawnLocations.set_offset(randi() )
	task = Task.instance()
	add_child(task)
	task.position = $TaskPath/TaskSpawnLocations.position


#When start button is pressed, initializes game (timers, mob spawning, task spawning)
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

#When timer runs out or player is hit by enemy
func _game_over():
	$MobTimer.stop()
	$Player.hide()
	$Labels/Start.show()
	$GameTimer.stop()
	$Labels/Time.hide()
	$Labels/Score.hide()
	$Countdown.stop()
	task.destroyTask()

#every second update timer
func _on_Countdown_timeout():
	time_left -= 1       
	$Labels.update_time(time_left)

#Tmer runs out
func _on_GameTimer_timeout():
	_game_over()

#When player collects a task item
func _on_Player_taskComplete():
	score += 1
	$Labels.update_score(str(score) )
	
	#Destroys old task and creates new task
	task.destroyTask()
	create_task()
	
#1 second after start, first task spawns
func _on_TaskTimer_timeout():
	create_task()
	

