local UUID = 0

local function new_uuid()
    UUID = UUID + 1
    return UUID - 1
end

local Entity = {
New = function (_id)
    local entity = {}

    entity.ID           = id
    entity.UUID         = new_uuid()
    entity.Remove       = false
    entity.Components   = {}

    function entity:OvInit()    end
    function entity:OvUpdate(dt)end
    function entity:OvRender()end
    function entity:OvDestroy() end

    function entity:Init()
        Game.GameLoop:AddLoop(self)
        Game.Renderer:AddEntity(self)
        self:OvInit()
    end

    function entity:Add(component, args)
        self.Components[component.ID] = component 
        component.Init(self, args)
    end

    function entity:Get(_id)
        assert(self.Components[_id], "ERROR::ENTITY::GET entity does not contain the component " .. _id)
        return self.Components[_id]
    end

    function entity:Requires(r)
        for k,v in pairs(r) do
            assert(self.Components[v], "ERROR::ENTITY:: missing required components!")
        end
    end

    function entity:Update(dt)
        self:OvUpdate(dt)

        for i, v in pairs(self.Components) do
            v.Update(self, dt)
        end
    end

    function entity:Render()
        self:OvRender()
        for i, v in pairs(self.Components) do
            v.Render(self)
        end
    end

    function entity:Destroy()
        Game.GameLoop:RemoveLoop(self)
        Game.Renderer:RemoveRenderer(self)
        self:OvDestroy()
    end

    return entity
end
}

return Entity