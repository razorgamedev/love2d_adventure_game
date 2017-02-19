local component = require "components/component"

local C_Player = {
New = function()
    local c_player = component.New "physics"

    function c_player.Init(e, args)
        e.Speed = 5
    end

    function c_player.Update(e, dt)

        if love.keyboard.isDown "right" then
            e:Apply_Velocity(e.Speed, math.rad(0))
        end

        if love.keyboard.isDown "left" then
            e:Apply_Velocity(e.Speed, math.rad(180))
        end

        if love.keyboard.isDown "up" then
            e:Apply_Velocity(e.Speed, math.rad(270))
        end

        if love.keyboard.isDown "down" then
            e:Apply_Velocity(e.Speed, math.rad(90))
        end

    end

    return c_player
end
}
return C_Player