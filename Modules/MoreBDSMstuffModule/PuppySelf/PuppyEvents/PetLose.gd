extends EventBase

func _init():
	id = "PetLose"

func registerTriggers(es):
	es.addTrigger(self, Trigger.AfterSexWithDynamicNPCThatWon)

func run(_triggerID, _args):
	#print("hiiii")
	#добавить зависимость от отношений?
	if RNG.chance(5):
		runScene("PetWalkiesScene")

func getPriority():
	return 4
