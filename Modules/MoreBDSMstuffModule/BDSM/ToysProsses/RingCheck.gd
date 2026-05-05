extends EventBase

var sexEngineRef: WeakRef
var panties = null

func _init():
	id = "Ring_check"
	

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)
	es.addTrigger(self, Trigger.Waiting)
	es.addTrigger(self, Trigger.WakeUpInCell)
	es.addTrigger(self, Trigger.TakingAShower)

	es.addTrigger(self, Trigger.SceneAndStateHook, ["GenericSexScene", ""])
	
func run(_triggerID, _args):
	#print(_args, "lol")
	
	var _npc = getModuleFlag("BDSMstuff","Ring_npc")

	if getModuleFlag("BDSMstuff","Ring_npc") != null :
		if getCharacter(_npc).getInventory().hasItemIDEquipped("Cockring"):
			ArousalConst(getCharacter(_npc))
		else:
			setModuleFlag("BDSMstuff","Ring_npc", null)

	#if getFlag("Ring_pc") == true:
	if GM.pc.getInventory().hasItemIDEquipped("Cockring"):
			ArousalConst(GM.pc)
	else:
			setModuleFlag("BDSMstuff","Ring_pc", false)
	return

func ArousalChange(_character, _arg):
	_character.addArousal(_arg)
	
func ArousalConst(_character):
	if _character.getArousal() >= 0.80:
		_character.setArousal(0.7)
		#runScene("SipmleScene")

		#_character.sendSexEvent("Orgasmed")
		#.satisfyGoals()
		#var shit: = GM.main.getCurrentScene()
		

		#print()#.satisfyGoals()
		#SexActivityBase.satisfyGoals()
		

