function love.load()
    
    width, height = love.graphics.getDimensions();
    love.graphics.setDefaultFilter('nearest', 'nearest');
    love.graphics.setBackgroundColor(.5, .5, .5, 0);
    ground = 400;
    gravidade = .2;
    enemies = {
        x=40,
        y=400,
        img = love.graphics.newImage("assets/images/patrick.jpg"),
        angle = 0,
        sinTime=0
    }
    player = {
        x=120,
        y=400,
        angle=0,
        speed=2,
        vspd=0,
        hspd=1,
        img=love.graphics.newImage("assets/images/cachas.png"),
        frame=1
    }
end

function love.update()


    if love.keyboard.isDown('d') then

        player.x=player.x+player.speed
        player.angle=player.angle+lerp(player.angle, .1, .2);
    elseif love.keyboard.isDown('a') then

        player.x=player.x-player.speed
        player.angle=player.angle+lerp(player.angle, -.1, .2);
    else

        player.angle=player.angle+lerp(player.angle, 0, .2);
    end

    -- Increase Player Frame
    player.frame=player.frame+.1;
    if player.frame >= 3 then

        player.frame = 1;
    end

    player.vspd=player.vspd+gravidade;
    if player.y+player.vspd > ground then
        player.vspd=0;
        player.y=ground
    end
    player.y=player.y+player.vspd;

    -- Patrick Sine angle
    enemies.sinTime=(enemies.sinTime+math.pi*2/60)
    if enemies.sinTime>math.pi*2 then enemies.sinTime = 0 end
    enemies.angle=math.sin(enemies.sinTime)*math.pi*2/45
end

function love.draw()

    love.graphics.draw(player.img, love.graphics.newQuad(20*(math.floor(player.frame)-1), 0, 20, 20, player.img), player.x, player.y, player.angle, 2, 2, 10, 20);
    love.graphics.draw(enemies.img, enemies.x, enemies.y, enemies.angle, .3, .3, enemies.img:getWidth()/2, enemies.img:getHeight());
end

function lerp(from, to, multi)

    return (to-from)*multi;
end

function love.keypressed(key, scancode, isrepeat)

    if (key == 'space' and player.y == ground) then
        
        player.vspd = -5;
    end
end