local Renderer = {}

local push, pop = table.insert, table.remove

function Renderer:Init(num_layers)
    self.renderers = {}
    for i = 0, (num_layers or 7) - 1 do
        push(self.renderers, {})
    end
end

function Renderer:AddEntity(obj)
    assert(obj.Render, "ERROR::RENDERER::ADDENTITY entity does not have a render function!")
    obj.__render_layer = math.floor(#self.renderers / 2)
    push(self.renderers[
        math.floor(#self.renderers / 2)
    ], obj)
end

function Renderer:AddRenderer(obj, layer)
    assert(obj.Render, "ERROR::RENDERER::ADDRENDERER object does not have a render function!")
    obj.__render_layer = layer
    push(self.renderers[layer], obj)
end

function Renderer:RemoveRenderer(obj)
    assert(obj.__render_layer, "ERROR::RENDERER::REMOVERENDERER object does not exist in the renderer!")
    for i = 1, #self.renderers[obj.__render_layer] do
        if (self.renderers[obj.__render_layer][i] == obj) then
            pop(self.renderers[obj.__render_layer], i); return
        end
    end
end

function Renderer:Render()
    for i, layer in ipairs(self.renderers) do
        for j = 1, #layer do
            layer[j]:Render()
        end
    end
end

return Renderer