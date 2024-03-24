extends Control

var graph = {}
var visited = []

func _ready():
	# initialize graph
	graph = {
		0 : [1, 3, 5],
		1 : [0, 2],
		2 : [1],
		3 : [0, 4],
		4 : [3],
		5 : []
	}
	
	# enable the first node (parent)
	_enableNode(get_child(0))
	
	# disable its chilren
	for n in range(1, get_child_count()):
		_disableNode(get_child(n))
	
	# examples
	_switchScreens(0, 1)
	_switchScreens(1, 2)
	
func _switchScreens(toDisableKey: int, toEnableKey: int):
	_disableNode(get_child(toDisableKey)) # disable "start" node
	visited = []
	_findTarget(toDisableKey, toEnableKey) 

# dfs algorithm since gdscript doesn't have a built-in queue type and i'm too lazy to do it myself :--)
func _findTarget(start: int, target: int):
	if (start == target):
		print("enabling node: " + str(target))
		_enableNode(get_child(target))
		return
	
	if start in visited:
		return
	
	visited.append(start)
	
	for n in graph[start]:
		_findTarget(n, target)

func _enableNode(node: Node):
	node.visible = true
	node.set_process(true)
	node.set_process_input(true)
	
func _disableNode(node: Node):
	node.visible = false
	node.set_process(false)
	node.set_process_input(false)
