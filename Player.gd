extends KinematicBody2D

const ACCELERATION = 100.0
const MAXSPEED = 500.0
const JUMPSPEED = 400.0
const GRAVITY = 500.0
var velocity = Vector2()

var airtime = 0
var in_air = false

func _physics_process(delta):
    velocity.y += delta * GRAVITY

    airtime += delta

    if is_on_floor():
        airtime = 0
        in_air = false
    else:
        in_air = true

    if Input.is_action_pressed("player_left"):
        if velocity.x > -MAXSPEED:
            velocity.x -= ACCELERATION
    elif Input.is_action_pressed("player_right"):
        if velocity.x < MAXSPEED:
            velocity.x += ACCELERATION

    velocity = move_and_slide(velocity, Vector2(0, 1))


func start(pos):
    position = pos