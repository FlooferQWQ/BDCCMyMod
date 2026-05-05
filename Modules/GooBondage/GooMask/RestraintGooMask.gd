extends RestraintData
class_name RestraintGooMask

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = "GooMask"

func canUnlockWithKey():
	return false

func alwaysSavedWhenStruggledOutOf():
	return true

func getResistAnimation():
	return "struggle_gag"

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
		text = "{user.name} feebly tries to remove the goo mask, but it locks on tighter and spills a lot of goo down {user.his} throat."
		damage = -1.0
		stamina = RNG.randi_range(10, 15)
		lust = scaleDamage(5)
		_pc.getBodypart(BodypartSlot.Head).addFluidOrifice("BlackGoo", RNG.randf_range(500.0, 1000.0))
	elif(_handsFree && _armsFree):
		text = "{user.name} pulls on the goo mask, trying to remove it."
		damage = calcDamage(_pc, _minigame)
		stamina = RNG.randi_range(5, 10)
	elif(_handsFree):
		text = "{user.name} strains {user.his} constricted arms to reach up and pull on the goo mask."
		damage = calcDamage(_pc, _minigame, 0.7)
		stamina = RNG.randi_range(8, 10)
	elif(_armsFree):
		text = "{user.name} pushes on the goo mask with {user.his} arms and restricted hands, trying to loosen it."
		damage = calcDamage(_pc, _minigame, 0.6)
		stamina = RNG.randi_range(8, 10)
	else:
		text = "{user.name} shakes {user.his} head, desperately trying to loosen the goo mask."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = RNG.randi_range(5, 15)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(failChance(_pc, 10) || _isActivelyStruggling):
		_pc.getBodypart(BodypartSlot.Head).addFluidOrifice("BlackGoo", RNG.randf_range(50.0, 100.0))
		return {"text": "Warm goo drips through the mask into {user.nameS} throat", "lust": scaleDamage(2)}
