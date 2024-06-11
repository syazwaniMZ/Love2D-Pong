Ball = {}

function Ball:load()
    self.img = love.graphics.newImage("assets/ball.png")

    self.width = self.img:getWidth()
    self.height = self.img:getHeight()

    self.x = love.graphics.getHeight() / 2 -- Center the player horizontally
    self.y = love.graphics.getHeight() / 2 -- Center the player vertically

    self.speed = 200
    self.xVelocity = -self.speed
    self.yVelocity = -0
end

function Ball:update(dt)
    self:move(dt)
    self:collide()
end

function Ball:collide()
    self:collideWall()
    self:collideOpponent()
    self:collidePlayer()
    self:score()
end

function Ball:collideWall()
    -- CHECK TOP AND BOTTOM BOUNDARY
    if self.y < 0 then
        -- if the ball hit the top boundary
        self.y = 0
        self.yVelocity = -self.yVelocity
        
    elseif self.y + self.height > love.graphics.getHeight() then
        -- if the ball hit the bottom boundary
        self.y = love.graphics.getHeight() - self.height
        self.yVelocity = -self.yVelocity
    end
end

function Ball:collidePlayer()
    if checkCollision(self, Player) then
        self.xVelocity = self.speed -- bounce back to right
        local middleBall = self.y + self.height /2
        local middlePlayer = Player.y + Player.height /2
        local collisionPosition = middleBall - middlePlayer
        self.yVelocity = collisionPosition * 5
        
        love.audio.play(bounce)
    end
end

function Ball:collideOpponent()
    if checkCollision(self, Opponent) then
        self.xVelocity = -self.speed -- bounce back to left
        local middleBall = self.y + self.height /2
        local middleOpponent = Opponent.y + Opponent.height /2
        local collisionPosition = middleBall - middleOpponent
        self.yVelocity = collisionPosition * 5

        love.audio.play(bounce)
    end
end

function Ball:score()
    if self.x < 0 then -- if the ball hit left boundary
        self:resetPosition(1)
        Score.opponent = Score.opponent + 1
    end

    -- if the ball hit right boundary then send ball to player
    if self.x > love.graphics.getWidth() then 
        self:resetPosition(-1)
        Score.player = Score.player + 1
    end
end

function Ball:resetPosition(modifier)
    self.x = love.graphics.getWidth() / 2 - self.width /2
    self.y = love.graphics.getHeight() / 2 - self.height/2
    self.yVelocity = 0
    self.xVelocity = self.speed *modifier
end


function Ball:move(dt)
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
end


function Ball:draw()
    love.graphics.draw(self.img, self.x, self.y)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end