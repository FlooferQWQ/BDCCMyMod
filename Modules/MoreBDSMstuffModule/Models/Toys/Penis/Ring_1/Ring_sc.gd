extends MeshInstance

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var doll:Spatial
var character
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var Part3D = load("res://Player/Player3D/Parts/Part3D.gd")
	var theNode:Node = self
	
	while !(theNode is Part3D):
		var previousNode = theNode.get_node("..")
		if (previousNode == null || previousNode is Doll3D ):
			break
		if previousNode is Part3D:
			doll = previousNode.getDoll()
		theNode = previousNode
		
	var ch = doll.getCharacterID()
	#print(ch)
	if(ch == null || ch == ""):
		return null
	character = (GlobalRegistry.getCharacter(ch))
	#print(character)
	if character.getArousal() >= 0.95:
		character.setArousal(0.7)
		
func _process(_delta):
	var ch = doll.getCharacterID()
	if(ch == null || ch == ""):
		return null
	character = (GlobalRegistry.getCharacter(ch))

	if character.getArousal() >= 0.95:
		character.setArousal(0.7)
