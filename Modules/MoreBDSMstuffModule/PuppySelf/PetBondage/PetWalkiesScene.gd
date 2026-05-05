extends SceneBase

#var npcID = ""
#var npc:DynamicCharacter

#var walkiesType = ""
var usable_locations = ["main_stairs1", "main_stairs2", "CBStairs1", "CBStairs2", "gym_secret", "fight_entrance","FightClubRoom"]
var action_locations = ["MedRoom2","hall_canteen","main_hallroom1","main_shower1","main_shower2","main_green_corridor7","hall_elevator","main_laundry"]

func _init():
	sceneID = "PetWalkiesScene"

func _initScene(_args = []):
	
	var item = GM.pc.getInventory().getItemByUniqueID(_args[0])
	GM.pc.getInventory().removeItem(item)
	GM.pc.getInventory().equipItem(item)
	#if _args:
		#Вы не сможете снять это самостоятельно. Стоит попросить помощи или всё же найти его. Впрочем здесь не так много мест куда можно пойти. И так где же он? камеры, площадка или зал?
		#saynn("")
		#setModuleFlag("BDSMstuff","PetWalkForsed",true)
	setModuleFlag("BDSMstuff","PetWalk",true)
	setModuleFlag("BDSMstuff", "PetWalkEventCooldown", 3)
	playAnimation(StageScene.PuppySolo, "stand")

func _run():
	if !GM.pc.getInventory().hasItemIDEquipped("bitchsuit"):
		playAnimation(StageScene.Solo, "stand")
		GM.pc.getInventory().addItemID("bitchsuit")
		setModuleFlag("BDSMstuff","PetWalk",false)
		endScene()
		return
		
	if getModuleFlag("BDSMstuff","PetWalk") == false:
		playAnimation(StageScene.Solo, "stand")
		GM.pc.getInventory().removeEquippedItem("bitchsuit")
		GM.pc.getInventory().addItemID("bitchsuit")
		endScene()
		return
	if(state == ""):
		
		var roomID = GM.pc.location
		var _roomInfo = GM.world.getRoomByID(roomID)
		print(roomID)
		aimCamera(roomID)
		
		if(GM.world.canGoID(roomID, GameWorld.Direction.NORTH)):
			addButtonAt(6, "North", "Go north", "go", [GameWorld.Direction.NORTH, Direction.North])
		else:
			addDisabledButtonAt(6, "North", "Can't go north")
			
		if(GM.world.canGoID(roomID, GameWorld.Direction.WEST)):
			addButtonAt(10, "West", "Go west", "go", [GameWorld.Direction.WEST, Direction.West])
		else:
			addDisabledButtonAt(10, "West", "Can't go west")
			
		if(GM.world.canGoID(roomID, GameWorld.Direction.SOUTH)):
			addButtonAt(11, "South", "Go south", "go", [GameWorld.Direction.SOUTH, Direction.South])
		else:
			addDisabledButtonAt(11, "South", "Can't go south")
		
		if(GM.world.canGoID(roomID, GameWorld.Direction.EAST)):
			addButtonAt(12, "East", "Go east",  "go", [GameWorld.Direction.EAST, Direction.East])
		else:
			addDisabledButtonAt(12, "East", "Can't go east")
		
		if(GM.main.IS.hasPawnsAtIgnorePC(roomID)):
			addButtonAt(7, "Look around", "See what's happening around you", "look_around")
			setCharactersEasyList(GM.main.IS.getPawnIDsAt(roomID))
			#print(GM.main.IS.hasPawnsAtIgnorePC(roomID))
			#print(setCharactersEasyList(GM.main.IS.getPawnIDsAt(roomID)))
		
		if(GM.pc.getInventory().hasRemovableRestraints()):		
			if GM.pc.hasPerk("BDSMInstantEscape"):
				addButtonAt(8, "Struggle", "Struggle against your restraints", "struggle")
			else:
				addDisabledButtonAt(8, "Struggle", "You are completely tied!")
			
		addButtonAt(9, "Me", "Shows actions related to you and also your personal information", "me")
		addDisabledButtonAt(13, "Tasks", "Not time for this!")
		#addButtonAt(13, "Return to cell", "Enough wandering around with your slave", "return_to_cell")
		addDisabledButtonAt(14, "Inventory", "You are completely tied!")
		
		#if usable_locations.has(_roomInfo.get_name()):
		#_roomInfo._onPreEnter()
		setLocationName(_roomInfo.getName())
		
		if(GM.pc.isBlindfolded() && !GM.pc.canHandleBlindness()):
			saynn(_roomInfo.getBlindDescription())
		else:
			saynn(_roomInfo.getDescription())
			
		var roomMemory = GM.main.getRoomMemory(roomID)
		if(roomMemory != null && roomMemory != ""):
			saynn("[i]"+roomMemory+"[/i]")
		
		#print(_roomInfo.get_name())
		#print(roomID, "ID")
		#print(usable_locations.has(_roomInfo.get_name()))
		_roomInfo._onEnter()
		if action_locations.has(roomID):
			roomActions(roomID)
		if usable_locations.has(roomID):
			GM.ES.triggerRun(Trigger.EnteringRoom, [GM.pc.location]) #[GM.pc.location])
		if (GM.main.IS.hasPawnsAtIgnorePC(roomID)):
			GM.ES.triggerRun(Trigger.EnteringRoom,[GM.pc.location])
			
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	#if(_action == "escape_do_struggle"):
		#runScene("StrugglingScene", [true, false], "escape_struggle")
#		return
	#if(_action == "return_to_cell"):
		#processTime(5*60)
		#GM.pc.setLocation(GM.pc.getCellLocation())
		#setState("return_to_cell")
		#npc.getNpcSlavery().addTired(2.0)
		#return
	
	# RoomAction support
	#if(_action == "actionCallback"):
	#	var scenetorun = _args[0]
	#	runScene(scenetorun)
		
	# Scripted Room support
	if(_action == "roomCallback"):
		var roomid = _args[0]
		var keyid = _args[1]
		var _room = GM.world.getRoomByID(roomid)
		#if usable_locations.has(roomid):
		return _room._onButton(keyid)
	
	if(_action == "go"):
		var roomID = GM.pc.location
		var _roomInfo = GM.world.getRoomByID(roomID)
		playAnimation(StageScene.PuppySolo, "walk", {pcAction="walk", npcBodyState={naked=true}})
		processTime(60)
			
		GM.pc.setLocation(GM.world.applyDirectionID(GM.pc.location, _args[0]))
		aimCamera(GM.pc.location)
		#if action_locations.has(roomID):
		#	roomActions(roomID)
		if usable_locations.has(roomID):
			GM.ES.triggerRun(Trigger.EnteringRoom, [GM.pc.location]) #[GM.pc.location])
		GM.main.showLog()
			
	if(_action == "struggle"):
		runScene("StrugglingScene", [true, false])
	if(_action == "look_around"):
		runScene("PetLookingAroundScene")
	#if(_action == "me"):
	#	runScene("MeScene")
	if(_action == "canteen"):
		runScene("PetCanteenScene")
	
func roomActions(_roomID):
	print(_roomID,"2")
	
	if(_roomID == "hall_checkpoint"):
		return
		
	if(_roomID == "main_laundry"):
		playAnimation(StageScene.PuppySolo, "sit", {pcAction="sit", npcBodyState={naked=true}})
		saynn("You fully bound, but at least you can press buttons by your paws.")
		return
	#var action_locations = ["MedRoom2","hall_canteen","main_hallroom1","main_shower1","main_shower2","main_green_corridor7"]
	if(_roomID == "hall_canteen"):
		addDisabledButtonAt(0, "Eat", "In progress")
		#addButtonAt(0, "Eat", "Ask a treat.","canteen") #переписывает кнопку комнаты
		#PetCanteenScene
		return
	if(_roomID == "main_shower1"):
		addDisabledButtonAt(0, "Shower", "In progress")
		return
	if(_roomID == "main_shower2"):
		addDisabledButtonAt(0, "Shower", "In progress")
		return
	if(_roomID == "main_green_corridor7"):
		addDisabledButtonAt(0, "", "")
		return
	if(_roomID == "main_hallroom1"||"main_laundry"||"hall_elevator"||"MedRoom2"):
		playAnimation(StageScene.PuppySolo, "sit", {pcAction="sit", npcBodyState={naked=true}})
		saynn("You fully bound, but at least you can press buttons by your paws.")
		return

		
	return
func supportsShowingPawns() -> bool:
	return true

