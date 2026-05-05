extends "res://Scenes/SceneBase.gd"

var pawnID:String = ""

func _init():
	sceneID = "PetLookingAroundScene"

func _run():
	if(state == ""):
		setCharactersEasyList(GM.main.IS.getPawnIDsAt(GM.pc.getLocation()))
		
		saynn("Here is what's happening around you:")
		addButtonAt(14, "Back", "Enough looking around", "endthescene")
		
		var pcLoc:String = GM.pc.getLocation()
		var allPawns:Array = GM.main.IS.getPawnsAt(pcLoc)
		
		for pawnA in allPawns:
			var pawn:CharacterPawn = pawnA
			if(pawn.isPlayer()):
				continue
			var character:BaseCharacter = pawn.getCharacter()
			pawnID = pawn.charID
			
			var interaction:PawnInteractionBase = pawn.getInteraction()
			
			if(interaction == null):
				sayn("{pawn.name} is not doing anything.")
			else:
				sayn(interaction.getPreviewLineForPawn(pawn))
			
			addButton(character.getName(), "Focus your attention on this person", "focus", [pawn])
		
		pawnID = ""

	if(state == "focus"):
		var pcPawn:CharacterPawn = GM.main.IS.getPawn("pc")
		addButtonAt(14, "Back", "Go back to the previous menu", "")
		var pawn:CharacterPawn = GM.main.IS.getPawn(pawnID)
		
		if(pawn == null):
			saynn("Pawn not found, sorry.")
			#addButton("Back", "Enough spying", "")
			return
			
					
		var interaction:PawnInteractionBase = pawn.getInteraction()
		if(interaction == null):
			saynn("{pawn.name} is not doing anything right now.")
			return
		
		#saynn("{pawn.name} is in a "+interaction.id+" interaction")
		if(interaction.getCurrentActionText() != ""):
			saynn(interaction.getCurrentActionText())
		
		interaction.playAnimation()
		saynn(interaction.getOutputTextFinal())
		
		if(pcPawn == null):
			return
		
		addButton("Talk", "", "talk", pawn)

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "focus"):
		pawnID = _args[0].charID

	if(_action == "talk"):
		endScene()
		runScene("Pet", [pawnID])
		
		return


	setState(_action)

func resolveCustomCharacterName(_charID):
	if(_charID == "pawn" && pawnID != ""):
		return pawnID
	
	var pawn:CharacterPawn = GM.main.IS.getPawn(pawnID)
	if(pawn == null):
		return .resolveCustomCharacterName(_charID)
	var interaction:PawnInteractionBase = pawn.getInteraction()
	if(interaction == null):
		return .resolveCustomCharacterName(_charID)

	if(interaction.involvedPawns.has(_charID)):
		return interaction.involvedPawns[_charID]
	return .resolveCustomCharacterName(_charID)

func isSpyingOnInteractionsWith(_charID:String):
	if(_charID == pawnID):
		return true
	return false

func saveData():
	var data = .saveData()
	
	data["pawnID"] = pawnID

	return data
	
func loadData(data):
	.loadData(data)
	
	pawnID = SAVE.loadVar(data, "pawnID", "")

func supportsShowingPawns() -> bool:
	return true
