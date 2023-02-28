extends CanvasLayer

signal start_game

func _ready():
	$Highscore.hide()

#Update score
func update_score(score):
	$Score.text = str(score)

	
#Start button	
func _on_Start_pressed():
	emit_signal("start_game")
	$Start.hide()
	
#update time label
func update_time(time):
	$Time.text = str(time)
	
	
	
func update_highscore(high):
	$Highscore.text = "Highest: "  + str(high)



