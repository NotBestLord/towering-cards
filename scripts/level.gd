class_name Level
extends Resource


@export var map : PackedScene
## '::' will declare a wave
## commands:
## enemy [name] [amount] [release_duration] [wait/parallel]
## wait = will summon only after previous command is finished
## parallel = will summon in parallel with previous command
@export_multiline var rounds := ""


func get_round_count() -> int:
	var lines : Array[String] = []
	lines.append_array(rounds.strip_edges().split("::"))
	lines = lines.filter(
		func(line):
			return not line.begins_with("#")
	)
	return lines.size()


func get_round_data(index : int) -> String:
	var lines : Array[String] = []
	lines.append_array(rounds.strip_edges().split("::"))
	lines = lines.filter(
		func(line):
			return not line.strip_edges().begins_with("#")
	)
	
	if lines.size() <= index:
		return ""
	return lines[index]
