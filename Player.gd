extends KinematicBody2D

const SPEED = 500.0
const JUMPSPEED = 400.0
const GRAVITY = 500.0
var velocity = Vector2()

var airtime = 0
var grounded = false
var in_air = false

var screensize

func _ready():
    screensize = get_viewport_rect().size
    #$SprintTrail.emitting = false

func _process(delta):
    pass

func _physics_process(delta):
    velocity.y += delta * GRAVITY

    airtime += delta

    if is_on_floor():
        airtime = 0
        in_air = false
    else:
        in_air = true

    if Input.is_action_pressed("player_left"):
        velocity.x = -SPEED
    elif Input.is_action_pressed("player_right"):
        velocity.x = SPEED
    else:
        velocity.x = 0

    velocity = move_and_slide(velocity, Vector2(0, 1))

    grounded = airtime < 0.1


func start(pos):
    position = pos

