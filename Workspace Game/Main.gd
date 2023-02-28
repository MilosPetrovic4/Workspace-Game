extends Node

export (PackedScene) var Mob
export (PackedScene) var Task
export (PackedScene) var Task2
var task
var task2
var score = 0
var highscore = 0
export (int) var time_left = 90
var time = time_left
var task2Exists = false
var startLocation = Vector2(400,400)

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
	# get direction perpendicular to path
	var direction = $MobPath/MobSpawnLocations.rotation - PI / 2
	# mob position
	mob.position = $MobPath/MobSpawnLocations.position
	# Make direction random
	direction += rand_range(-PI / 5, PI / 5)
	mob.rotation = direction
	# Velocity
	mob.set_linear_velocity(Vector2(rand_range(mob.minSpeed, mob.maxSpeed), 0).rotated(direction))

#Spawns a task in a random spot 
func create_task():
	$TaskPath/TaskSpawnLocations.set_offset(randi() )
	task = Task.instance()
	add_child(task)
	task.position = $TaskPath/TaskSpawnLocations.position
	
func create_task2():
	$TaskPath/TaskSpawnLocations.set_offset(randi() )
	task2 = Task2.instance()
	add_child(task2)
	task2.position = $TaskPath/TaskSpawnLocations.position


#When start button is pressed, initializes game (timers, mob spawning, task spawning)
func start_game():
	
	$Player.startPos(startLocation)
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
	$Task2Timer.start()
	
	$Labels/Highscore.hide()

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
	
	if task2Exists == true:
		task2.destroyTask()
	
	if score > highscore:
		highscore = score
		$Labels.update_highscore(highscore)
		$Labels/Highscore.show()
		
	else:
		$Labels/Highscore.show()

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
	


#runs when player presses e
func _on_Player_wirelessTask():
	
	#If task exists start 1 second timer
	if task2Exists == true:
		$Task2Duration.start()
	else:
		pass

#Once task is completed,  there is 8 second timer to spawn another
func _on_Task2Timer_timeout():
	#Creates new task after 8 seconds
	create_task2()
	task2Exists = true
	

#hold e for 1 second to complete task
func _on_Task2Duration_timeout():
	#updates score
	score += 3
	$Labels.update_score(score)
	
	#destroys current task
	task2.destroyTask()
	task2Exists = false
	
	#starts timer for creating next task
	$Task2Timer.start()


func _on_Player_releaseE():
	$Task2Duration.stop()
