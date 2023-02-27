extends CanvasLayer

signal start_game

func _ready():
	pass # Replace with function body.

#Update score
func update_score(score):
	$Score.text = str(score)

	
	
func _on_Start_pressed():
	emit_signal("start_game")
	$Start.hide()
	
func update_time(time):
	$Time.text = str(time)


