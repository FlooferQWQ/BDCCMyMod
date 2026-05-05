extends EventBase

func _init():
	id = "PetForseRandomRestraints"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)
	#es.addTrigger(self, Trigger.Waiting)

func run(_triggerID, _args):
	var npcs = GM.main.IS.getPawnIDsAt(_args[0])
	
	#print(role.npcCharacterType)
	#print(npcs[RNG.pick(npcs)], "!!!")
	#print(_args,"!")
	if getModuleFlag("BDSMstuff", "PetWalk") and npcs.size() > 1:
		if getModuleFlag("BDSMstuff", "PetWalkEventCooldown", 0) > 0:
			increaseModuleFlag("BDSMstuff", "PetWalkEventCooldown", -1)

		elif(npcs.size() > 1):
			#var role = GM.main.getCharacter(npcs[0]).npcCharacterType
			GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, 1)
			setModuleFlag("BDSMstuff", "PetWalkEventCooldown", 5)
	#print(_args)
	#if getModuleFlag("BDSMstuff", "PetWalk") == true:# and GM.pc.getInventory().getAmountOfRestraintsThatCanForceDuringSex(ItemTag.BDSMRestraint) <= 0:
	#	if RNG.chance(30):
	#		GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, 2)
			#saynn(str(role) + ":"+" Oh, what a cutie! I think I have something for you!")
			saynn("Someone put restraints on you!")
			#var npcName = GM.main.getCharacter(npcs[RNG])
			#saynn(str(role) + ":"+" Looks great, see ya!")
