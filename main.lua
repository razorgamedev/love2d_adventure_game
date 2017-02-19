require "utils"
require "modules/live"

_G.DEBUG = true

local s = Reloader:require "data/settings"

_G.Game = {
    GameLoop = require "modules/gameloop",
    Renderer = require "modules/renderer",
    World    = require "modules/entity_world",
    GSM      = require "modules/game_scene_manager",
    Assets   = require "modules/assets",
    Physics  = require "modules/physics_engine",
    Camera   = Reloader:require( "modules/camera"),

    Canvas   = love.graphics.newCanvas(160, 144),
}

function love.load()
    Game.GameLoop:Init()
    Game.Renderer:Init()
    Game.World:Init()
    Game.Assets:Init()
    Game.GSM:Init()

    Game.Physics:Init()

    Game.Canvas:setFilter("nearest","nearest")

    Game.Assets:AddAsset(love.graphics.newImage "assets/tiles.png", "tiles")
    Game.Assets:Generate_Quads(8, Game.Assets:GetAsset "tiles", "tiles_quads")

    local font = love.graphics.newFont(16)
    love.graphics.setFont(font)

    Game.GSM:GotoScene(require "scenes/level_1")
end

function love.update(dt)
    Game.GameLoop:Update(dt)
    Game.World:Update(dt)

    Game.Camera.code:Update(dt)

    Reloader:Update(10)

    if love.keyboard.isDown "escape" then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setColor( 255, 255, 255, 255)
    Game.Camera.code:Set()
    love.graphics.setCanvas(Game.Canvas)
    love.graphics.clear()

    Game.Renderer:Render()
    if (s.code.is_debug) then
        Game.Physics:Debug_Render()
    end

    love.graphics.setCanvas()
    Game.Camera.code:Unset()
    
    local scale = love.graphics.getWidth() / Game.Canvas:getWidth()
    love.graphics.draw(Game.Canvas, 0, 0, 0, scale, scale)

    -- renders fps
    love.graphics.setColor(100, 100, 100, 255)
    love.graphics.rectangle("fill", 0, 0, 40, 40)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(love.timer.getFPS(), 10, 10)

end