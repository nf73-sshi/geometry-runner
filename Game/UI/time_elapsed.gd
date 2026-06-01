extends Label

var start_time : int = 0
var time_elapsed : float = 0.0
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	
func _process(delta: float) -> void:
	if get_tree().get_first_node_in_group("Player") == null:
		return
		
	time_elapsed = (Time.get_ticks_msec() - start_time) / 1000.0
	
	var currentTime : int = time_elapsed
	var hours = currentTime / 3600
	var minutes = (currentTime % 3600) / 60
	var secs = (currentTime) % 60
	
	text = "Time\n%02dh %02dm %02ds" % [hours, minutes, secs]
