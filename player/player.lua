--[[
     Author: FileEX (Discord: FileEX#3656)
]]
player.Player = {}

setmetatable(player.Player, {
    __index = player.Player,
    __call = function(obj,...)
        return obj.__constructor(...);
    end,
});

player.Player.ID = 0;

function player.Player.setID()
    player.Player.ID = player.Player.ID + 1;
    return 'player.Player.__'..player.Player.ID;
end

function player.Player.__constructor()
    local this = setmetatable({},player.Player)
    local _id = player.Player.setID()

    this.getID = function()
    return _id;
    end

    local _properties = {};
    _properties[_id] = {};
    -- what properties can be manipulated
    local _availableProperties = {x=true,y=true,width=true,height=true,setVolume=true,stopSound=true,loop=true,throttled=true,nextSound=true,path=true,volume=true,speed=true,playlist=true,playlistIndex=true};
    local _attributes = {};
    _attributes[_id] = {};

    this.setProperty = function(id,property,value)
        if id and _properties[id] and property and value and _availableProperties[property] then
            _properties[id][property] = value;
        end
            return _properties[id][property]
    end

    this.getProperty = function(id,property)
        if id and _properties[id] and property and _availableProperties[property] then
            return _properties[id][property];
        end
    end

    this.setProperties = function(id,property)
    if id and _properties[id] and property then
    local k,v = next(property);
        while k do
        this.setProperty(id,k,v);
        k,v = next(property,k);
            end
        end
    end
    -- default properties
    this.setProperties(_id,{
    x = 0,
    y = 0,
    width = 50,
    height = 50,
    setVolume = false,
    stopSound = true,
    loop = false,
    throttled = false,
    nextSound = false,
    path = nil,
    volume = 1.0,
    speed = 1.0,
    playlist = false,
    playlistIndex = 1,
    });

    this.setAttribute = function(id,attribute,value)
        if _attributes[id] and attribute then
            _attributes[id][attribute] = value;
        end
    end

    this.getAttribute = function(id,attribute)
        if _attributes[id] and attribute then
            return _attributes[id][attribute];
        end
    end

    this.setAttributes = function(id,attribute,value)
        if _attributes[id] and attribute then
            local k,v = next(attribute);
                while k do
                    this.setAttribute(id,k,v);
                    k,v = next(attribute,k);
            end
        end
    end
    -- default attributes
    this.setAttributes(_id, {
        played = false,
        stopped = false,
        muted = false,
        sound = nil,
        op = 1,
        autostart = true,
        setIndex = false,
        _width = 200, -- default minimum width
        _height = 60, -- default minimum height
        openSound = false,
        xp = 0,
        volumeBarWidth = 0,
        isRadio = false,
        settingsRot = 0,
        tick = false,
        openSettings = false,
    });

    this.destructor = function(id)
        if id then
            if _properties[id] then
                player.Player.ID = player.Player.ID - 1;
                _properties[id] = _properties[#_properties];
                _attributes[id] = _attributes[#_attributes];
                _properties[#_properties] = nil;
                _attributes[#_attributes] = nil;
            end
        end
    end

    return this;
end
