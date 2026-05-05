	GM.main.getCharacter("ToysBox").getCharacterWithItem(_character, id)
	character = _character
		
	var sensitiveZone:SensitiveZone = _character.getBodypart(BodypartSlot.Breasts).getSensitiveZone()
	
	if turnON == "on":
		var timeNew = GM.main.getTime()
		if timeOld != null:
			if timeOld != timeNew:
				if abs(round(timeNew/60)-round(timeOld/60)) > 0:
					for _i in range(round(timeNew/60)-round(timeOld/60)):
						sensitiveZone.stimulate(1)
						sensitiveZone.onDenyTick()
						if sensitiveZone.getSensitivity() >= 3:
							break
					if _character != GM.pc:
						for _i in range((round(timeNew/60)-round(timeOld/60))/10):
							if _character.getArousal() >= 0.90:
								break
							_character.addArousal(0.05)

		timeOld = timeNew
