local component = require "components/component"
local rect = love.graphics.rectangle

local C_Sprite = {
New = function()
    local c_sprite = component.New "sprite"

    function c_sprite.Init(e, args)
        e.Draw_Type = args.type or "rect"
    end

    function c_sprite.Render(e)
        if e.Draw_Type == "rect" then
            rect("fill", e.Position.x, e.Position.y, e.Size.x, e.Size.y)
        end
    end

    return c_sprite
end
}
return C_Sprite