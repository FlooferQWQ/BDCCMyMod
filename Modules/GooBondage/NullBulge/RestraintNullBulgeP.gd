extends RestraintData
class_name RestraintNullBulgeP

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = "NullBulgeP"

func canUnlockWithKey():
	return false

func alwaysSavedWhenStruggledOutOf():
	return true

func doStruggle(_pc, _minigame:MinigameResult):
	var _handsFree = !_pc.hasBlockedHands()
	var _armsFree = !_pc.hasBoundArms()
	var _legsFree = !_pc.hasBoundLegs()
	var _canSee = !_pc.isBlindfolded()
	var _canBite = !_pc.isBitingBlocked()
	
	var text = "error?"
	var lust = 0
	var pain = 0
	var damage = 0
	var stamina = 0
	
	if(failChanceLowScore(_pc, 10, _minigame)):
		text = "{user.name} tries to remove the null bulge, but it only tightens its grip on {user.his} cock. The bulge vibrates more intensely around {user.his} shaft."
		damage = -1.0
		stamina = RNG.randi_range(15, 20)
		lust = scaleDamage(10)
	elif(_handsFree && _armsFree):
		text = "{user.name} tugs on the null bulge latched to {user.his} cock, trying to pull it off. The bulge vibrates a bit more in response."
		damage = calcDamage(_pc, _minigame, 0.8)
		stamina = RNG.randi_range(5, 10)
		lust = scaleDamage(5)
	elif(_handsFree):
		text = "{user.name} awkwardly pulls on the null bulge over {user.his} cock. The bulge vibrates a bit more in response."
		damage = calcDamage(_pc, _minigame, 0.6)
		stamina = RNG.randi_range(5, 10)
		lust = scaleDamage(5)
	elif(_armsFree):
		text = "{user.name} presses {user.his} restricted hands into {user.his} null bulge, trying to loosen its grip on {user.his} cock. The bulge's vibrations are amplified by the pressure."
		damage = calcDamage(_pc, _minigame, 0.4)
		stamina = RNG.randi_range(10, 15)
		lust = scaleDamage(8)
	else:
		text = "{user.name} shakes {user.his} rear, desperately trying to loosen the null bulge on {user.his} cock. The bulge's vibrations are amplified by the motion."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = RNG.randi_range(10, 15)
		lust = scaleDamage(8)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(failChance(_pc, 30) || _isActivelyStruggling):
		return {"text": RNG.pick(["{user.nameS} null bulge vibrates around the head of {user.his} penis", "{user.nameS} null bulge tightens around {user.his} shaft"]), "lust": scaleDamage(5)}
