local draw = love.graphics.draw

local Tile_Map = {
New = function(path)
    local map = Reloader:require(path)

    local layers = map.code.layers
    for i, layer in ipairs(layers) do
        if (layer.type == "objectgroup") then
            
            for j, object in ipairs(layer.objects) do
                if object.type == "" then
                    Game.Physics:Add_Static_Body({
                        position = {x = object.x, y = object.y},
                        size = {x = object.width, y = object.height}
                    })
                end
            end

        end
    end

    function map:Render()
        local image = Game.Assets:GetAsset (map.code.tilesets[1].name)
        assert(image, "ERROR::TILEMAP::RENDER cant find the image " .. map.code.tilesets[1].name)

        local quads = Game.Assets:GetAsset(map.code.tilesets[1].name .. "_quads")
        assert(quads)

        for i, layer in ipairs(self.code.layers) do
            if (layer.type == "tilelayer") then
                for y = 0, layer.height - 1 do
                    for x = 0, layer.width - 1 do
                        local id = layer.data[(x + y * layer.width) + 1]

                        if (id ~= 0) then
                            draw(image, quads[id], x * self.code.tilewidth, y * self.code.tileheight)
                        end
                    end
                end
            end
        end
    end

    Game.Renderer:AddRenderer(map,2)

    return map
end
}

return Tile_Map