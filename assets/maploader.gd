extends Node2D

class_name MapLoader

var map = {}

func load_map():
    var f = File.new()
    f.open("map.json", File.READ)
    var text = f.get_as_text
    map = JSON.parse(text)
    print("#debug#")
    print(JSON.print(map)) 