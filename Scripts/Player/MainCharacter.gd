extends CharacterBody2D

@onready var _animationPlayer = $MainCharacterAnimation
@onready var _playerVelocity = GlobalVars.playerVelocity
@onready var _playerHealth = GlobalVars.playerHealth
@onready var _playerDefense = GlobalVars.playerDefense
@onready var _cooldownTimer = $BiteAttack/CooldownTimer
@onready var _cosmeticTimer = $BiteAttack/CosmeticTimer
@onready var _bite = $BiteAttack
@onready var _tailWhip = $TailWhipAttack
@onready var _tailWhipCooldownTimer = $TailWhipAttack/TailCooldowTimer
@onready var _tailWhipCosmeticTimer = $TailWhipAttack/TailCosmeticTimer
@onready var _dashDurationTimer = $dashDuration
@onready var _dashCoolDownTimer = $dashCooldownTimer
@onready var _healthBar = $HealthBar
@onready var _xpBar = $XpBar
@onready var _playerXp = GlobalVars.playerXp
@onready var _playerLevel = GlobalVars.playerLevel
@onready var _playerXpToLevel = GlobalVars.playerXpToLevel
@onready var _hideXpBarTimer = $XpBar/HideXpBarTimer
@onready var _goofySoundChance = GlobalVars.goofySoundChance
@onready var _musicPlayer = get_node("/root/Game/AudioManager/MusicPlayer")
@onready var _musicPlayerDeath = get_node("/root/Game/AudioManager/MusicPlayerDeath")
@onready var _musicPlayerMenu = get_node("/root/Game/AudioManager/MusicPlayerMenu")
@onready var _chompSound = get_node("/root/Game/AudioManager/BiteSFX")
@onready var _chompSoundGoofy = get_node("/root/Game/AudioManager/BiteSFXGoofy")
@onready var _deathSound = get_node("/root/Game/AudioManager/DeathSFX")
@onready var _deathSoundGoofy = get_node("/root/Game/AudioManager/DeathSFXGoofy")
@onready var _mcDashSound = get_node("/root/Game/AudioManager/MainCharacterDashSFX")
@onready var _mcDashSoundGoofy = get_node("/root/Game/AudioManager/MainCharacterDashSFXGoofy")
@onready var _mcSlapSoundGoofy = get_node("/root/Game/AudioManager/MainCharacterSlapSFXGoofy")
@onready var _mcSlapSound = get_node("/root/Game/AudioManager/MainCharacterSlapSFX")

var isLeft = false
var isRight = false
var facingLeft = false
var biteIsReady: bool = true
var tailIsReady: bool = true
var dashIsReady: bool = true
var dashSpeed = 1250
var isDead: bool = false
var isInMenu: bool = false

func _ready():
	_animationPlayer.play("move")
	_healthBar.set_max(_playerHealth)
	_healthBar.value = _playerHealth
	_xpBar.set_max(_playerXpToLevel)
	_xpBar.value = _playerXp
	_xpBar.visible = false
	_musicPlayer.play()

func _process(delta):
	if (_playerHealth <= 0):
		visible = false # stub
		if (!isDead):
			swap_music_track(_musicPlayer, _musicPlayerDeath)
			play_goofy_sound(_deathSound, _deathSoundGoofy)
		isDead = true
		
	if Input.is_action_just_pressed("bite") and biteIsReady:
		biteIsReady = false
		_bite.activate()
		play_goofy_sound(_chompSound, _chompSoundGoofy)
		_cooldownTimer.start()
		_cosmeticTimer.start()
		
	if Input.is_action_just_pressed("tailwhip") and tailIsReady:
		tailIsReady = false
		_tailWhip.activate()
		play_goofy_sound(_mcSlapSound, _mcSlapSoundGoofy)
		_tailWhipCooldownTimer.start()
		_tailWhipCosmeticTimer.start()
		
		
		
	if (Input.is_action_just_pressed("changesong") and !isDead):
		if (isInMenu):
			swap_music_track(_musicPlayerMenu, _musicPlayer)
			isInMenu = false
		else:
			swap_music_track(_musicPlayer, _musicPlayerMenu)
			isInMenu = true
		
func take_damage(dmgValue: float, armorPen: float, hasSlow):
	dmgValue *= 1 - (_playerDefense * (1 - armorPen))
	_playerHealth -= dmgValue
	_healthBar.value = _playerHealth
	if hasSlow:
		_playerVelocity = 150
		$SlowTimer.start()
		$MainCharacterAnimation.speed_scale = 0.5
	
func get_xp(xpValue: float):
	if (_playerXp + xpValue > _playerXpToLevel):
		_playerLevel += 1
		print("Level up to Level ", _playerLevel)
		_playerXp += xpValue - _playerXpToLevel
		_xpBar.max_value = _playerXpToLevel * _playerLevel
	else:
		_playerXp += xpValue
	
	_xpBar.value = _playerXp
	_xpBar.visible = true
	_hideXpBarTimer.start()

func _physics_process(delta):
	if Input.is_action_just_pressed("dash"):
			dash()
	move_character()

func move_character():
	# Determine movement direction based on original code
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Check movement input and set direction flags~
	if Input.is_action_just_pressed("move_right"):
		isRight = true
		isLeft = false
		
	elif Input.is_action_just_pressed("move_left"):
		isRight = false
		isLeft = true

	if isLeft and !facingLeft:
		scale.x *= -1
		facingLeft = true
		#emit_signal("facing_direction_changed", scale.x > 0)
		isLeft = false
		_healthBar.scale.x *= -1
		_healthBar.position.x += 40
		_xpBar.scale.x *= -1
		_xpBar.position.x += 30
	elif isRight and facingLeft:
		scale.x *= -1
		facingLeft = false
		#emit_signal("facing_direction_changed", scale.x > 0)
		isRight = false
		_healthBar.scale.x *= -1
		_healthBar.position.x -= 40
		_xpBar.scale.x *= -1
		_xpBar.position.x -= 30
	
	velocity = direction * _playerVelocity
	_musicPlayer.position = self.position

	move_and_slide()
	
func play_goofy_sound(sound, goofySound):
	if (randi() % 100 < _goofySoundChance):
		goofySound.position = self.position
		goofySound.play()
	else:
		sound.position = self.position
		sound.play()

func swap_music_track(music, to_music):
	var musicPlaybackPosition = music.get_playback_position()
	music.stop()
	to_music.play(musicPlaybackPosition)

func _on_hurt_box_area_entered(area):
	if area == null or area.readyToDmg == null or area.readyToDmg == false:
		pass
	
	area.readyToDmg = false
	area.get_node("HitBoxTimer").start()
	area.play_damage_sound(self.position)
	take_damage(area.damage, area.armorPen, area.hasSlow)


func _on_cooldown_timeout():
	biteIsReady = true


func _on_cosmetic_timer_timeout():
	_bite.deactivate()

func _on_tail_cooldow_timer_timeout():
	tailIsReady = true

func _on_tail_cosmetic_timer_timeout():
	_tailWhip.deactivate()
	
func _on_hide_xp_bar_timer_timeout():
	_hideXpBarTimer.stop()
	_xpBar.visible = false


func _on_slow_timer_timeout():
	_playerVelocity = GlobalVars.playerVelocity
	$MainCharacterAnimation.speed_scale = 1

func dash():
	if dashIsReady:
		print("dashing")
		play_goofy_sound(_mcDashSound, _mcDashSoundGoofy)
		_playerVelocity = 1000
		_dashDurationTimer.start()
		_dashCoolDownTimer.start()
		dashIsReady = false

func _on_dash_cooldown_timer_timeout():
	print("Dash cooldown finished")
	dashIsReady = true


func _on_dash_duration_timeout():
	_playerVelocity = GlobalVars.playerVelocity
