--[[
    Your love2d game start here
]]

require("player")
require("ball")
require("opponent")

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    Player:load()
    Ball:load()
    Opponent:load()
end

function love.update(dt)
    Player:update(dt)
    Ball:update(dt)
    Opponent:update(dt)
end


function love.draw()
    Player:draw()
    Ball:draw()
    Opponent:draw()
    
end

function checkCollision(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and
    a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end

