local Scene = {
New = function(_id)
    local  scene = {__module="scene"}

    scene.ID = _id

    function scene:OvInit()     end
    function scene:OvUpdate(dt) end
    function scene:OvRender()   end
    function scene:OvDestroy()  end

    function scene:Init()
        Game.GameLoop:AddLoop(self)
        Game.Renderer:AddRenderer(self, 1)
        self:OvInit()
    end

    function scene:Update(dt)
        self:OvUpdate(dt)
    end

    function scene:Render()
        self:OvRender()
    end

    function scene:Destroy()
        Game.GameLoop:RemoveLoop(self)
        Game.Renderer:RemoveRenderer(self, 1)
        self:OvDestroy()
    end

    return scene
end
}

return Scene