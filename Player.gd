extends Area2D

export (int) var speed
export (int) var jumpHeight

const GRAVITY = 200
var screensize

func _ready():
    screensize = get_viewport_rect().size    

func _process(delta):
    var velocity = Vector2() # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    
    velocity.y += 1
    
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    
    position += velocity * delta
    position.x = clamp(position.x, 0, screensize.x)
    position.y = clamp(position.y, 0, screensize.y)

func start(pos):
    position = pos