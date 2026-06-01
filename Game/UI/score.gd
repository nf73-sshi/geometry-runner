extends Label

func _process(delta: float) -> void:
	text = "Score\n%d" % GameManager.score
