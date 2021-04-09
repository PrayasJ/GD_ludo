extends Node

var colour = ['red','green','yellow','blue']
var c = ['r','g','y','b']
var curr = 'r'
var pieces = {}
var selected = null
var r1 = 0
var r2 = 0
var p2

func get_next(p1):
	if r1 == 0: return
	var area = p1[0]
	var idx = p1.right(1)
	if area == 's':
		if r1 == 6:
			return selected[0]+'0'
		else:
			return null
	elif area =='h':
		if r1 == 6:
			return null
		elif int(idx)+r1 < 5:
			return area + str(int(idx)+r1)
		elif int(idx)+r1 == 5:
			return 'done'
		else:
			return null
	else:
		idx = int(idx) + r1 + r2
		if idx > 12:
			area = c[(c.find(area)+1)%4]
		return area + str(idx%13)

func _ready():
	$dice.connect('roll',self,'_roll')
	for x in range(4):
		var block = get_node(c[x])
		block.show()
		for i in range(1,5):
			var child = get_node(c[x]+'/'+c[x]+str(i))
			var pos = get_node('board/'+colour[x]+'/s'+str(i))
			child.connect('chosen_one',self,'_chosen_one')
			child.set_id(c[x]+str(i))
			pieces[c[x]+str(i)] = 's'+str(i)
			child.position = pos.global_position
			#pass

func _chosen_one(x):
	if x[0] == curr:
		selected = x
		x = pieces[selected]
		p2 = get_next(x)
		if p2 == 'done':
			get_node(x[0]+'/'+selected).hide()
			pieces[selected] = p2
			$move.hide()
		elif p2 == null:
			$move.hide()
		else:
			$move.show()
			$move.position = get_node('board/'+colour[c.find(p2[0])]+'/p'+p2.right(1)).global_position

func _roll(r):
	r1 = int(r)
	r2 = 0


func _on_pos_pressed():
	var child = get_node(selected[0]+'/'+selected)
	pieces[selected] = p2
	child.position = get_node('board/'+colour[c.find(p2[0])]+'/p'+p2.right(1)).global_position
	$move.hide()
	$dice.allow()
