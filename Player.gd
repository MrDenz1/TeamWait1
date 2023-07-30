extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 160
var player_alive = true

var attack_ip = false


const SPEED = 300.0
var current_dir = "none"

func _ready():
	$AnimatedSprite2D2.play("Idle")


func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false #go back to menu or respond
		health = 0
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = SPEED
		velocity.x = 0
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -SPEED
		velocity.x = 0
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
	
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D2
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Run")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("Run")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("Run")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Idle")
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("Run")
		elif movement == 0:
			if attack_ip == false:
				anim.play("Idle")

func player():
	pass



func _on_enemy_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$Attack_Cooldown.start()
		print(health)




func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D2.flip_h = false
			$AnimatedSprite2D2.play("Attack1")
			$Deal_Attack_Timer.start()
		if dir == "left":
			$AnimatedSprite2D2.flip_h = true
			$AnimatedSprite2D2.play("Attack1")
			$Deal_Attack_Timer.start()
		if dir == "down":
			$AnimatedSprite2D2.play("Attack1")
			$Deal_Attack_Timer.start()
		if dir == "up":
			$AnimatedSprite2D2.play("Attack1")
			$Deal_Attack_Timer.start()





func _on_deal_attack_timer_timeout():
	$Deal_Attack_Timer.stop()
	global.player_current_attack = false
	attack_ip = false
