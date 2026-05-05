extends AnimationPlayer

func anim(_arg):
	if _arg == "on":
		play("Vib")
	elif _arg == "off":
		stop(true)
		
