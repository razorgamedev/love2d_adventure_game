local component = require "components/component"

local C_Body = {
New = function()
    local c_body = component.New "body"

    function c_body.Init(e, args)
        e.Position = V2:New(args.x, args.y)
        e.Size = V2:New(args.w, args.h)

        function e:Intersects(e2)
            if (e2.Position == nil)then return false end
            return  self.Position.x + self.Size.x > e2.Position.x and
                    self.Position.x < e2.Position.x + e2.Size.x   and
                    self.Position.y + self.Size.y > e2.Position.y and
                    self.Position.y < e2.Position.y + e2.Size.y
        end
    end

    return c_body
end
}
return C_Body