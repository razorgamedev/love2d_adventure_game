local GameLoop = {}

local push, pop = table.insert, table.remove

function GameLoop:Init()
    self.tickers = {}
end

function GameLoop:AddLoop(obj)
    assert(obj.Update, "ERROR::GAMELOOP::ADDLOOP obj does not have an update function!")
    push(self.tickers, obj)
end

function GameLoop:RemoveLoop(dt)
    for i = #self.tickers, 1, -1 do
        if self.tickers[i] == obj then
            pop(self.tickers, obj)
            return
        end
    end
end

function GameLoop:Update(dt)
    for i = 1, #self.tickers do
        self.tickers[i]:Update(dt)
    end
end

return GameLoop