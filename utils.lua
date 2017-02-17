local sqrt      = math.sqrt
local pow       = math.pow
local insert    = table.insert
local remove    = table.remove

function _G.print_t ( t ) 
    -- assert(t.__const == false, "ERROR:: cannot print constant table")

    local print_o_cache={}
    local function sub_print_o(t,indent)
        if (print_o_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_o_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent..pos.." = "..tostring(t).." {")
                        sub_print_o(val,indent.."  ")
                        print(indent.."  ".."}")
                    elseif (type(val)=="string") then
                        print(indent..pos..' = "'..val..'"')
                    else
                        print(indent..pos.." = "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_o(t,"  ")
        print("}")
    else
        sub_print_o(t,"  ")
    end
    print()
end

function _G.using_t(self, other)
    local t1 = self
    local t2 = new_t(other)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                using_t(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

function _G.new_t(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[new_t(orig_key)] = new_t(orig_value)
        end
        setmetatable(copy, new_t(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function _G.enum_t(table)
    local en = {}
    for i = 1, #table do
        en[table[i]] = i
    end
    return en
end

function _G.const_t (table)
    return setmetatable({}, {
        __const = true,
        __index = table,
        __newindex = function(table, key, value)
                error("Cannot modify the constant table:  " .. tostring(table))
            end,
        __metatable = false
        })
end

function string.tokenize(self, delim, bad)
    local word = ""
    local tokens = {}
    for i = 1, #self do
        local char = self:sub(i, i)

        if delim:find(char, 1, true) then
            if #word > 0 then
                table.insert(tokens,word)
            end
            word = ""
            if not bad:find(char, 1, true) then
                table.insert(tokens, char)
            end
        else
            if not bad:find(char, 1, true) then
                word = word .. char
            end
        end

    end

    return tokens
end

_G.V2 = {
    New = function(self,x, y)
        local v = new_t(self)
        v.x = x or 0
        v.y = y or 0
        return v
    end,

    x = 0, y = 0,

    Add     = function(self, o) self.x = self.x + o.x; self.y = self.y + o.y  end,
    Add_n   = function(self, n) self.x = self.x + n; self.y = self.y + n      end,
    Sub     = function(self, o) self.x = self.x - o.x; self.y = self.y - o.y  end,
    Sub_n   = function(self, n) self.x = self.x - n; self.y = self.y - n      end,
    Mub     = function(self, o) self.x = self.x * o.x; self.y = self.y * o.y  end,
    Mul_n   = function(self, n) self.x = self.x * n; self.y = self.y * n      end,
    Div     = function(self, o) self.x = self.x / o.x; self.y = self.y / o.y  end,
    Div_n   = function(self, n) self.x = self.x / n; self.y = self.y / n      end,

    Length = function(self)
        return sqrt((self.x*self.x) + (self.x*self.x))
    end,

    Norm = function(self)
        local new = new_t(V2)
        local len = self:Length()
        self.x = self.x / len
        self.y = self.y / len
    end
}