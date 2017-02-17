local GSM = {}

local push, pop = table.insert, table.remove

function GSM:Init()
    self.scenes = {}
end

function GSM:GotoScene(scene)
    if #self.scenes > 0 then
        self.scenes[#self.scenes]:Destroy()
        pop(self.scenes, #self.scenes)
    end

    scene:Init()
    push(self.scenes, scene)
end

return GSM