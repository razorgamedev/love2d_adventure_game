local Level = require "scenes/scene" .New "Level"

function Level:OvInit()
    local map = require "scenes/Tile_Map".New "assets/map_1"

    local e = Game.World:Create_Entity "player"
    e:Add(require "components/c_sprite" .New(), {type = "rect"})
    e:Add(require "components/c_body" .New(), {x = 50, y = 50, w = 16, h = 16})
    e:Add(require "components/c_physics".New(), {friction = .85})
    e:Add(require "components/c_player".New(), {})
    e:Add(require "components/c_camera_follow".New(), {})
end

function Level:OvRender()
end

return Level