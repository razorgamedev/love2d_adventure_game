local Assets = {}

function Assets:Init()
    self.assets = {}
end

function Assets:AddAsset(a, id)
    self.assets[id] = a
end

function Assets:GetAsset(id)
    local a = self.assets[id]
    assert(a, "ERROR::ASSETS::GETASSET cannot find the asset "..id)
    return a
end

function Assets:Generate_Quads(size, image, id)
    local w = math.floor(image:getWidth() / size)
    local h = math.floor(image:getHeight() / size)
    local quads = {}

    self:AddAsset(quads, id)

    for y = 0, h - 1 do
        for x = 0, w - 1 do
            table.insert(quads, 
                love.graphics.newQuad(x * size, y * size, size, size, image:getWidth(), image:getHeight())
            )
        end
    end

    return quads
end

return Assets