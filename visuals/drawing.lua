local drawing = {}
drawing.__index = function(self, key)
    if rawget(self, "_children") and self._children[key] then
        return self._children[key]
    end
    return drawing[key]
end

local function apply_props(inst, props)
    if not props then return end
    for key, value in pairs(props) do
        inst[key] = value
    end
end

function drawing.new(class_name, props, children)
    local self = setmetatable({}, drawing)
    self.instance = Instance.new(class_name)
    apply_props(self.instance, props)
    self._children = create_children(self.instance, children)
    return self
end

function drawing:set(prop, value)
    self.instance[prop] = value
    return self
end

function drawing:parent(parent)
    self.instance.Parent = parent
    return self
end

function drawing:child(name, class_name, props)
    local child_inst = Instance.new(class_name)
    apply_props(child_inst, props)
    child_inst.Parent = self.instance
    self._children[name] = child_inst
    return self
end

function drawing:show()
    self.instance.Visible = true
    return self
end

function drawing:hide()
    self.instance.Visible = false
    return self
end

function drawing:destroy()
    self.instance:Destroy()
    return nil
end

return drawing
