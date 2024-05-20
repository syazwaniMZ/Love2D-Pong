--[[
    Your love2d game start here
]]

require("player")
require("ball")
require("opponent")
require("background")

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    Background:load()
    Player:load()
    Ball:load()
    Opponent:load()

    Score = {player = 0, opponent= 0}
    font = love.graphics.newFont(30)
end

function love.update(dt)
    Background:update(dt)
    Player:update(dt)
    Ball:update(dt)
    Opponent:update(dt)
end


function love.draw()
    Background:draw()
    Player:draw()
    Ball:draw()
    Opponent:draw()
    drawScore()
end

function drawScore()
    love.graphics.setFont(font)
    love.graphics.print("Player: " .. Score.player, 50, 50)
    love.graphics.print("Opponent: " .. Score.opponent, 1000, 50)
end

function checkCollision(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and
    a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end

