static func getToySensitivity(character, bodypart, timeOld, toyStats):
	var sensitiveZone:SensitiveZone = character.getBodypart(bodypart).getSensitiveZone()
	#sensitiveZone.extraSensitivity += 0.05
	#sensitiveZone.sensitivity += 0.01
	var timeNew = GM.main.getTime()
	if timeOld != null:
		if timeOld != timeNew:
			if abs(round(timeNew/60)-round(timeOld/60)) > 0:
				var ticks = round(timeNew/60)-round(timeOld/60)
				sensitiveZone.sensitivity += 0.01
				if sensitiveZone.getSensitivity() + toyStats["sensitivity"]*ticks <= 3:
					sensitiveZone.sensitivity += toyStats["sensitivity"]*ticks
				else:
					sensitiveZone.sensitivity += 3 - sensitiveZone.getSensitivity()
					
				ticks = round(timeNew/60)-round(timeOld/60)/10
				if character.getArousal() + toyStats["arousal"]*ticks <= 0.90:
					character.addArousal(toyStats["arousal"]*ticks)
				else:
					character.addArousal(0.90 - character.getArousal())
				
				character.addLust(toyStats["lust"])
	timeOld = timeNew
	
	return timeOld
