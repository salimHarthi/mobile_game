extends Node2D
class_name GameMap

onready var borders = $innerWals
export(float,0,1) var prob_of_getting_tile = 0.06
onready var good = preload("res://tiles/good.tscn")
onready var denger_blocs = preload("res://tiles/denger_blocs.tscn")
onready var boost_blocs = preload("res://tiles/boost.tscn")
onready var player = $player
onready var player_params = $player_params

export(int) var max_number_of_good =3
export(int) var max_number_of_denger = 10
var _points_collected = 0
var rng = RandomNumberGenerator.new()

export(Resource) var playerState

var CellSize = Vector2(64,64)
var width = int(720/CellSize.x)
var height = (1280/CellSize.y)-2
var grid = []
var goodArray = []
var Tiles = {
	"empty": -1,
	"borders": 0,
	"bad":1,
	"boost":2,
	"good":3
}

signal on_send_score(val)
signal _on_end_game(v_scor,v_time,won_lose)
signal _on_end_game_start()
func _init_grid():
	grid = []
	for x in width:
		grid.append([])
		for y in (height):
			grid[x].append(-1);

	for x in width:
		grid[x].remove(0)
		grid[x].push_front(-2)

func GetRandomDirection():
	var directions = [[-1, 0], [1, 0], [0, 1], [0, -1]]
	var direction = directions[rng.randi()%4]
	return Vector2(direction[0], direction[1])
	
func _create_random_path():
	var max_iterations = 1000
	var itr = 0
	
	var walker = Vector2.ZERO
	
	while itr < max_iterations:
		
		# Perform random walk
		# 1- choose random direction
		# 2- check that direction is in bounds
		# 3- move in that direction
		var random_direction = GetRandomDirection()
		
		if (walker.x + random_direction.x >= 0 and 
			walker.x + random_direction.x < width and
			walker.y + random_direction.y >= 0 and
			walker.y + random_direction.y < height):
				
				walker += random_direction
				if grid[walker.x][walker.y]==-1:
					if prob_of_getting_tile >= randf():
						grid[walker.x][walker.y] = Tiles.borders
				itr += 1
				
				
func _spawn_tiles():
	
	for x in width:
		for y in height:
			match grid[x][y]:
				Tiles.empty:
					pass
				Tiles.borders:
					borders.set_cellv(Vector2(x, y), (randf() * (3-0)) + 0)
		
		
func _clear_tilemaps():
	for x in width:
		for y in height:
			borders.clear()
  
	borders.update_bitmask_region()

func _spown_good():
	var count = 0
	var walker = Vector2(randi() % 101, randi() % 101)

	while count < max_number_of_good:

		if (walker.x >= 0 and 
			walker.x < width and
			walker.y >= 0 and
			walker.y < height):
				if grid[walker.x][walker.y]==-1:
					goodArray.append(walker)
					var b = good.instance()
					b.connect('_on_get_a_point', self, '_on_get_a_point_s')
					b.connect('_on_get_a_point', $scoreBord, '_on_get_a_point_handel')
					self.connect('on_send_score', $CanvasLayer/score, '_on_send_score_handel')
					b.global_position = (walker*CellSize)+(CellSize/2)
					add_child(b)
					borders.set_cellv(b.global_position, -1)
					count+=1
					grid[walker.x][walker.y] = Tiles.good
		walker = Vector2(randi() % 101, randi() % 101)
		
func _spown_denger():
	var count = 0
	var walker = Vector2(randi() % 101, randi() % 101)

	while count < max_number_of_denger:

		if (walker.x >= 0 and 
			walker.x < width and
			walker.y >= 0 and
			walker.y < height and !(walker in goodArray)):
				if grid[walker.x][walker.y]==-1:
					var b = denger_blocs.instance()
					b.global_position = (walker*CellSize)+(CellSize/2)
					b.connect('_on_end_game', $scoreBord, '_show_game_end')
					b.connect('_on_end_game', self, '_on_end_game_handeler')
					add_child(b)
					borders.set_cellv(b.global_position, -1)
					count+=1
					grid[walker.x][walker.y] = Tiles.bad
		walker = Vector2(randi() % 101, randi() % 101)

func _spown_boost():
	var count = 0
	var walker = Vector2(randi() % 101, randi() % 101)
	var max_number_boost = (randf() * (6-1)) + 1
	while count < max_number_boost:

		if (walker.x >= 0 and 
			walker.x < width and
			walker.y >= 0 and
			walker.y < height):
				if grid[walker.x][walker.y]==-1:
					goodArray.append(walker)
					var b = boost_blocs.instance()
					b.connect('_on_get_boost', self, '_on_get_boost_handler')
					b.connect('_on_get_boost', player, '_on_get_boost_handler')
					b.connect('_on_get_boost', player_params, '_on_get_boost_handler')
					b.global_position = (walker*CellSize)+(CellSize/2)
					add_child(b)
					borders.set_cellv(b.global_position, -1)
					count+=1
					grid[walker.x][walker.y] = Tiles.boost
		walker = Vector2(randi() % 101, randi() % 101)
func _ready():
	$CanvasLayer/scoreBord.hide()
	rng.randomize()
	_init_grid()
	#_clear_tilemaps()
	_create_random_path()
	_spawn_tiles()
	_spown_denger()
	_spown_boost()
	_spown_good()
	emit_signal("_on_end_game_start")






func _on_get_a_point_s():
	_points_collected +=1
	emit_signal('on_send_score',_points_collected)
	if _points_collected ==max_number_of_good:
		var totalScore =str(_points_collected)+"/"+str(max_number_of_good)
		emit_signal("_on_end_game",totalScore,$CanvasLayer/timerText.time,'Won')
		get_tree().paused=true


func _on_end_game_handeler():
	var totalScore =str(_points_collected)+"/"+str(max_number_of_good)
	emit_signal("_on_end_game",totalScore,$CanvasLayer/timerText.time,'Lost')
	get_tree().paused=true

func _on_get_boost_handler():
	print(playerState.boosts)



func _on_player__on_player_stoped():
	if playerState.boosts == 0:
		var totalScore =str(_points_collected)+"/"+str(max_number_of_good)
		emit_signal("_on_end_game",totalScore,$CanvasLayer/timerText.time,'Lost')
