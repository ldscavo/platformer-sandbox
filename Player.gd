extends KinematicBody2D

export (int) var speed
export (int) var jumpHeight

const GRAVITY = 200.0
var velocity = Vector2()

var screensize

func _ready():
    screensize = get_viewport_rect().size    

func _process(delta):
    var velocity = Vector2() # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    
    position += velocity * delta
    position.x = clamp(position.x, 0, screensize.x)
    position.y = clamp(position.y, 0, screensize.y)

func _physics_process(delta):
    velocity.y += delta * GRAVITY
    
    var motion = velocity * delta
    move_and_collide(motion)

func start(pos):
    position = pos