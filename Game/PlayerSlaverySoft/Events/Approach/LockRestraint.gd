extends NpcOwnerEventBase

var pickedLocks:Array = []
var pickedLock:String = ""

func _init():
	id = "LockRestraint"
	reactsToTags = [E_APPROACH]
	eventMinLevel = 0
	eventWeight = 0.25
	eventTagWeightOverrides = {NOET.BDSM: 1.0}

func trySubEventStart(_event, _tag:String, _args:Array, _context:Dictionary) -> bool:
	var npcOwner := getNpcOwner()
	if(npcOwner.hasOwnerLock()):
		return false
	var allPossible := getPossibleLocks()
	if(allPossible.empty()):
		return false
	
	var theLevel := npcOwner.getLevel()
	var maxOfferLocks:int = 2
	if(theLevel >= 2):
		maxOfferLocks = 3
	if(theLevel >= npcOwner.getMaxLevel()):
		maxOfferLocks = 99
	
	while(maxOfferLocks > 0 && !allPossible.empty()):
		pickedLocks.append(RNG.grab(allPossible))
		maxOfferLocks -= 1
	
	return true

func getPossibleLocks() -> Array:
	var possible:Array = []
	if(!GM.pc.isMuzzled() && !GM.pc.isBitingBlocked() && !GM.pc.isGagged()):
		possible.append("ringgag")
	#if(!GM.pc.isMuzzled() && !GM.pc.isBitingBlocked() && !GM.pc.isGagged() && GlobalRegistry.getModules().has("GooBondage")):
	#	possible.append("goomask")
	if(!GM.pc.isBlindfolded()):
		possible.append("hypnovisormk1")
	if(!GM.pc.hasBlockedHands()):
		possible.append("mittens")
	if(!GM.pc.hasBlockedHands() && GlobalRegistry.getModules().has("BDSMstuff")):
		possible.append("longlatexmittens")
	if(!GM.pc.hasBoundArms()):
		possible.append("arms")
	if(!GM.pc.hasBoundLegs()):
		possible.append("legs")
	if(!GM.pc.isWearingChastityCage() && GM.pc.hasReachablePenis()):
		possible.append("cage")
		possible.append("cageflat")
		possible.append("cageadvanced")
	if(!GM.pc.isBodypartCovered(BodypartBody) && GlobalRegistry.getModules().has("PuppyRestraintsMod")):
		possible.append("puppySuit")
		
	return possible

func getLockNameDesc(_lock:String) -> Array:
	if(_lock == "ringgag"):
		return ["Ring-gag", "Agree to be gagged"]
	if(_lock == "goomask"):
		return ["Goo mask", "Agree to wear goo mask"]
	if(_lock == "hypnovisormk1"):
		return ["Hypnovisor", "Agree to wear hypnovisor"]
	if(_lock == "mittens"):
		return ["Mittens", "Agree to wear bondage mittens"]
	if(_lock == "longlatexmittens"):
		return ["Long latex mittens", "Agree to wear long latex mittens"]
	if(_lock == "arms"):
		return ["Wrist cuffs", "Agree to have your arms cuffed"]
	if(_lock == "legs"):
		return ["Ankle cuffs", "Agree to have your legs cuffed"]
	if(_lock == "cage"):
		return ["Chastity cage", "Agree to have your cock caged"]
	if(_lock == "cageflat"):
		return ["Flat chastity cage", "Agree to have your cock caged with a flat cage"]
	if(_lock == "cageadvanced"):
		return ["Advanced chastity cage", "Agree to have your cock caged with an advanced cage"]
	if(_lock == "puppySuit"):
		return ["Puppy Restraints", "Agree to wear puppy restraints"]
		
	return ["ERROR?", "Something went wrong"]

func getHumanReadablePossibleListString() -> String:
	var thePossible:Array = []
	for theLock in pickedLocks:
		thePossible.append(getLockNameDesc(theLock)[0].to_lower())
	return Util.humanReadableList(thePossible)
	
func start():
	Log.print("BDSMstuff found = "+str(GlobalRegistry.getModules().has("BDSMstuff"))+" / GooBondage found = "+str(GlobalRegistry.getModules().has("GooBondage"))+"\nBodyPart Body free = "+ str(!GM.pc.isBodypartCovered(BodypartBody))+" / PuppyRestraintsMod found = "+str(GlobalRegistry.getModules().has("PuppyRestraintsMod")))
	playStand()
	
	saynn("{npc.name} approaches you.. "+("holding a few items." if pickedLocks.size() > 1 else "holding something."))
	talkModularOwnerToPC("SoftSlaveryLockRestraint") # Today I feel like locking something onto you
	saynn("{npc.He} {npc.verb('show')} "+str(pickedLocks.size())+" thing"+("s" if pickedLocks.size() != 1 else "")+": "+getHumanReadablePossibleListString()+".")
	talkModularOwnerToPC("SoftSlaveryLockRestraint2") # Which one do you like the most, I'm generous enough to let you choose
	saynn("Looks like you must choose something..")
	
	addButton("Resist!", "You don't wanna be restrained!", "resist")
	
	for theLock in pickedLocks:
		var theLockInfo:Array = getLockNameDesc(theLock)
		addButton(theLockInfo[0], theLockInfo[1], "pickLock", [theLock])

func start_do(_id:String, _args:Array):
	if(_id == "resist"):
		runResist()
	if(_id == "pickLock"):
		pickedLock = _args[0]
		
		var theItem:ItemBase
		
		if(pickedLock == "ringgag"):
			theItem = GlobalRegistry.createItem("ringgag")
		elif(pickedLock == "goomask"):
			theItem = GlobalRegistry.createItem("goomask")
		elif(pickedLock == "hypnovisormk1"):
			theItem = GlobalRegistry.createItem("HypnovisorMk1")
		elif(pickedLock == "mittens"):
			theItem = GlobalRegistry.createItem("bondagemittens")
		elif(pickedLock == "longlatexmittens"):
			theItem = GlobalRegistry.createItem("Long latex mittens")
		elif(pickedLock == "arms"):
			theItem = GlobalRegistry.createItem("inmatewristcuffs")
		elif(pickedLock == "legs"):
			theItem = GlobalRegistry.createItem("inmateanklecuffs")
		elif(pickedLock == "cage"):
			theItem = GlobalRegistry.createItem("ChastityCage")
		elif(pickedLock == "cageflat"):
			theItem = GlobalRegistry.createItem("ChastityCageFlat")
		elif(pickedLock == "cageadvanced"):
			theItem = GlobalRegistry.createItem("ChastityCageAdvanced")
		elif(pickedLock == "puppySuit"):
			theItem = GlobalRegistry.createItem("puppy_restraints")
			
		if(theItem):
			GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(theItem)
			theItem.addSmartLock(SmartLock.KeyholderLock, getOwner())
		
		var theNpcOwner := getNpcOwner()
		if(theNpcOwner):
			theNpcOwner.setMustHaveOwnerLock(true)
		setState("afterLocked")

func afterLocked():
	if(pickedLock in ["cage", "cageflat", "cageadvanced"]):
		playAnimation(StageScene.Duo, "stand", {npc=getOwnerID(), bodyState={naked=true}})
	else:
		playStand()
	
	saynn("You obey and let {npc.name} lock the "+getLockNameDesc(pickedLock)[0].to_lower()+" onto you!")
	saynn("After that, {npc.he} {npc.verb('show')} you the key..")
	talkModularOwnerToPC("SoftSlaveryLockRestraint3") # I will keep the key. Don't try to struggle it off, {npc.npcSlave}.
	addContinue("endEvent")

func saveData() -> Dictionary:
	var data := .saveData()
	
	data["pickedLocks"] = pickedLocks
	data["pickedLock"] = pickedLock
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	pickedLocks = SAVE.loadVar(_data, "pickedLocks", [])
	pickedLock = SAVE.loadVar(_data, "pickedLock", "")
