Opponent = {}


function Opponent:load()
    self.img = love.graphics.newImage("assets/2.png")
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()

    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2 -- Center the player vertically

    self.yVelocity = 0
    self.speed = 500

    self.timer = 0
    self.rate = 0.5
end

function Opponent:update(dt)
    self:move(dt)
    self.timer = self.timer + dt
    if self.timer > self.rate then -- to delay "AI" decision making
        self.timer = 0
        self:acquireTarget()
    end
    self:checkBoundaries()
end

function Opponent:move(dt)
    self.y = self.y + self.yVelocity * dt

end

function Opponent:acquireTarget()
    if Ball.y + Ball.height < self.y then -- if ball is above the opponent
        self.yVelocity = -self.speed 
    elseif Ball.y > self.y + self.height then -- if ball is below the opponent
        self.yVelocity = self.speed
    else
        self.yVelocity = 0
    end
end
    
function Opponent:draw()
    love.graphics.draw(self.img, self.x, self.y)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Opponent:checkBoundaries() 
    -- LIMIT OPPONENT MOVEMENT TO WITHIN BOUNDARY
    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end -- Comment: There should be a better way to do this without copying code from player.lua