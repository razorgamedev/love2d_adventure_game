_G.Reloader = {
    files = {},
    timer = 0
}

local write_time = love.filesystem.getLastModified

local function make_file_handle(file)
    local time, err = write_time(file .. ".lua")
        
    return {
        path = file,
        code = require(file),
        last_write_time = time,
        current_write_time = time
    }
end

function Reloader:require(path)
    local handle = make_file_handle(path)
    
    table.insert(self.files, handle)

    return handle
end

-- function Reloader:Handle(code)
--     for i, v in ipairs(self.files) do
--         if code == v.code then
--             v.code = code
--         end
--     end
-- end

function Reloader:Update(time)
    local time = time or 1

    self.timer = self.timer + 1
    if (self.timer % time ~= 0) then return end 

    -- print ("checking!", math.random())

    for i, v in ipairs(self.files) do
        v.current_write_time = write_time(v.path .. ".lua")
        if (v.current_write_time > v.last_write_time) then
            --reload
            print "Reloading!"

            local ok, chunk = pcall(love.filesystem.load, v.path .. ".lua")

            if not (ok) then
                print ("error: "..tostring(chunk))
            else
                v.code = chunk()
            end

            -- v.code = require (v.path)
            v.last_write_time = v.current_write_time
        end

    end

end