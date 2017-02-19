local component = require "components/component"

local C_Physics = {
New = function()
    local c_physics = component.New "physics"

    function c_physics.Init(e, args)
        assert(e.Position)

        Game.Physics:Add_Body(e, args)
    end

    return c_physics
end
}
return C_Physics