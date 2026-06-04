extends Label

func _physics_process(delta: float) -> void:
	text = "Score\n%d" % GameManager.score

func _on_score_timer_timeout() -> void:
	if get_tree().get_first_node_in_group("Player") == null:
		return
		
	GameManager.score += 1
