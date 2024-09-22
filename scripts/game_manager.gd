extends Node

var score = 0

@onready var total_score: Label = $"Total Score"

func add_points():
	score += 1
	total_score.text = "Your Total Score Are: " + str(score)
	
