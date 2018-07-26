extends KinematicBody2D

const WALKSPEED = 150.0
const SPRINTSPEED = 400.0
const JUMPSPEED = 450.0
const GRAVITY = 500.0
var velocity = Vector2()

var airtime = 0
var can_jump = false
var is_jumping = false

var screensize

func _ready():
    screensize = get_viewport_rect().size    

func _process(delta):
    pass

func _physics_process(delta):
    velocity.y += delta * GRAVITY
    
    velocity = move_and_slide(velocity, Vector2(0, -1))
    
    airtime += delta
    
    if is_on_floor():
        airtime = 0
        is_jumping = false
    
    var speed = WALKSPEED
    if Input.is_action_pressed("player_sprint"):
        speed = SPRINTSPEED
    
    if Input.is_action_pressed("player_left"):
        velocity.x = -speed
    elif Input.is_action_pressed("player_right"):
        velocity.x = speed
    else:
        velocity.x = 0
    
    can_jump = airtime < 0.4
    
    if can_jump and Input.is_action_just_pressed("player_jump"):
        jump()
    
    if Input.is_action_just_released("player_jump"):
        end_jump()


func start(pos):
    position = pos

func jump():
    can_jump = false
    is_jumping = true
    velocity.y -= JUMPSPEED

func end_jump():
    if velocity.y <= -100:
        velocity.y = -100
    