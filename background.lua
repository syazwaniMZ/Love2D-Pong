Background = {}

function Background:load()
    self.universe = love.graphics.newImage("assets/clouds.png")
    self.dust = love.graphics.newImage("assets/dust.png")
    self.width = self.dust:getWidth()
    self.height = self.dust:getHeight()
    self.rotation = 0
end

function Background:update(dt)
    self.rotation = self.rotation + 0.05 * dt
end

function Background:draw()
    love.graphics.draw(self.universe, 0, 0)
    love.graphics.draw(self.dust, self.width/2, self.height/2 , self.rotation, 1, 1, self.width/2, self.height /2)
end