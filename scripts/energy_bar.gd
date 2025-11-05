extends TextureProgressBar


func _process(delta: float) -> void:
	value = move_toward(value, Global.energy, 5. * delta)
	$Energy/EnergyLabel.text = "%d" % floori(Global.energy)
