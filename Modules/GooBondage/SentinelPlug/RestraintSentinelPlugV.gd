extends RestraintData
class_name RestraintSentinelPlugV

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = RestraintType.VaginalPlug
	sexReaction = SexReaction.BondageVaginalPlug

func canUnlockWithKey():
	return false

func alwaysSavedWhenStruggledOutOf():
	return true

func shouldDoStruggleMinigame(_pc):
	var _handsFree = !_pc.hasBlockedHands()
	if(_handsFree):
		return false
	return .shouldDoStruggleMinigame(_pc)

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
	
	if(failChanceLowScore(_pc, 20, _minigame)):
		text = "{user.name} clenches, attempting to push the plug out. Instead, {user.his} efforts cause it to [b]slide deeper[/b], the plug nestling snugly against {user.his} vaginal walls. It also releases a strong jolt and load of goo deep inside {user.him}."
		damage = -0.5
		lust = scaleDamage(10)
		pain = scaleDamage(10)
		_pc.getBodypart(BodypartSlot.Vagina).addFluidOrifice("BlackGoo", RNG.randf_range(80.0, 150.0))
	elif(_handsFree && _armsFree):
		text = "Because {user.name}'s hands are free, {user.he} {user.verbS('ease')} the plug out with little effort."
		damage = 1.0
		lust = scaleDamage(4)
	elif(_legsFree):
		text = "{user.name} squirms and wiggles {user.his} hips, trying to push the plug out of {user.his} vagina."
		damage = calcDamage(_pc, _minigame, 0.9)
		stamina = RNG.randi_range(5, 7)
		lust = scaleDamage(5)
	else:
		text = "{user.name} desperately squirms, trying to make the plug fall out. Not being able to spread {user.his} legs makes it very hard."
		damage = calcDamage(_pc, _minigame, 0.5)
		stamina = RNG.randi_range(10, 12)
		lust = scaleDamage(5)
	
	if(damage < 1.0 && !(_handsFree && _armsFree)):
		if(_pc.isPlayer() && failChance(_pc, 60) && _pc.getInventory().hasSlotEquipped(InventorySlot.UnderwearBottom)):
			if(_pc.getInventory().getEquippedItem(InventorySlot.UnderwearBottom).coversBodypart(BodypartSlot.Anus)):
				text += " The plug presses into your underwear."
				damage /= 2.0
				
				if(failChance(_pc, 20)):
					text += " [b]Your underwear slipped down, oops.[/b]"
					_pc.getInventory().unequipSlot(InventorySlot.UnderwearBottom)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(failChance(_pc, 20)):
		_pc.getBodypart(BodypartSlot.Vagina).addFluidOrifice("BlackGoo", RNG.randf_range(30.0, 50.0))
		return {"text": "The Sentinel plug pumps a load of goo into {user.name}'s pussy", "lust": scaleDamage(6)}
	elif(failChance(_pc, 40)):
		return {"text": "The Sentinel plug vibrates intensely inside {user.name}'s vagina", "lust": scaleDamage(9)}
	elif(failChance(_pc, 40)):
		return {"text": "The Sentinel plug suddenly zaps {user.name}'s vaginal walls!", "lust": scaleDamage(3), "pain": scaleDamage(6)}
	elif(failChance(_pc, 20) || _isActivelyStruggling):
		return {"text": "The Sentinel plug shifts inside {user.name} while {user.he} {user.verbS('squirm')}", "lust": scaleDamage(5)}
