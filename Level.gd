extends Node

func _ready():
    $Player.start($TileMap/StartPosition.position)