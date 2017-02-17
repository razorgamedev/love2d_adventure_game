local Component = {
New = function(_id)
    local component = {}
    
    assert(_id, "ERROR::COMPONENT::NEW component requires an id!")
    component.ID = _id

    function component.Init(e, args)    end
    function component.Update(e, dt)    end
    function component.Render(e)        end
    function component.Destroy(e)       end

    return component
end
}
return Component