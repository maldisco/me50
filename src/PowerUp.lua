PowerUp = Class{}

function PowerUp:init()
    self.x = math.random(20, VIRTUAL_WIDTH - 20)
    self.y = 50
    self.width = 16
    self.height = 16

    self.dy = 25

    self.timer = 0
    self.interval = 10
    self.active = false
end

function PowerUp:update(dt)
    if self.active then
        self.y = self.y + self.dy * dt

        if self.y > VIRTUAL_HEIGHT then
            self.active = false
        end
    end

    if not self.active then
        self.timer = self.timer + dt
        if self.timer > self.interval then
            self.active =  true
            self.y = 50
            self.x = math.random(20, VIRTUAL_WIDTH - 20)
            self.timer = 0
        end
    end
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function PowerUp:render()
    if self.active then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][1],
            self.x, self.y)
    end
end