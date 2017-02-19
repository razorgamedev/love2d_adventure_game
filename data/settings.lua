return {
    hello = 100,
    x = 50,
    timer = 0,

    Draw = function(self)
        love.graphics.setColor(255, 10, 0, 255)
        love.graphics.rectangle("fill", self.x + math.cos(self.timer) * 10, 10 + math.sin(self.timer) * 10, 25, 25)
        love.graphics.setColor(255, 255, 255, 255)

        self.timer = self.timer + 0.0016 * 100
    end
}