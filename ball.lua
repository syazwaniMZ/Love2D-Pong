Ball = {}

function Ball:load()
    self.x = love.graphics.getHeight() / 2 -- Center the player horizontally
    self.y = love.graphics.getHeight() / 2 -- Center the player vertically
    self.width = 20
    self.height = 20
    self.speed = 200
    self.xVelocity = -self.speed
    self.yVelocity = -0
end

function Ball:update(dt)
    self:move(dt)
    self:collide()
end

function Ball:collide()
    if checkCollision(self, Player) then
        self.xVelocity = self.speed -- bounce back to right
        local middleBall = self.y + self.height /2
        local middlePlayer = Player.y + Player.height /2
        local collisionPosition = middleBall - middlePlayer
        self.yVelocity = collisionPosition * 5
    end

    if checkCollision(self, Opponent) then
        self.xVelocity = -self.speed -- bounce back to left
        local middleBall = self.y + self.height /2
        local middleOpponent = Opponent.y + Opponent.height /2
        local collisionPosition = middleBall - middleOpponent
        self.yVelocity = collisionPosition * 5
    end

    -- CHECK TOP AND BOTTOM BOUNDARY
    if self.y < 0 then
        -- check if the ball hit the top boundary
        self.y = 0
        self.yVelocity = -self.yVelocity
        
    elseif self.y + self.height > love.graphics.getHeight() then
        -- check if the ball hit the bottom boundary
        self.y = love.graphics.getHeight() - self.height
        self.yVelocity = -self.yVelocity
    end

    -- If outside boundary, send to center
    if self.x < 0 then -- check if the ball hit left boundary
        self.x = love.graphics.getWidth() / 2 - self.width /2
        self.y = love.graphics.getHeight() / 2 - self.height/2
        self.yVelocity = 0
        self.xVelocity = self.speed
    end

    -- check if the ball hit right boundary then send ball to player
    if self.x > love.graphics.getWidth() then 
        self.x = love.graphics.getWidth() / 2 - self.width /2
        self.y = love.graphics.getHeight() / 2 - self.height/2
        self.yVelocity = 0
        self.xVelocity = -self.speed
    end

end

function Ball:move(dt)
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
    
end


function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end