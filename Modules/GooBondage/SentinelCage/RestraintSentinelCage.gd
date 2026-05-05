extends RestraintData
class_name RestraintSentinelCage

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = RestraintType.ChastityCage
	sexReaction = SexReaction.BondageChastityCage

func canUnlockWithKey():
	return true

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
		text = "{user.name} tries to remove the Sentinel cage, but it only tightens around {user.his} cock and gives it a mean jolt."
		damage = -1.0
		stamina = RNG.randi_range(15, 20)
		lust = scaleDamage(5)
		pain = scaleDamage(10)
	elif(_handsFree && _armsFree):
		text = "{user.name} tries carefully sliding the Sentinel cage off. The tug on {user.his} penis is slightly arousing."
		damage = calcDamage(_pc, _minigame, 0.8)
		stamina = RNG.randi_range(5, 10)
		lust = scaleDamage(3)
	elif(_handsFree):
		text = "{user.name} awkwardly yanks on the Sentinel cage, triggering an electrical jolt into {user.his} cock."
		damage = calcDamage(_pc, _minigame, 0.6)
		stamina = RNG.randi_range(5, 10)
		lust = scaleDamage(3)
		pain = scaleDamage(3)
	elif(_armsFree):
		text = "{user.name} pushes on the Sentinel cage, triggering its punishment protocol. Its vibration and electrostim functions are greatly amplified for a moment."
		damage = calcDamage(_pc, _minigame, 0.4)
		stamina = RNG.randi_range(10, 15)
		lust = scaleDamage(6)
		pain = scaleDamage(6)
	else:
		text = "{user.name} wildly shakes {user.his} hips trying to free {user.his} encased cock. All kinds of vibrators and zappers go off inside."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = RNG.randi_range(15, 25)
		lust = scaleDamage(8)
		pain = scaleDamage(8)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(failChance(_pc, 10)):
		return {"text": "The Sentinel cage vibrates and zaps {user.name}'s trapped cock", "lust": scaleDamage(8), "pain": scaleDamage(8)}
	elif(failChance(_pc, 10)):
		return {"text": "The Sentinel cage vibrates intensely around {user.name}'s cock", "lust": scaleDamage(10)}
	elif(failChance(_pc, 10)):
		return {"text": "{user.nameS} encased cock recieves a sudden shock", "pain": scaleDamage(10)}
