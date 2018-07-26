extends KinematicBody2D

const SPEED = 500.0
const JUMPSPEED = 400.0
const GRAVITY = 500.0
var velocity = Vector2()

var airtime = 0
var grounded = false
var is_jumping = false
var has_double_jump = true
var in_air = false

var screensize

func _ready():
    screensize = get_viewport_rect().size
    #$SprintTrail.emitting = false    

func _process(delta):
    pass

func _physics_process(delta):
    velocity.y += delta * GRAVITY
    
    velocity = move_and_slide(velocity, Vector2(0, -1), 500)
    
    airtime += delta
    
    if is_on_floor():
        airtime = 0
        is_jumping = false
        has_double_jump = true
        in_air = false
    else:
        in_air = true
        
    if Input.is_action_pressed("player_left"):
        velocity.x = -SPEED
    elif Input.is_action_pressed("player_right"):
        velocity.x = SPEED
    #elif not in_air:
    #    velocity.x = 0
    
    grounded = airtime < 0.1
    
    if Input.is_action_just_pressed("player_jump") and grounded:
        jump()
    
    if is_jumping and has_double_jump and Input.is_action_just_pressed("player_jump"):
        has_double_jump = false
        jump()
    
    if Input.is_action_just_released("player_jump"):
        end_jump()


func start(pos):
    position = pos

func jump():
    grounded = false
    is_jumping = true
    velocity.y = -JUMPSPEED

func end_jump():
    if velocity.y <= -100:
        velocity.y = -100
    