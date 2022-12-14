--[[
    GD50 2018
    Pong Remake

    -- Ball Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a ball which will bounce back and forth between paddles
    and walls until it passes a left or right boundary of the screen,
    scoring a point for the opponent.
]]

Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    self.dy = 0
    self.dx = 0
end

--[[
    Expects a paddle as an argument and returns true or false, depending
    on whether their rectangles overlap.
]]
function Ball:collides(paddle, dt)
    -- If we use the 'predictive' collision code with ball speeds that are too low we can 'save' the ball by moving the paddle
    -- over the ball in near miss scenarios. This code should prevent that from happening.
    if math.abs(self.dx) > 700 then
        if paddle.x == 10 then
            -- Since there is a bug causing the game to miss collisions at high speeds.
            -- we want to check if a collision will occur in the next frame.
            if self.x + self.dx * dt < paddle.x then
                if self.y + self.height > paddle.y and self.y < paddle.y + paddle.height then
                    return true
                end
            end
        else
            if self.x + self.dx * dt > paddle.x then
                if self.y + self.height > paddle.y and self.y < paddle.y + paddle.height then
                    return true
                end
            end
        end
    end

    

    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

--[[
    Places the ball in the middle of the screen, with no movement.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end