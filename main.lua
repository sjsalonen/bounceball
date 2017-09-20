function love.load()
	love.window.setTitle("Budget Platformer v1.0 by Santeri Salonen")
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	love.physics.setMeter(64)
	
	game_state = 1
	timerCounter = 0
	counter_running = false
	
	x = 0
	y = 0
	jumpimpulse_x = 0
	jumpimpulse_y = 0
	points = 0
	health = 100
	lives = 3
	number_of_collectibles = 0
	current_level = 1
	powerup_in_use = "None"
	hasplayerhitstar = false
	startup_image = love.graphics.newImage("startup.png")
	gameover_image = love.graphics.newImage("gameover.png")
	star_image = love.graphics.newImage("star.png")
	hazard_image = love.graphics.newImage("spikeball.png")
	healthpowerup_image = love.graphics.newImage("healthpowerup.png")
	jumppowerup_image = love.graphics.newImage("jumppowerup.png")
	crushpowerup_image = love.graphics.newImage("crushpowerup.png")
	
	if game_state == 2 then
		create_level(current_level, 100)
	end
end

function create_level(current_level, new_health)
	hasplayerhitstar = false
	counter_running = true
	powerup_in_use = "None"
	health = new_health
	if current_level == 1 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = 330
		star_y = 120
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, screenWidth/2.1, screenHeight-80, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
	
		objects.ground = {}
		objects.ground.body = love.physics.newBody(world, screenWidth/2, screenHeight-50/2)
		objects.ground.shape = love.physics.newRectangleShape(screenWidth, 50)
		objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
		objects.ground.fixture:setUserData("ground")
	
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
	
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, (screenHeight -100) / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")
	
		objects.brick1 = {}
		objects.brick1.body = love.physics.newBody(world, screenWidth - 120, screenHeight - 170)
		objects.brick1.shape = love.physics.newRectangleShape(80, 20)
		objects.brick1.fixture = love.physics.newFixture(objects.brick1.body, objects.brick1.shape)
		objects.brick1.fixture:setUserData("brick")
	
		objects.brick2 = {}
		objects.brick2.body = love.physics.newBody(world, screenWidth - 480, screenHeight - 310)
		objects.brick2.shape = love.physics.newRectangleShape(400, 20)
		objects.brick2.fixture = love.physics.newFixture(objects.brick2.body, objects.brick2.shape)
		objects.brick2.fixture:setUserData("brick")
	
		objects.brick3 = {}
		objects.brick3.body = love.physics.newBody(world, screenWidth - 450, screenHeight - 440)
		objects.brick3.shape = love.physics.newRectangleShape(80, 20)
		objects.brick3.fixture = love.physics.newFixture(objects.brick3.body, objects.brick3.shape)
		objects.brick3.fixture:setUserData("brick")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		love.graphics.setBackgroundColor(100, 140, 240)	
	elseif current_level == 2 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = 630
		star_y = 140
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, screenWidth-100, screenHeight-80, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.ground = {}
		objects.ground.body = love.physics.newBody(world, screenWidth/2, screenHeight-50/2)
		objects.ground.shape = love.physics.newRectangleShape(screenWidth, 50)
		objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
		objects.ground.fixture:setUserData("ground")
	
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
	
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, (screenHeight -100) / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")

		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.brick4 = {}
		objects.brick4.body = love.physics.newBody(world, screenWidth - 220, screenHeight - 220)
		objects.brick4.shape = love.physics.newRectangleShape(400, 10)
		objects.brick4.fixture = love.physics.newFixture(objects.brick4.body, objects.brick4.shape)
		objects.brick4.fixture:setUserData("brick")
		
		objects.box1 = {}
		objects.box1.body = love.physics.newBody(world, screenWidth - 400, screenHeight - 70, "dynamic")
		objects.box1.shape = love.physics.newRectangleShape(50, 50)
		objects.box1.fixture = love.physics.newFixture(objects.box1.body, objects.box1.shape, 1.2)
		objects.box1.fixture:setUserData("box")
		
		objects.box2 = {}
		objects.box2.body = love.physics.newBody(world, screenWidth - 400, screenHeight - 120, "dynamic")
		objects.box2.shape = love.physics.newRectangleShape(50, 50)
		objects.box2.fixture = love.physics.newFixture(objects.box2.body, objects.box2.shape, 1.2)
		objects.box2.fixture:setUserData("box")
		
		objects.box3 = {}
		objects.box3.body = love.physics.newBody(world, screenWidth - 400, screenHeight - 170, "dynamic")
		objects.box3.shape = love.physics.newRectangleShape(50, 50)
		objects.box3.fixture = love.physics.newFixture(objects.box3.body, objects.box3.shape, 1.2)
		objects.box3.fixture:setUserData("box")
		
		objects.box4 = {}
		objects.box4.body = love.physics.newBody(world, screenWidth - 350, screenHeight - 220, "dynamic")
		objects.box4.shape = love.physics.newRectangleShape(50, 50)
		objects.box4.fixture = love.physics.newFixture(objects.box4.body, objects.box4.shape, 1.2)
		objects.box4.fixture:setUserData("box")
		
		objects.box5 = {}
		objects.box5.body = love.physics.newBody(world, screenWidth - 350, screenHeight - 270, "dynamic")
		objects.box5.shape = love.physics.newRectangleShape(50, 50)
		objects.box5.fixture = love.physics.newFixture(objects.box5.body, objects.box5.shape, 1.2)
		objects.box5.fixture:setUserData("box")
		
		objects.box6 = {}
		objects.box6.body = love.physics.newBody(world, screenWidth - 350, screenHeight - 320, "dynamic")
		objects.box6.shape = love.physics.newRectangleShape(50, 50)
		objects.box6.fixture = love.physics.newFixture(objects.box6.body, objects.box6.shape, 1.2)
		objects.box6.fixture:setUserData("box")
		
		love.graphics.setBackgroundColor(150, 180, 200)	
	elseif current_level == 3 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = 620
		star_y = 55
		
		hazard1_x = 50
		hazard1_y = 440
		hazard2_x = 500
		hazard2_y = 520
		hazard3_x = 400
		hazard3_y = 440
		hazard4_x = 440
		hazard4_y = 410
		hazard5_x = 600
		hazard5_y = 380
		hazard6_x = 620
		hazard6_y = 190
		hazard7_x = 580
		hazard7_y = 70
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, screenWidth-750, screenHeight-80, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.ground = {}
		objects.ground.body = love.physics.newBody(world, screenWidth/2, screenHeight-50/2)
		objects.ground.shape = love.physics.newRectangleShape(screenWidth, 50)
		objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
		objects.ground.fixture:setUserData("ground")
	
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
	
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, (screenHeight -100) / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")
		
		objects.brick5 = {}
		objects.brick5.body = love.physics.newBody(world, screenWidth - 230, screenHeight - 120)
		objects.brick5.shape = love.physics.newRectangleShape(450, 10)
		objects.brick5.fixture = love.physics.newFixture(objects.brick5.body, objects.brick5.shape)
		objects.brick5.fixture:setUserData("brick")
		
		objects.brick6 = {}
		objects.brick6.body = love.physics.newBody(world, screenWidth - 190, screenHeight - 510)
		objects.brick6.shape = love.physics.newRectangleShape(80, 10)
		objects.brick6.fixture = love.physics.newFixture(objects.brick6.body, objects.brick6.shape)
		objects.brick6.fixture:setUserData("brick")
		
		objects.brick7 = {}
		objects.brick7.body = love.physics.newBody(world, screenWidth - 290, screenHeight - 300)
		objects.brick7.shape = love.physics.newRectangleShape(70, 10)
		objects.brick7.fixture = love.physics.newFixture(objects.brick7.body, objects.brick7.shape)
		objects.brick7.fixture:setUserData("brick")
		
		objects.brick8 = {}
		objects.brick8.body = love.physics.newBody(world, screenWidth - 240, screenHeight - 400)
		objects.brick8.shape = love.physics.newRectangleShape(70, 10)
		objects.brick8.fixture = love.physics.newFixture(objects.brick8.body, objects.brick8.shape)
		objects.brick8.fixture:setUserData("brick")
		
		objects.brick9 = {}
		objects.brick9.body = love.physics.newBody(world, screenWidth - 100, screenHeight - 420)
		objects.brick9.shape = love.physics.newRectangleShape(80, 10)
		objects.brick9.fixture = love.physics.newFixture(objects.brick9.body, objects.brick9.shape)
		objects.brick9.fixture:setUserData("brick")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.hazard1 = {}
		objects.hazard1.body = love.physics.newBody(world, hazard1_x, hazard1_y)
		objects.hazard1.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard1.fixture = love.physics.newFixture(objects.hazard1.body, objects.hazard1.shape)
		objects.hazard1.fixture:setUserData("hazard")
		
		objects.hazard2 = {}
		objects.hazard2.body = love.physics.newBody(world, hazard2_x, hazard2_y)
		objects.hazard2.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard2.fixture = love.physics.newFixture(objects.hazard2.body, objects.hazard2.shape)
		objects.hazard2.fixture:setUserData("hazard")
		
		objects.hazard3 = {}
		objects.hazard3.body = love.physics.newBody(world, hazard3_x, hazard3_y)
		objects.hazard3.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard3.fixture = love.physics.newFixture(objects.hazard3.body, objects.hazard3.shape)
		objects.hazard3.fixture:setUserData("hazard")
		
		objects.hazard4 = {}
		objects.hazard4.body = love.physics.newBody(world, hazard4_x, hazard4_y)
		objects.hazard4.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard4.fixture = love.physics.newFixture(objects.hazard4.body, objects.hazard4.shape)
		objects.hazard4.fixture:setUserData("hazard")
		
		objects.hazard5 = {}
		objects.hazard5.body = love.physics.newBody(world, hazard5_x, hazard5_y)
		objects.hazard5.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard5.fixture = love.physics.newFixture(objects.hazard5.body, objects.hazard5.shape)
		objects.hazard5.fixture:setUserData("hazard")
		
		objects.hazard6 = {}
		objects.hazard6.body = love.physics.newBody(world, hazard6_x, hazard6_y)
		objects.hazard6.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard6.fixture = love.physics.newFixture(objects.hazard6.body, objects.hazard6.shape)
		objects.hazard6.fixture:setUserData("hazard")
		
		objects.hazard7 = {}
		objects.hazard7.body = love.physics.newBody(world, hazard7_x, hazard7_y)
		objects.hazard7.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard7.fixture = love.physics.newFixture(objects.hazard7.body, objects.hazard7.shape)
		objects.hazard7.fixture:setUserData("hazard")
		
		objects.hazard8 = {}
		objects.hazard8.body = love.physics.newBody(world, hazard8_x, hazard8_y)
		objects.hazard8.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard8.fixture = love.physics.newFixture(objects.hazard8.body, objects.hazard8.shape)
		objects.hazard8.fixture:setUserData("hazard")
		
		love.graphics.setBackgroundColor(92, 105, 190)
	elseif current_level == 4 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = 620
		star_y = 45
		
		hazard8_x = 50
		hazard8_y = 450
		hazard9_x = 450
		hazard9_y = 350
		hazard10_x = 200
		hazard10_y = 350
		
		healthpowerup1_x = 300
		healthpowerup1_y = 450
		
		jumppowerup1_x = 320
		jumppowerup1_y = 240
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, screenWidth-750, screenHeight-80, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.ground1 = {}
		objects.ground1.body = love.physics.newBody(world, screenWidth/2 - 340, screenHeight-50/2)
		objects.ground1.shape = love.physics.newRectangleShape(50, 50)
		objects.ground1.fixture = love.physics.newFixture(objects.ground1.body, objects.ground1.shape)
		objects.ground1.fixture:setUserData("ground")
		
		objects.ground2 = {}
		objects.ground2.body = love.physics.newBody(world, screenWidth/2 - 110, screenHeight-50/2)
		objects.ground2.shape = love.physics.newRectangleShape(200, 50)
		objects.ground2.fixture = love.physics.newFixture(objects.ground2.body, objects.ground2.shape)
		objects.ground2.fixture:setUserData("ground")
		
		objects.ground3 = {}
		objects.ground3.body = love.physics.newBody(world, screenWidth - 80, screenHeight-50/2)
		objects.ground3.shape = love.physics.newRectangleShape(100, 50)
		objects.ground3.fixture = love.physics.newFixture(objects.ground3.body, objects.ground3.shape)
		objects.ground3.fixture:setUserData("ground")
	
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
	
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, screenHeight / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.brick10 = {}
		objects.brick10.body = love.physics.newBody(world, screenWidth - 450, screenHeight - 230)
		objects.brick10.shape = love.physics.newRectangleShape(380, 10)
		objects.brick10.fixture = love.physics.newFixture(objects.brick10.body, objects.brick10.shape)
		objects.brick10.fixture:setUserData("brick")
		
		objects.brick11 = {}
		objects.brick11.body = love.physics.newBody(world, screenWidth - 340, screenHeight - 420)
		objects.brick11.shape = love.physics.newRectangleShape(250, 10)
		objects.brick11.fixture = love.physics.newFixture(objects.brick11.body, objects.brick11.shape)
		objects.brick11.fixture:setUserData("brick")
		
		objects.brick12 = {}
		objects.brick12.body = love.physics.newBody(world, screenWidth - 370, screenHeight - 515)
		objects.brick12.shape = love.physics.newRectangleShape(10, 110)
		objects.brick12.fixture = love.physics.newFixture(objects.brick12.body, objects.brick12.shape)
		objects.brick12.fixture:setUserData("brick")
		
		objects.hazard8 = {}
		objects.hazard8.body = love.physics.newBody(world, hazard8_x, hazard8_y)
		objects.hazard8.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard8.fixture = love.physics.newFixture(objects.hazard8.body, objects.hazard8.shape)
		objects.hazard8.fixture:setUserData("hazard")
		
		objects.hazard9 = {}
		objects.hazard9.body = love.physics.newBody(world, hazard9_x, hazard9_y)
		objects.hazard9.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard9.fixture = love.physics.newFixture(objects.hazard9.body, objects.hazard9.shape)
		objects.hazard9.fixture:setUserData("hazard")
		
		objects.hazard10 = {}
		objects.hazard10.body = love.physics.newBody(world, hazard10_x, hazard10_y)
		objects.hazard10.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard10.fixture = love.physics.newFixture(objects.hazard10.body, objects.hazard10.shape)
		objects.hazard10.fixture:setUserData("hazard")
		
		objects.healthpowerup1 = {}
		objects.healthpowerup1.body = love.physics.newBody(world, healthpowerup1_x, healthpowerup1_y)
		objects.healthpowerup1.shape = love.physics.newRectangleShape(healthpowerup_image:getWidth(), healthpowerup_image:getHeight())
		objects.healthpowerup1.fixture = love.physics.newFixture(objects.healthpowerup1.body, objects.healthpowerup1.shape, 0.1)
		objects.healthpowerup1.fixture:setUserData("health")
		
		objects.jumppowerup1 = {}
		objects.jumppowerup1.body = love.physics.newBody(world, jumppowerup1_x, jumppowerup1_y)
		objects.jumppowerup1.shape = love.physics.newRectangleShape(jumppowerup_image:getWidth(), jumppowerup_image:getHeight())
		objects.jumppowerup1.fixture = love.physics.newFixture(objects.jumppowerup1.body, objects.jumppowerup1.shape, 0.1)
		objects.jumppowerup1.fixture:setUserData("jump")
		
		love.graphics.setBackgroundColor(242, 162, 71)
	elseif current_level == 5 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = 740
		star_y = 55
		
		hazard11_x = 130
		hazard11_y = 150
		hazard12_x = 760
		hazard12_y = 550
		hazard13_x = 70
		hazard13_y = 70
		hazard14_x = 620
		hazard14_y = 250
		
		jumppowerup2_x = 620
		jumppowerup2_y = 350
		crushpowerup1_x = 380
		crushpowerup1_y = 120
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, 45, 170, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.ground4 = {}
		objects.ground4.body = love.physics.newBody(world, 10, 400)
		objects.ground4.shape = love.physics.newRectangleShape(120, 400)
		objects.ground4.fixture = love.physics.newFixture(objects.ground4.body, objects.ground4.shape)
		objects.ground4.fixture:setUserData("ground")
		
		objects.ground5 = {}
		objects.ground5.body = love.physics.newBody(world, 70, 300)
		objects.ground5.shape = love.physics.newPolygonShape(0, 0, 0, 200, 200, 200)
		objects.ground5.fixture = love.physics.newFixture(objects.ground5.body, objects.ground5.shape)
		objects.ground5.fixture:setUserData("ground")
		
		objects.ground6 = {}
		objects.ground6.body = love.physics.newBody(world, 610, 600)
		objects.ground6.shape = love.physics.newRectangleShape(350, 50)
		objects.ground6.fixture = love.physics.newFixture(objects.ground6.body, objects.ground6.shape)
		objects.ground6.fixture:setUserData("ground")
		
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
	
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, screenHeight / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.hazard11 = {}
		objects.hazard11.body = love.physics.newBody(world, hazard11_x, hazard11_y)
		objects.hazard11.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard11.fixture = love.physics.newFixture(objects.hazard11.body, objects.hazard11.shape)
		objects.hazard11.fixture:setUserData("hazard")
		
		objects.hazard12 = {}
		objects.hazard12.body = love.physics.newBody(world, hazard12_x, hazard12_y)
		objects.hazard12.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard12.fixture = love.physics.newFixture(objects.hazard12.body, objects.hazard12.shape)
		objects.hazard12.fixture:setUserData("hazard")
		
		objects.hazard13 = {}
		objects.hazard13.body = love.physics.newBody(world, hazard13_x, hazard13_y)
		objects.hazard13.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard13.fixture = love.physics.newFixture(objects.hazard13.body, objects.hazard13.shape)
		objects.hazard13.fixture:setUserData("hazard")
		
		objects.hazard14 = {}
		objects.hazard14.body = love.physics.newBody(world, hazard14_x, hazard14_y)
		objects.hazard14.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard14.fixture = love.physics.newFixture(objects.hazard14.body, objects.hazard14.shape)
		objects.hazard14.fixture:setUserData("hazard")
		
		objects.brick13 = {}
		objects.brick13.body = love.physics.newBody(world, screenWidth - 170, screenHeight - 115)
		objects.brick13.shape = love.physics.newRectangleShape(100, 10)
		objects.brick13.fixture = love.physics.newFixture(objects.brick13.body, objects.brick13.shape)
		objects.brick13.fixture:setUserData("brick")
		
		objects.brick14 = {}
		objects.brick14.body = love.physics.newBody(world, screenWidth - 80, screenHeight - 480)
		objects.brick14.shape = love.physics.newRectangleShape(600, 10)
		objects.brick14.fixture = love.physics.newFixture(objects.brick14.body, objects.brick14.shape)
		objects.brick14.fixture:setUserData("brick")
		
		objects.brick15 = {}
		objects.brick15.body = love.physics.newBody(world, screenWidth - 390, screenHeight - 390)
		objects.brick15.shape = love.physics.newRectangleShape(100, 10)
		objects.brick15.fixture = love.physics.newFixture(objects.brick15.body, objects.brick15.shape)
		objects.brick15.fixture:setUserData("brick")	

		objects.jumppowerup2 = {}
		objects.jumppowerup2.body = love.physics.newBody(world, jumppowerup2_x, jumppowerup2_y)
		objects.jumppowerup2.shape = love.physics.newRectangleShape(jumppowerup_image:getWidth(), jumppowerup_image:getHeight())
		objects.jumppowerup2.fixture = love.physics.newFixture(objects.jumppowerup2.body, objects.jumppowerup2.shape, 0.1)
		objects.jumppowerup2.fixture:setUserData("jump")		
		
		objects.crushpowerup1 = {}
		objects.crushpowerup1.body = love.physics.newBody(world, crushpowerup1_x, crushpowerup1_y)
		objects.crushpowerup1.shape = love.physics.newRectangleShape(crushpowerup_image:getWidth(), crushpowerup_image:getHeight())
		objects.crushpowerup1.fixture = love.physics.newFixture(objects.crushpowerup1.body, objects.crushpowerup1.shape, 0.1)
		objects.crushpowerup1.fixture:setUserData("crush")	
		
		objects.box7 = {}
		objects.box7.body = love.physics.newBody(world, 550, 80)
		objects.box7.shape = love.physics.newRectangleShape(65, 65)
		objects.box7.fixture = love.physics.newFixture(objects.box7.body, objects.box7.shape, 1)
		objects.box7.fixture:setUserData("bigbox")
		
		love.graphics.setBackgroundColor(30, 51, 115)
	elseif current_level == 6 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = 30
		star_y = 55
		
		hazard15_x = 180
		hazard15_y = 322
		hazard16_x = 180
		hazard16_y = 400
		hazard17_x = 480
		hazard17_y = 450
		hazard18_x = 650
		hazard18_y = 450
		hazard19_x = 580
		hazard19_y = 260
		hazard20_x = 250
		hazard20_y = 230
		
		healthpowerup2_x = screenWidth - 50
		healthpowerup2_y = screenHeight - 150
		crushpowerup2_x = 25
		crushpowerup2_y = 280
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, screenWidth-70, screenHeight-80, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.ground = {}
		objects.ground.body = love.physics.newBody(world, screenWidth/2, screenHeight-50/2)
		objects.ground.shape = love.physics.newRectangleShape(screenWidth, 50)
		objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
		objects.ground.fixture:setUserData("ground")
	
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
	
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, (screenHeight -100) / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.brick16 = {}
		objects.brick16.body = love.physics.newBody(world, 170, 100)
		objects.brick16.shape = love.physics.newRectangleShape(300, 10)
		objects.brick16.fixture = love.physics.newFixture(objects.brick16.body, objects.brick16.shape)
		objects.brick16.fixture:setUserData("brick")
		
		objects.brick17 = {}
		objects.brick17.body = love.physics.newBody(world, screenWidth-180, screenHeight - 120)
		objects.brick17.shape = love.physics.newRectangleShape(320, 10)
		objects.brick17.fixture = love.physics.newFixture(objects.brick17.body, objects.brick17.shape)
		objects.brick17.fixture:setUserData("brick")
		
		objects.brick18 = {}
		objects.brick18.body = love.physics.newBody(world, screenWidth-100, screenHeight - 250)
		objects.brick18.shape = love.physics.newRectangleShape(120, 10)
		objects.brick18.fixture = love.physics.newFixture(objects.brick18.body, objects.brick18.shape)
		objects.brick18.fixture:setUserData("brick")
		
		objects.brick19 = {}
		objects.brick19.body = love.physics.newBody(world, screenWidth-250, screenHeight - 320)
		objects.brick19.shape = love.physics.newRectangleShape(120, 10)
		objects.brick19.fixture = love.physics.newFixture(objects.brick19.body, objects.brick19.shape)
		objects.brick19.fixture:setUserData("brick")
		
		objects.brick20 = {}
		objects.brick20.body = love.physics.newBody(world, 70, screenHeight - 220)
		objects.brick20.shape = love.physics.newRectangleShape(100, 10)
		objects.brick20.fixture = love.physics.newFixture(objects.brick20.body, objects.brick20.shape)
		objects.brick20.fixture:setUserData("brick")
		
		objects.brick21 = {}
		objects.brick21.body = love.physics.newBody(world, screenWidth-450, screenHeight - 380)
		objects.brick21.shape = love.physics.newRectangleShape(120, 10)
		objects.brick21.fixture = love.physics.newFixture(objects.brick21.body, objects.brick21.shape)
		objects.brick21.fixture:setUserData("brick")
		
		objects.hazard15 = {}
		objects.hazard15.body = love.physics.newBody(world, hazard15_x, hazard15_y)
		objects.hazard15.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard15.fixture = love.physics.newFixture(objects.hazard15.body, objects.hazard15.shape)
		objects.hazard15.fixture:setUserData("hazard")
		
		objects.hazard16 = {}
		objects.hazard16.body = love.physics.newBody(world, hazard16_x, hazard16_y)
		objects.hazard16.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard16.fixture = love.physics.newFixture(objects.hazard16.body, objects.hazard16.shape)
		objects.hazard16.fixture:setUserData("hazard")
		
		objects.hazard17 = {}
		objects.hazard17.body = love.physics.newBody(world, hazard17_x, hazard17_y)
		objects.hazard17.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard17.fixture = love.physics.newFixture(objects.hazard17.body, objects.hazard17.shape)
		objects.hazard17.fixture:setUserData("hazard")
		
		objects.hazard18 = {}
		objects.hazard18.body = love.physics.newBody(world, hazard18_x, hazard18_y)
		objects.hazard18.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard18.fixture = love.physics.newFixture(objects.hazard18.body, objects.hazard18.shape)
		objects.hazard18.fixture:setUserData("hazard")
		
		objects.hazard19 = {}
		objects.hazard19.body = love.physics.newBody(world, hazard19_x, hazard19_y)
		objects.hazard19.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard19.fixture = love.physics.newFixture(objects.hazard19.body, objects.hazard19.shape)
		objects.hazard19.fixture:setUserData("hazard")
		
		objects.hazard20 = {}
		objects.hazard20.body = love.physics.newBody(world, hazard20_x, hazard20_y)
		objects.hazard20.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard20.fixture = love.physics.newFixture(objects.hazard20.body, objects.hazard20.shape)
		objects.hazard20.fixture:setUserData("hazard")
		
		objects.healthpowerup2 = {}
		objects.healthpowerup2.body = love.physics.newBody(world, healthpowerup2_x, healthpowerup2_y)
		objects.healthpowerup2.shape = love.physics.newRectangleShape(healthpowerup_image:getWidth(), healthpowerup_image:getHeight())
		objects.healthpowerup2.fixture = love.physics.newFixture(objects.healthpowerup2.body, objects.healthpowerup2.shape, 0.1)
		objects.healthpowerup2.fixture:setUserData("health")
		
		objects.crushpowerup2 = {}
		objects.crushpowerup2.body = love.physics.newBody(world, crushpowerup2_x, crushpowerup2_y)
		objects.crushpowerup2.shape = love.physics.newRectangleShape(crushpowerup_image:getWidth(), crushpowerup_image:getHeight())
		objects.crushpowerup2.fixture = love.physics.newFixture(objects.crushpowerup2.body, objects.crushpowerup2.shape, 0.1)
		objects.crushpowerup2.fixture:setUserData("crush")
		
		objects.box8 = {}
		objects.box8.body = love.physics.newBody(world, 230, 70)
		objects.box8.shape = love.physics.newRectangleShape(50, 50)
		objects.box8.fixture = love.physics.newFixture(objects.box8.body, objects.box8.shape, 1)
		objects.box8.fixture:setUserData("bigbox")
		
		love.graphics.setBackgroundColor(101, 51, 243)
	elseif current_level == 7 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
	
		star_x = screenWidth - 50
		star_y = screenHeight - 80
		
		hazard21_x = 250
		hazard21_y = screenHeight - 200
		hazard22_x = 120
		hazard22_y = screenHeight - 350
		hazard23_x = 280
		hazard23_y = 110
		hazard24_x = 450
		hazard24_y = 110
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, 50, screenHeight - 40, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.brick22 = {}
		objects.brick22.body = love.physics.newBody(world, 60, screenHeight - 20)
		objects.brick22.shape = love.physics.newRectangleShape(100, 10)
		objects.brick22.fixture = love.physics.newFixture(objects.brick22.body, objects.brick22.shape)
		objects.brick22.fixture:setUserData("brick")
		
		objects.brick23 = {}
		objects.brick23.body = love.physics.newBody(world, 200, screenHeight - 160)
		objects.brick23.shape = love.physics.newRectangleShape(120, 10)
		objects.brick23.fixture = love.physics.newFixture(objects.brick23.body, objects.brick23.shape)
		objects.brick23.fixture:setUserData("brick")
		
		objects.brick24 = {}
		objects.brick24.body = love.physics.newBody(world, 60, screenHeight - 330)
		objects.brick24.shape = love.physics.newRectangleShape(100, 10)
		objects.brick24.fixture = love.physics.newFixture(objects.brick24.body, objects.brick24.shape)
		objects.brick24.fixture:setUserData("brick")
		
		objects.brick25 = {}
		objects.brick25.body = love.physics.newBody(world, 280, screenHeight - 320)
		objects.brick25.shape = love.physics.newRectangleShape(10, 120)
		objects.brick25.fixture = love.physics.newFixture(objects.brick25.body, objects.brick25.shape)
		objects.brick25.fixture:setUserData("rightwall")
		
		objects.brick26 = {}
		objects.brick26.body = love.physics.newBody(world, 380, screenHeight - 460)
		objects.brick26.shape = love.physics.newRectangleShape(400, 10)
		objects.brick26.fixture = love.physics.newFixture(objects.brick26.body, objects.brick26.shape)
		objects.brick26.fixture:setUserData("brick")
		
		objects.hazard21 = {}
		objects.hazard21.body = love.physics.newBody(world, hazard21_x, hazard21_y)
		objects.hazard21.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard21.fixture = love.physics.newFixture(objects.hazard21.body, objects.hazard21.shape)
		objects.hazard21.fixture:setUserData("hazard")
		
		objects.hazard22 = {}
		objects.hazard22.body = love.physics.newBody(world, hazard22_x, hazard22_y)
		objects.hazard22.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard22.fixture = love.physics.newFixture(objects.hazard22.body, objects.hazard22.shape)
		objects.hazard22.fixture:setUserData("hazard")
		
		objects.hazard23 = {}
		objects.hazard23.body = love.physics.newBody(world, hazard23_x, hazard23_y)
		objects.hazard23.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard23.fixture = love.physics.newFixture(objects.hazard23.body, objects.hazard23.shape)
		objects.hazard23.fixture:setUserData("hazard")
		
		objects.hazard24 = {}
		objects.hazard24.body = love.physics.newBody(world, hazard24_x, hazard24_y)
		objects.hazard24.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard24.fixture = love.physics.newFixture(objects.hazard24.body, objects.hazard24.shape)
		objects.hazard24.fixture:setUserData("hazard")
		
		love.graphics.setBackgroundColor(3, 4, 28)
	elseif current_level == 8 then
		world = love.physics.newWorld(0, 9.81*64, true)
	
		world:setCallbacks(physicsBeginContact, physicsEndContact)
		objects = {}
		
		star_x = screenWidth/2
		star_y = (screenHeight/2) + 50
		
		hazard25_x = 550
		hazard25_y = 150
		hazard26_x = 330
		hazard26_y = 200
		hazard27_x = 330
		hazard27_y = 380
		hazard28_x = 470
		hazard28_y = 380
		hazard29_x = 400
		hazard29_y = 300
		hazard30_x = 700
		hazard30_y = 350
		
		objects.player = {}
		objects.player.body = love.physics.newBody(world, 50, 80, "dynamic")
		objects.player.shape = love.physics.newCircleShape(15)
		objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 2)
		objects.player.fixture:setRestitution(0.2)
		objects.player.fixture:setUserData("player")
		--tarkistaa, että pelaaja koskettaa maata
		objects.player.not_in_air = true
		--tarkistaa, että pelaaja koskettaa seinää
		objects.player.touching_right_wall = false
		objects.player.touching_left_wall = false
		
		objects.top = {}
		objects.top.body = love.physics.newBody(world, screenWidth/2, 10)
		objects.top.shape = love.physics.newRectangleShape(screenWidth, 40)
		objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
		objects.top.fixture:setUserData("top")
		
		objects.left = {}
		objects.left.body = love.physics.newBody(world, 10, screenHeight / 2)
		objects.left.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
		objects.left.fixture:setUserData("leftwall")
	
		objects.right = {}
		objects.right.body = love.physics.newBody(world, screenWidth - 10, screenHeight / 2)
		objects.right.shape = love.physics.newRectangleShape(20, screenHeight)
		objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
		objects.right.fixture:setUserData("rightwall")
		
		objects.ground7 = {}
		objects.ground7.body = love.physics.newBody(world, 10, 300)
		objects.ground7.shape = love.physics.newPolygonShape(0, 0, 0, 500, 400, 400)
		objects.ground7.fixture = love.physics.newFixture(objects.ground7.body, objects.ground7.shape)
		objects.ground7.fixture:setUserData("ground")
		
		objects.ground8 = {}
		objects.ground8.body = love.physics.newBody(world, screenWidth - 10, 300)
		objects.ground8.shape = love.physics.newPolygonShape(0, 0, 0, 500, -400, 400)
		objects.ground8.fixture = love.physics.newFixture(objects.ground8.body, objects.ground8.shape)
		objects.ground8.fixture:setUserData("ground")
		
		objects.star = {}
		objects.star.body = love.physics.newBody(world, star_x, star_y)
		objects.star.shape = love.physics.newRectangleShape(star_image:getWidth(), star_image:getHeight())
		objects.star.fixture = love.physics.newFixture(objects.star.body, objects.star.shape)
		objects.star.fixture:setUserData("star")
		
		objects.brick27 = {}
		objects.brick27.body = love.physics.newBody(world, 50, 120)
		objects.brick27.shape = love.physics.newRectangleShape(400, 10)
		objects.brick27.fixture = love.physics.newFixture(objects.brick27.body, objects.brick27.shape)
		objects.brick27.fixture:setUserData("brick")
		
		objects.brick28 = {}
		objects.brick28.body = love.physics.newBody(world, 550, 190)
		objects.brick28.shape = love.physics.newRectangleShape(250, 10)
		objects.brick28.fixture = love.physics.newFixture(objects.brick28.body, objects.brick28.shape)
		objects.brick28.fixture:setUserData("brick")
		
		objects.brick29 = {}
		objects.brick29.body = love.physics.newBody(world, 410, 320)
		objects.brick29.shape = love.physics.newRectangleShape(120, 10)
		objects.brick29.fixture = love.physics.newFixture(objects.brick29.body, objects.brick29.shape)
		objects.brick29.fixture:setUserData("brick")
		
		objects.brick30 = {}
		objects.brick30.body = love.physics.newBody(world, 410, 400)
		objects.brick30.shape = love.physics.newRectangleShape(120, 10)
		objects.brick30.fixture = love.physics.newFixture(objects.brick30.body, objects.brick30.shape)
		objects.brick30.fixture:setUserData("brick")
		
		objects.hazard25 = {}
		objects.hazard25.body = love.physics.newBody(world, hazard25_x, hazard25_y)
		objects.hazard25.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard25.fixture = love.physics.newFixture(objects.hazard25.body, objects.hazard25.shape)
		objects.hazard25.fixture:setUserData("hazard")
		
		objects.hazard26 = {}
		objects.hazard26.body = love.physics.newBody(world, hazard26_x, hazard26_y)
		objects.hazard26.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard26.fixture = love.physics.newFixture(objects.hazard26.body, objects.hazard26.shape)
		objects.hazard26.fixture:setUserData("hazard")

		objects.hazard27 = {}
		objects.hazard27.body = love.physics.newBody(world, hazard27_x, hazard27_y)
		objects.hazard27.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard27.fixture = love.physics.newFixture(objects.hazard27.body, objects.hazard27.shape)
		objects.hazard27.fixture:setUserData("hazard")
		
		objects.hazard28 = {}
		objects.hazard28.body = love.physics.newBody(world, hazard28_x, hazard28_y)
		objects.hazard28.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard28.fixture = love.physics.newFixture(objects.hazard28.body, objects.hazard28.shape)
		objects.hazard28.fixture:setUserData("hazard")
		
		objects.hazard29 = {}
		objects.hazard29.body = love.physics.newBody(world, hazard29_x, hazard29_y)
		objects.hazard29.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard29.fixture = love.physics.newFixture(objects.hazard29.body, objects.hazard29.shape)
		objects.hazard29.fixture:setUserData("hazard")
		
		objects.hazard30 = {}
		objects.hazard30.body = love.physics.newBody(world, hazard30_x, hazard30_y)
		objects.hazard30.shape = love.physics.newRectangleShape(hazard_image:getWidth(), hazard_image:getHeight())
		objects.hazard30.fixture = love.physics.newFixture(objects.hazard30.body, objects.hazard30.shape)
		objects.hazard30.fixture:setUserData("hazard")
		
		love.graphics.setBackgroundColor(0, 0, 0)
		
	elseif current_level == 9 then
		game_state = 3
	end
end

function love.update(deltaTime)
	if game_state == 2 then
		if counter_running then
			timerCounter = timerCounter + deltaTime
		end
		world:update(deltaTime)
		x = objects.player.body:getX()
		y = objects.player.body:getY()
		--velocity = objects.player.body:getLinearVelocity()
		if love.keyboard.isDown("left") then
			objects.player.body:applyForce(-130,0)
		elseif love.keyboard.isDown("right") then
			objects.player.body:applyForce(130,0)
		end
	
		if objects.player.not_in_air == true and objects.player.touching_left_wall == false 
		and objects.player.touching_right_wall == false then
			jumpimpulse_x = 0
			jumpimpulse_y = -150
		elseif objects.player.not_in_air == false and objects.player.touching_left_wall  == true then
			jumpimpulse_x = 90
			jumpimpulse_y = -180
		elseif objects.player.not_in_air == false and objects.player.touching_right_wall == true then
			jumpimpulse_x = -90
			jumpimpulse_y = -180
		elseif objects.player.not_in_air == true and objects.player.touching_left_wall  == true then
			jumpimpulse_x = 90
			jumpimpulse_y = -180
		elseif objects.player.not_in_air == true and objects.player.touching_right_wall == true then
			jumpimpulse_x = -90
			jumpimpulse_y = -180
		else
			jumpimpulse_x = 0
			jumpimpulse_y = 0
		end
	
		if hasplayerhitstar then
			current_level = current_level + 1
			create_level(current_level, health)
		end
	
		if health <= 0 then
			create_level(current_level, 100)
			lives = lives - 1
		end
	
		if lives < 1 then
			game_state = 3
		end
	
		if health > 100 then
			health = 100
		end
	
		if player_out_of_screen() then
			lives = lives - 1
			create_level(current_level, 100)
		end
	
		if powerup_in_use == "Higher Jump" and objects.player.not_in_air then
			jumpimpulse_y = jumpimpulse_y - 75
		end
	
		if powerup_in_use == "Box Crush" then
			objects.player.fixture:setRestitution(0.1)
		end
	end
end

function love.draw()
	if game_state == 1 then
		love.graphics.draw(startup_image, 0, 0)
	elseif game_state == 2 then
		if powerup_in_use == "Box Crush" then
			love.graphics.setColor(250, 250, 14)
			love.graphics.circle("fill", x, y, objects.player.shape:getRadius() + 3)
		end
		if current_level == 1 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
		
			love.graphics.setColor(186, 163, 135)
			love.graphics.polygon("fill", objects.brick1.body:getWorldPoints(objects.brick1.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick2.body:getWorldPoints(objects.brick2.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick3.body:getWorldPoints(objects.brick3.shape:getPoints()))
		elseif current_level == 2 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
	
			love.graphics.setColor(186, 163, 135)
			love.graphics.polygon("fill", objects.brick4.body:getWorldPoints(objects.brick4.shape:getPoints()))
			love.graphics.setColor(223, 53, 22)
			love.graphics.polygon("fill", objects.box1.body:getWorldPoints(objects.box1.shape:getPoints()))
			love.graphics.polygon("fill", objects.box6.body:getWorldPoints(objects.box6.shape:getPoints()))
			love.graphics.setColor(213, 73, 62)
			love.graphics.polygon("fill", objects.box2.body:getWorldPoints(objects.box2.shape:getPoints()))
			love.graphics.polygon("fill", objects.box5.body:getWorldPoints(objects.box5.shape:getPoints()))
			love.graphics.setColor(203, 93, 102)
			love.graphics.polygon("fill", objects.box3.body:getWorldPoints(objects.box3.shape:getPoints()))
			love.graphics.polygon("fill", objects.box4.body:getWorldPoints(objects.box4.shape:getPoints()))
		elseif current_level == 3 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
			love.graphics.setColor(196, 173, 155)
			love.graphics.polygon("fill", objects.brick5.body:getWorldPoints(objects.brick5.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick6.body:getWorldPoints(objects.brick6.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick7.body:getWorldPoints(objects.brick7.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick8.body:getWorldPoints(objects.brick8.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick9.body:getWorldPoints(objects.brick9.shape:getPoints()))
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(hazard_image, hazard1_x, hazard1_y)
			love.graphics.draw(hazard_image, hazard2_x, hazard2_y)
			love.graphics.draw(hazard_image, hazard3_x, hazard3_y)
			love.graphics.draw(hazard_image, hazard4_x, hazard4_y) 	
			love.graphics.draw(hazard_image, hazard5_x, hazard5_y) 	
			love.graphics.draw(hazard_image, hazard6_x, hazard6_y) 
			love.graphics.draw(hazard_image, hazard7_x, hazard7_y) 	
		elseif current_level == 4 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.ground1.body:getWorldPoints(objects.ground1.shape:getPoints()))
			love.graphics.polygon("fill", objects.ground2.body:getWorldPoints(objects.ground2.shape:getPoints()))
			love.graphics.polygon("fill", objects.ground3.body:getWorldPoints(objects.ground3.shape:getPoints()))
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
			love.graphics.setColor(146, 123, 105)
			love.graphics.polygon("fill", objects.brick10.body:getWorldPoints(objects.brick10.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick11.body:getWorldPoints(objects.brick11.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick12.body:getWorldPoints(objects.brick12.shape:getPoints()))
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(hazard_image, hazard8_x, hazard8_y)
			love.graphics.draw(hazard_image, hazard9_x, hazard9_y)
			love.graphics.draw(hazard_image, hazard10_x, hazard10_y)
			if objects.healthpowerup1 then
				love.graphics.draw(healthpowerup_image, healthpowerup1_x, healthpowerup1_y)
			end
			if objects.jumppowerup1 then
				love.graphics.draw(jumppowerup_image, jumppowerup1_x, jumppowerup1_y)
			end
		elseif current_level == 5 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.ground4.body:getWorldPoints(objects.ground4.shape:getPoints()))
			love.graphics.polygon("fill", objects.ground5.body:getWorldPoints(objects.ground5.shape:getPoints()))
			love.graphics.polygon("fill", objects.ground6.body:getWorldPoints(objects.ground6.shape:getPoints()))
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(hazard_image, hazard11_x, hazard11_y)
			love.graphics.draw(hazard_image, hazard12_x, hazard12_y)
			love.graphics.draw(hazard_image, hazard13_x, hazard13_y)
			love.graphics.draw(hazard_image, hazard14_x, hazard14_y)
			love.graphics.setColor(192, 232, 211)
			love.graphics.polygon("fill", objects.brick13.body:getWorldPoints(objects.brick13.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick14.body:getWorldPoints(objects.brick14.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick15.body:getWorldPoints(objects.brick15.shape:getPoints()))
			if objects.jumppowerup2 then
				love.graphics.draw(jumppowerup_image, jumppowerup2_x, jumppowerup2_y)
			end
			if objects.crushpowerup1 then
				love.graphics.draw(crushpowerup_image, crushpowerup1_x, crushpowerup1_y)
			end
			if objects.box7 then
				love.graphics.setColor(250, 172, 14)
				love.graphics.polygon("fill", objects.box7.body:getWorldPoints(objects.box7.shape:getPoints()))
			end
		elseif current_level == 6 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
			love.graphics.setColor(192, 232, 211)
			love.graphics.polygon("fill", objects.brick16.body:getWorldPoints(objects.brick16.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick17.body:getWorldPoints(objects.brick17.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick18.body:getWorldPoints(objects.brick18.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick19.body:getWorldPoints(objects.brick19.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick20.body:getWorldPoints(objects.brick20.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick21.body:getWorldPoints(objects.brick21.shape:getPoints()))
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(hazard_image, hazard15_x, hazard15_y)
			love.graphics.draw(hazard_image, hazard16_x, hazard16_y)
			love.graphics.draw(hazard_image, hazard17_x, hazard17_y)
			love.graphics.draw(hazard_image, hazard18_x, hazard18_y)
			love.graphics.draw(hazard_image, hazard19_x, hazard19_y)
			love.graphics.draw(hazard_image, hazard20_x, hazard20_y)
			if objects.healthpowerup2 then
				love.graphics.draw(healthpowerup_image, healthpowerup2_x, healthpowerup2_y)
			end
			if objects.crushpowerup2 then
				love.graphics.draw(crushpowerup_image, crushpowerup2_x, crushpowerup2_y)
			end
			if objects.box8 then
				love.graphics.setColor(250, 172, 14)
				love.graphics.polygon("fill", objects.box8.body:getWorldPoints(objects.box8.shape:getPoints()))
			end
		elseif current_level == 7 then
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
			love.graphics.setColor(192, 232, 211)
			love.graphics.polygon("fill", objects.brick22.body:getWorldPoints(objects.brick22.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick23.body:getWorldPoints(objects.brick23.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick24.body:getWorldPoints(objects.brick24.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick25.body:getWorldPoints(objects.brick25.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick26.body:getWorldPoints(objects.brick26.shape:getPoints()))
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(hazard_image, hazard21_x, hazard21_y)
			love.graphics.draw(hazard_image, hazard22_x, hazard22_y)
			love.graphics.draw(hazard_image, hazard23_x, hazard23_y)
			love.graphics.draw(hazard_image, hazard24_x, hazard24_y)
		elseif current_level == 8 then
			love.graphics.setColor(70, 160, 10)
			love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
			love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))
			love.graphics.polygon("fill", objects.ground7.body:getWorldPoints(objects.ground7.shape:getPoints()))
			love.graphics.polygon("fill", objects.ground8.body:getWorldPoints(objects.ground8.shape:getPoints()))
			love.graphics.setColor(0, 0, 0)
			love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
			love.graphics.setColor(190, 40, 14)
			love.graphics.circle("fill", objects.player.body:getX(), objects.player.body:getY(), objects.player.shape:getRadius())
			love.graphics.setColor(192, 232, 211)
			love.graphics.polygon("fill", objects.brick27.body:getWorldPoints(objects.brick27.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick28.body:getWorldPoints(objects.brick28.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick29.body:getWorldPoints(objects.brick29.shape:getPoints()))
			love.graphics.polygon("fill", objects.brick30.body:getWorldPoints(objects.brick30.shape:getPoints()))
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(hazard_image, hazard25_x, hazard25_y)
			love.graphics.draw(hazard_image, hazard26_x, hazard26_y)
			love.graphics.draw(hazard_image, hazard27_x, hazard27_y)
			love.graphics.draw(hazard_image, hazard28_x, hazard28_y)
			love.graphics.draw(hazard_image, hazard29_x, hazard29_y)
			love.graphics.draw(hazard_image, hazard30_x, hazard30_y)
		end
	
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(star_image, star_x, star_y)
		love.graphics.print("Lives: " .. lives, 0, 0)
		love.graphics.print("LEVEL " .. current_level, 100, 0)
		love.graphics.print("Health: " .. math.ceil(health) .. "%", 200, 0)
		if objects.player.not_in_air or objects.player.touching_wall then
			love.graphics.print("ABLE TO JUMP", 300, 0)
		else
		love.graphics.print("UNABLE TO JUMP", 300, 0)
		end
		love.graphics.print("Powerup in use: " .. powerup_in_use, 450, 0)
		love.graphics.print("TIME: " .. math.floor(timerCounter), 660, 0)
	elseif game_state == 3 then
		love.graphics.draw(gameover_image, 0, 0)
		if lives == 0 then
			love.graphics.print("Unfortunately, you lost! But feel free to try again!", 200, 300)
			love.graphics.print("Your time before losing was: " .. timerCounter .. " seconds", 200, 370)
		else
			love.graphics.print("CONGRATULATIONS! You have won! Now go and rest, our heroes!", 200, 300)
			love.graphics.print("Your time was: " .. timerCounter .. " seconds", 200, 370)
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
        love.event.quit()
	elseif key == "return" and game_state == 1 then
		game_state = 2
		create_level(current_level, health)
	elseif key == "return" and game_state == 2 then
		create_level(current_level, health)
	elseif key == "return" and game_state == 3 then
		love.load()
	elseif key == " " and game_state == 2 then
		objects.player.body:applyLinearImpulse(jumpimpulse_x, jumpimpulse_y)
	end
end

function player_out_of_screen() 
	return x < 0 or x >= screenWidth or y < 0 or y >= screenHeight
end

function physicsBeginContact(a, b, coll)
	if game_state == 2 then
		objects.player.not_in_air = true
		local a_name = a:getUserData()
		local b_name = b:getUserData()
		if a_name ~= nil and b_name ~= nil then
			if (a_name == "player" and b_name == "ground") or (a_name == "ground" and b_name == "player") then
				objects.player.not_in_air = true
			end
			if (a_name == "player" and b_name == "brick") or (a_name == "brick" and b_name == "player") then
				objects.player.not_in_air = true
			end	
			--tarkistaa, osuiko pallo seinään, ja jos osui, mahdollistaa ns. "seinähypyn"
			if (a_name == "player" and b_name == "leftwall") or (a_name == "leftwall" and b_name == "player") then
				objects.player.touching_left_wall = true
			elseif (a_name == "player" and b_name =="rightwall") or (a_name == "rightwall" and b_name == "player") then
				objects.player.touching_right_wall = true
			end
			if (a_name == "player" and b_name == "star") or (a_name == "star" and b_name == "player") then
				hasplayerhitstar = true
			end
			if (a_name == "player" and b_name == "box") or (a_name == "box" and b_name == "player") then
				objects.player.not_in_air = true
			end
			if (a_name == "player" and b_name == "hazard") or (a_name == "hazard" and b_name == "player") then
				objects.player.not_in_air = true
				health = health - 12.5
			end
			if (a_name == "player" and b_name == "health") or (a_name == "health" and b_name == "player") then
				objects.player.not_in_air = true
				health = health + 50
				if current_level == 4 then
					objects.healthpowerup1.body:destroy()
					objects.healthpowerup1 = nil
				elseif current_level == 6 then
					objects.healthpowerup2.body:destroy()
					objects.healthpowerup2 = nil
				end
			end
			if (a_name == "player" and b_name == "jump") or (a_name == "jump" and b_name == "player") then
				objects.player.not_in_air = true
				powerup_in_use = "Higher Jump"
			
				if current_level == 4 then
					objects.jumppowerup1.body:destroy()
					objects.jumppowerup1 = nil
				elseif current_level == 5 then
					objects.jumppowerup2.body:destroy()
					objects.jumppowerup2 = nil
				end
			end
			if (a_name == "player" and b_name == "crush") or (a_name == "crush" and b_name == "player") then
				objects.player.not_in_air = true
				powerup_in_use = "Box Crush"
			
				if current_level == 5 then
					objects.crushpowerup1.body:destroy()
					objects.crushpowerup1 = nil
				elseif current_level == 6 then
					objects.crushpowerup2.body:destroy()
					objects.crushpowerup2 = nil
				end
			end
			if ((a_name == "player" and b_name == "bigbox") or (a_name == "bigbox" and b_name == "player")) and powerup_in_use == "Box Crush" then
				if current_level == 5 then
					objects.box7.body:destroy()
					objects.box7 = nil
				end
				if current_level == 6 then
					objects.box8.body:destroy()
					objects.box8 = nil
				end
			end
		end
	end
end

function physicsEndContact(a, b, coll)
	if (a_name == "player" and b_name == "hazard") or (a_name == "hazard" and b_name == "player") then
			objects.player.not_in_air = true
	end
	if (a_name == "player" and b_name == "box") or (a_name == "box" and b_name == "player") then
			objects.player.not_in_air = true
	end
	if (a_name == "player" and b_name == "bigbox") or (a_name == "bigbox" and b_name == "player") then
			objects.player.not_in_air = true
	end
	objects.player.not_in_air = false
	objects.player.touching_right_wall = false
	objects.player.touching_left_wall = false
end