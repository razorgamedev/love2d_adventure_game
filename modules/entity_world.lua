local Entity_World = {}
local push, pop = table.insert, table.remove

local Entity = require "entities/entity"

function Entity_World:Init()
    self.entities = {}
    Game.GameLoop:AddLoop(self)
end

function Entity_World:Create_Entity(_id)
    local e = Entity.New(_id)
    e:Init()
    push(self.entities, e)
    return e
end

function Entity_World:Update(dt)
    for i = #self.entities, -1, 1 do
        if self.entities[i].Remove then
            pop(self.entities, i)
        end
    end
end

return Entity_World