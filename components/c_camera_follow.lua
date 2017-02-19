local component = require "components/component"

local C_Camera_Follow = {
New = function()
    local c_camera_follow = component.New "camera"

    function c_camera_follow.Init(e, args)
        assert(e.Position)

        e.camera_smoothing = args.camera_smoothing or 0.08
    end

    function c_camera_follow.Update(e, dt)

        local camera = Game.Camera.code

        local w = Game.Canvas:getWidth()
        local h = Game.Canvas:getHeight()
        
        local delta_x = camera.Position.x - (e.Size.x / 2 + e.Position.x - w / 2)
        local delta_y = camera.Position.y - (e.Size.y / 2 + e.Position.y - h / 2)

        camera.Position.x = math.floor(camera.Position.x - (delta_x * e.camera_smoothing))
        camera.Position.y = math.floor(camera.Position.y - (delta_y * e.camera_smoothing))

    end

    return c_camera_follow
end
}
return C_Camera_Follow