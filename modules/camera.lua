local Camera = {
    Position = {x = 0, y = 0},
    timer = 0,
}

function Camera:Set()
    love.graphics.push()
    love.graphics.translate(-self.Position.x, -self.Position.y)
end

function Camera:Unset()
    love.graphics.pop()
end

function Camera:Update(dt)
end

return Camera