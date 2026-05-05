extends RestraintData
class_name RestraintGooeyCorset

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = "GooeyCorset"

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
	
	if(failChanceLowScore(_pc, 5, _minigame)):
		text = "{user.name} fiddles with the corset and accidentally triggers a trap! Goo explodes all over {user.him} as the corset tightens around {user.his} waist."
		damage = -1.0
		stamina = RNG.randi_range(15, 20)
		lust = scaleDamage(5)
		_pc.coverBodyWithFluid("BlackGoo", RNG.randf_range(200.0, 500.0))
	elif(_handsFree && _armsFree):
		text = "{user.name} tries pulling off the unusually sticky corset."
		damage = calcDamage(_pc, _minigame)
		stamina = RNG.randi_range(5, 10)
	elif(_handsFree):
		text = "{user.name} awkwardly pulls on the corset clinging to {user.his} waist. It's tougher without control of {user.his} arms."
		damage = calcDamage(_pc, _minigame, 0.8)
		stamina = RNG.randi_range(8, 15)
	elif(_armsFree):
		text = "{user.name} rubs {user.his} restricted hands against the corset, trying to unstick it, but it's glued to {user.him} rather firmly."
		damage = calcDamage(_pc, _minigame, 0.4)
		stamina = RNG.randi_range(10, 15)
	else:
		text = "{user.name} shimmies and shakes, trying to make the glued-on corset fall off. It's not very effective."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = RNG.randi_range(12, 18)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(failChance(_pc, 10) || _isActivelyStruggling):
		_pc.coverBodyWithFluid("BlackGoo", RNG.randf_range(20.0, 50.0))
		return {"text": "The corset dribbles warm goo on {user.name}", "lust": scaleDamage(2)}
