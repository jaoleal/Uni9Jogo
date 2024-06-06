extends Node2D



#This node is the root node, has the job of
#handle attack, defense and movement of the troops
#Phase logic (Telling its childs which phase the game is)
#Bounderies logic (Which terrotiory can attack)
#this is a const dictionary that tells the Father node if
#a territory can attack another
#
# TERRITORY_NAME : ["TERRITORY_THAT_I_CAN_ATTACK", "ANOTHER_TERRITORY_THAT_I_CAN_ATTACK"]
#
const BOUNDERS  = {
	"Russia": ["Japon","Pitor","China","Chitan","Moscou","Suecia","Fraco","Mongao"],
	"Japon": ["China","Russia"],
	"Mongao": ["China","Chita","Russia"],
	"Pitor": ["Russia"],
	"Vietna": ["India","China"],
	"Varal": ["India","Oriente","Fraco"],
	"India": ["Varal","Vietna","China","Moscou","Chita"],
	"Moscou":["Chita","India","Russia","Fraco","Oriente","Varal"],
	"Suecia":["Fraco","Russia"],
	"Renegon":["Fraco","Oriente","Polonia"],
	"Polonia":["Renegon"],
	"Fraco": ["Suecia","Moscou","Russia","Renegon","Oriente","Varal","India"]
	}

#To store the phase of the round
enum PHASE {DEPLOY, ATTACK, REORG}
#	Deploy: is the phase where you can place new troops
#	Attack: the attack phase, when troops can battle(The only phase where the total of troops of a player can go down)
#	Reorg: To move the troops that are already in battle.

#To store some mocking players
onready var player1 = load("res://scripts/player.gd").new()
onready var player2 = load("res://scripts/player.gd").new()

#variables
onready var running_phase = PHASE.DEPLOY
onready var selected = false
onready var selected_territory = "None"
onready var attacking_territory = "None"
onready var active_p = player1

#Nodes
onready var Continents =  get_node("LiveLayer").get_children()

#Signals
signal new_phase(phase)

var rng = RandomNumberGenerator.new()

func _ready():
	player1.uid = 0
	player1.name = "D"
	player1.color = Color.white
	
	player2.uid = 1
	player2.name = "C"
	player2.color = Color.orange
	
	change_phase(PHASE.ATTACK)
	for cont in Continents:
		self.connect("new_phase", cont,"_on_new_phase")
		cont.connect("Territory_selected", self,"_on_Territory_selected")
		cont.connect("Territory_unselected", self,"_on_Territory_unselected")
		var Ters = cont.get_territories()
		for T in Ters:
			
			T.set_troops(rng.randi_range(3, 7))

func _process(delta):
	pass

func change_phase(P):
	running_phase = P
	emit_signal("new_phase", P)

func _on_Territory_selected(T):
	if running_phase == PHASE.ATTACK and selected:
		attacking_territory = selected_territory
		selected_territory = T
	else:
		selected_territory = T
	selected = true

func _on_Territory_unselected(T):
	if running_phase != PHASE.ATTACK:
		selected_territory = "None"
		selected = false
	elif running_phase == PHASE.ATTACK and selected:
		if not can_attack(selected_territory,T):
			selected_territory = "None"
			selected = false
	else:
		print("Pato")
#Territory to attack
# A = Attacker:  name of the territory
# T = Target:  name of the territory
func can_attack(Attacker: String, Target: String):
	if BOUNDERS.has(Attacker):
		var a = BOUNDERS.get(Attacker)
		return a.has(Target)
	print(Attacker)
	return false
