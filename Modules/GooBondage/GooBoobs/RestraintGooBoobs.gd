extends RestraintData
class_name RestraintGooBoobs

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = "GooBoobs"

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
		text = "{user.name} feebly tries to peel off the goo boobs, but they end up firmly glued on. {user.His} nips are treated to a renewed tightness pressing into them."
		damage = -1.0
		stamina = RNG.randi_range(10, 15)
		lust = scaleDamage(8)
	elif(_handsFree && _armsFree):
		text = "{user.name} tugs on the goo clinging to {user.his} chest, trying to peel it off."
		damage = calcDamage(_pc, _minigame)
		stamina = RNG.randi_range(5, 10)
		if(failChance(_pc, 30)):
			text += " {user.His} groping transfers through to {user.his} nips."
			lust = scaleDamage(4)
	elif(_handsFree):
		text = "{user.name} awkwardly grabs the goo clinging to {user.his} chest. Though it's harder without control of {user.his} arms, {user.he} {user.verbS('give')} it a good pull."
		damage = calcDamage(_pc, _minigame, 0.8)
		stamina = RNG.randi_range(5, 10)
		if(failChance(_pc, 45)):
			text += " {user.His} groping transfers through to {user.his} nips."
			lust = scaleDamage(4)
	elif(_canBite):
		text = "{user.name} tries biting onto the goo boobs to rip them off. {user.He} {user.verbS('find')} {user.himself} oddly aroused by the goo's flavor."
		damage = calcDamage(_pc, _minigame, 0.7)
		stamina = RNG.randi_range(5, 10)
		lust = scaleDamage(6)
		if(failChance(_pc, 10)):
			text += " Ouch! {user.He} accidentally bit {user.himself}."
			pain = scaleDamage(6)
	elif(_armsFree):
		text = "{user.name} presses {user.his} arms into {user.his} chest, trying to dislodge the goo boobs. This lewd display is relatively ineffective."
		damage = calcDamage(_pc, _minigame, 0.6)
		stamina = RNG.randi_range(5, 10)
		lust = scaleDamage(4)
	else:
		text = "{user.name} shakes {user.his} torso, trying to make the goo boobs unstick. This does little other than jostle {user.his} encased nipples."
		damage = calcDamage(_pc, _minigame, 0.3)
		stamina = RNG.randi_range(5, 15)
		lust = scaleDamage(6)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}
