extends Label

func _physics_process(delta: float) -> void:
	text = "Score\n%d" % GameManager.score

func _on_score_timer_timeout() -> void:
	GameManager.score += 1
