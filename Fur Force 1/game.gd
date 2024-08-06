extends Node2D

var map_scene = preload("res://map.tscn")

var missions = [
	{
		"name": "Ace",
		"briefing": "Alright, team, there's been a break-in at the town bakery. The area needs to be secured, and clues must be gathered to find the culprit!"
	},
	{
		"name": "Ace",
		"briefing": "Listen up, everyone, we have a lost child near the amusement park. We need to coordinate with the park staff and make sure the child is reunited with their family!"
	},
	{
		"name": "Ace",
		"briefing": "Hey, team, there's a report of a stray dog causing trouble downtown. The dog needs to be located and brought safely to the animal shelter!"
	},
	{
		"name": "Ace",
		"briefing": "Heads up, team, someone reported suspicious activity near the bank. The area needs to be checked out and secured!"
	},
	{
		"name": "Ace",
		"briefing": "Team, a street vendor's cart tipped over, blocking the sidewalk. We need to clear the sidewalk and assist the vendor with clean-up!"
	},
	{
		"name": "Ace",
		"briefing": "Alright, team, we received a call about a missing elderly person in the park. A thorough search needs to be conducted to bring them back safely!"
	},
	{
		"name": "Ace",
		"briefing": "Listen up, kids are playing dangerously close to a construction site. They need to be moved to a safer area, and their guardians informed!"
	},
	{
		"name": "Ace",
		"briefing": "Hey, everyone, the traffic lights at Main and Elm are malfunctioning. Traffic needs to be directed manually until the lights are fixed!"
	},
	{
		"name": "Ace",
		"briefing": "Heads up, we need to escort an ambulance through heavy traffic. A path needs to be cleared to ensure they reach the hospital quickly!"
	},
	{
		"name": "Ace",
		"briefing": "Team, a resident has locked themselves out of their house and needs assistance. Help them gain access safely!"
	},
	{
		"name": "Blossom",
		"briefing": "Alright, team, there's been a car accident on Maple Street. Medical assistance needs to be provided to those involved!"
	},
	{
		"name": "Blossom",
		"briefing": "Listen up, someone fainted at the farmers' market. We need to get there quickly and make sure they're okay!"
	},
	{
		"name": "Blossom",
		"briefing": "Hey, team, a child fell off their bike near the school. First aid needs to be provided, and they must be taken safely to the hospital!"
	},
	{
		"name": "Blossom",
		"briefing": "Heads up, an elderly resident needs transportation to their doctor's appointment. They need to be picked up and taken there safely!"
	},
	{
		"name": "Blossom",
		"briefing": "Team, there's a medical emergency at the community center. Assistance needs to be provided with the situation!"
	},
	{
		"name": "Blossom",
		"briefing": "Alright, team, we have a report of a person with severe allergies at the picnic area. The necessary treatment needs to be administered!"
	},
	{
		"name": "Blossom",
		"briefing": "Listen up, a hiker has injured their leg on the trail. First aid needs to be provided, and they must be transported to the hospital!"
	},
	{
		"name": "Blossom",
		"briefing": "Hey, team, someone slipped at the pool and is hurt. Medical attention needs to be given quickly!"
	},
	{
		"name": "Blossom",
		"briefing": "Heads up, a resident in the apartment complex needs immediate medical care. We need to get there quickly and ensure they're stable!"
	},
	{
		"name": "Blossom",
		"briefing": "Team, a young athlete got hurt during the soccer game. First aid needs to be provided, and they must be taken to the hospital for further treatment!"
	},
	{
		"name": "Chili",
		"briefing": "Alright, team, there's a fire at the local library. The blaze needs to be contained before it spreads!"
	},
	{
		"name": "Chili",
		"briefing": "Listen up, a tree branch fell on a power line and started a fire. The fire needs to be put out safely, and the utility company informed!"
	},
	{
		"name": "Chili",
		"briefing": "Hey, team, we have a kitchen fire reported at a downtown restaurant. The fire needs to be extinguished, and everyone needs to be kept safe!"
	},
	{
		"name": "Chili",
		"briefing": "Heads up, a small fire broke out in the park's picnic area. It needs to be put out quickly before it grows!"
	},
	{
		"name": "Chili",
		"briefing": "Team, a barn on the outskirts of town is on fire. The fire needs to be stopped from spreading to nearby buildings!"
	},
	{
		"name": "Chili",
		"briefing": "Alright, team, a bonfire got out of control at the beach. It needs to be extinguished, and everyone kept safe!"
	},
	{
		"name": "Chili",
		"briefing": "Listen up, there's a fire in a high-rise apartment building. Residents need to be evacuated, and the fire put out!"
	},
	{
		"name": "Chili",
		"briefing": "Hey, team, a car has caught fire on the highway. The flames need to be put out, and the driver kept safe!"
	},
	{
		"name": "Chili",
		"briefing": "Heads up, there's a report of a forest fire near the hiking trails. The fire needs to be contained immediately!"
	},
	{
		"name": "Chili",
		"briefing": "Team, a warehouse is burning near the industrial district. The fire needs to be put out, and any hazardous materials checked!"
	},
	{
		"name": "Chili",
		"briefing": "Listen up, there's a report of a bird's nest on the roof of the town hall. The nest needs to be relocated safely to prevent any damage or danger!"
	},
	{
		"name": "Chili",
		"briefing": "Listen up, there's a report of a cat stuck in a tree in the park. The cat needs to be safely brought down!"
	},
	{
		"name": "Chili",
		"briefing": "Hey, team, we have a fallen tree blocking the main road. The tree needs to be cleared to open up traffic!"
	},
	{
		"name": "Chili",
		"briefing": "Heads up, a large tree branch is hanging dangerously over the school entrance. The branch needs to be safely removed before it falls!"
	},
	{
		"name": "Chili",
		"briefing": "Team, a tree has fallen on a house after the heavy winds. The tree needs to be removed, and the house checked for damage!"
	}
]

var mission = -1

func _ready():
	randomize()
	missions.shuffle()
	next_mission()
	
func next_mission():
	mission += 1
	$Menu/CanvasLayer.show()
	$Menu.get_node("%Briefing").bbcode_text = missions[mission].briefing + "\nFor this mission I will need..."	
	$Menu/CanvasLayer/AnimationPlayer.play("say")

func get_mission_name():
	return missions[mission].name

func _on_animal_pressed(name):
	$Menu.get_node("%" + name).hide()
	if name == missions[mission].name:
		$Menu.get_node("%" + name + "Yes").show()
		$Menu.get_node("%GoButton").show()
	else:
		$Menu.get_node("%" + name + "No").show()

func _on_go_pressed():
	var map = map_scene.instance()
	add_child(map)
	$Menu/CanvasLayer.hide()
