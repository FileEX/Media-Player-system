--[[
    Author: FileEX
]]
local screen = Vector2(guiGetScreenSize());
player.media = {};

setmetatable(player.media,{
    __index = player.media,
    __call = function(obj,...)
        return obj.__constructor(...);
    end,
});

local textures = {"start","pause","next","volume","mute_volume","settings"};
local tx = {};
local from,to

function player.media.__constructor()
    local this = player.Player();
    local id = this.getID();

    for kk,vv in pairs(textures) do
        tx[kk] = DxTexture("resources/"..vv..".png","argb",false,"clamp");
    end

    this.isSound = function(id)
        if id then
            if this.getAttribute(id,'sound') ~= nil then
                return this.getAttribute(id,'sound')
            else
                return false;
            end
        end
    end

    this.startSound = function(id,path,loop,throttled,autostart)
        if id and path then
            local autostart = autostart ~= nil and autostart or false;
            local loop = loop ~= nil and loop or false;
            local throttled = throttled ~= nil and throttled or false;
            if type(path) == "string" then
            sound = Sound(path,loop,throttled);
            elseif type(path) == "table" then
            this.setAttribute(id,'setIndex',false);
            sound = Sound(this.getProperty(id,'playlist')[this.getProperty(id,'playlistIndex')][1],loop,throttled);
            end
            sound.volume = this.getProperty(id,'volume');
            sound.speed = this.getProperty(id,'speed');
            this.setProperty(id,'path',path);
            this.setAttribute(id,'sound',sound);
            this.setAttribute(id,'op',2);
            this.setAttribute(id,'autostart',autostart);
            this.setAttribute(id,'played',true);
            this.setAttribute(id,'stopped',false);
            if not autostart then
                this.setMediaPause(id,true);
            end
        end
    end

    this.setVolume = function(id,vol)
        if id then
            local snd = this.isSound(id);
                if snd then
                    snd.volume = vol;
                end
            return this.setProperty(id,'volume',vol);
        end
    end

    this.getVolume = function(id)
        if id then
            return this.getProperty(id,'volume');
        end
    end

    this.setPath = function(id,path)
        if id then
            local snd = this.isSound(id);
                if snd then
                    snd:destroy();
                    this.startSound(id,path,this.getProperty(id,'loop'),this.getProperty(id,'throttled'),this.getAttribute(id,'autostart'));
                end
            return this.setProperty(id,'path',path);
        end
    end

    this.getPath = function(id)
        if id then
            return this.getProperty(id,'path');
        end
    end

    this.setLoop = function(id,loop)
        if id and loop then
            local snd = this.isSound(id);
                if snd then
                    snd:destroy();
                    this.startSound(id,this.getProperty(id,'path'),loop,this.getProperty(id,'throttled'),this.getProperty(id,'autostart'));
                end
            return this.setProperty(id,'loop',loop);
        end
    end

    this.getLoop = function(id)
        if id then
            return this.getProperty(id,'loop');
        end
    end

    this.setMediaPause = function(id,pause)
        if id then
            if this.isSound(id) then
            if pause then
                if this.getAttribute(id,'played') and not this.getAttribute(id,'stopped') then
                    this.setAttribute(id,'played',false);
                    this.setAttribute(id,'stopped',true);
                    this.setAttribute(id,'op',1);
                    this.getAttribute(id,'sound').paused = true;
                end
            else
                if not this.getAttribute(id,'played') and this.getAttribute(id,'stopped') then
                    this.setAttribute(id,'played',true);
                    this.setAttribute(id,'stopped',false);
                    this.setAttribute(id,'op',2);
                    this.getAttribute(id,'sound').paused = false;
                    end
                end
            end
        end
    end

    this.isMediaPlayerPaused = function(id)
        if id then
            return this.getAttribute(id,'stopped');
        end
    end

    this.setSoundSpeed = function(id,speed)
        if id and speed then
            local snd = this.isSound(id);
                if snd then
                    snd.speed = speed;
                end
            this.setProperty(id,'speed',speed);
        end
    end

    this.getSoundSpeed = function(id)
        if id then
            return this.getProperty(id,'speed');
        end
    end

    this.setPosition = function(id,x,y)
        if id and x and y then
            this.setProperty(id,'x',x);
            this.setProperty(id,'y',y);
        end
    end

    this.setSize = function(id,w,h)
        if id and w and h then
            this.setProperty(id,'width',w);
            this.setProperty(id,'height',h);
        end
    end

    this.setSoundPos = function(id,pos)
        if id and pos then
            this.isSound(id).playbackPosition = pos;
        end
    end

    this.setPlaylistIndex = function(id,index)
        if id and index then
            this.setProperty(id,'playlistIndex',index);
        end
    end

    this.onDraw = function(id)
        if not this.isSound(id) then
            w = 0;
        else
            w = (this.isSound(id).playbackPosition ~= 0 and (this.isSound(id).playbackPosition / this.isSound(id).length) or 0);
        end
        if not this.isSound(id) then
            time = "00:00:00/00:00:00";
        else
            time = string.format("%02d:%02d:%02d/%02d:%02d:%02d",math.floor(this.isSound(id).playbackPosition / 3600), (math.floor(this.isSound(id).playbackPosition / 60) <= 59 and math.floor(this.isSound(id).playbackPosition / 60) or math.floor(this.isSound(id).playbackPosition % 60)),(math.floor(this.isSound(id).playbackPosition) <= 59 and math.floor(this.isSound(id).playbackPosition) or math.floor(this.isSound(id).playbackPosition % 60)),math.floor(this.isSound(id).length / 3600), math.floor(this.isSound(id).length / 60), math.floor(this.isSound(id).length % 60));
        end
        if this.isSound(id) and this.isSound(id).playbackPosition > 0 then
            if this.getAttribute(id,'setIndex') then
                this.setAttribute(id,'setIndex',false);
            end
        end
        if type(this.getProperty(id,'path')) == "table" then
            if this.isSound(id) then
                if this.isSound(id).playbackPosition ~= 0 then
                    if math.floor(this.isSound(id).playbackPosition) == math.floor(this.isSound(id).length) and not this.getAttribute(id,'setIndex') and not this.getAttribute(id,'isRadio') then
                        this.setAttribute(id,'setIndex',true);
                        local newIndex = (this.getProperty(id,'playlistIndex') + 1 <= #this.getProperty(id,'playlist') and this.setProperty(id,'playlistIndex',this.getProperty(id,'playlistIndex') + 1) or this.setProperty(id,'playlistIndex',1));
                        this.setPlaylistIndex(id,newIndex);
                        this.setPath(id,this.getProperty(id,'playlist'));
                    end
                end
            end
        end
        if this.getAttribute(id,'tick') then
            local progress = (getTickCount() - this.getAttribute(id,'tick')) / 1200;
            if this.getAttribute(id,'openSettings') then
            from,to = 0,90;
            else
            from,to = 90,0;
            end
            local rot = interpolateBetween(from,0,0,to,0,0,progress,"Linear");
            this.setAttribute(id,'settingsRot',rot);
            if progress > 1 then
            this.setAttribute(id,'tick',false);
            end
        end
        local vl = (this.getProperty(id,'volume') / 1.0);
        dxDrawRectangle(this.getProperty(id,'x'),this.getProperty(id,'y'),this.getAttribute(id,'_width') + this.getProperty(id,'width'),this.getAttribute(id,'_height') + this.getProperty(id,'height'),0xFF000000,true);
        dxDrawRectangle(this.getProperty(id,'x') + 8,this.getProperty(id,'y') + 20,((this.getAttribute(id,'_width') + this.getProperty(id,'width')) - 14),13,0xFF101010,true);
        dxDrawRectangle(this.getProperty(id,'x') + 8,this.getProperty(id,'y') + 20,((this.getAttribute(id,'_width') + this.getProperty(id,'width')) - 14) * w,13,0xBFFF0000,true);
        dxDrawImage(this.getProperty(id,'x') + 1,this.getProperty(id,'y') + 35,25,25,tx[this.getAttribute(id,'op')],0,0,0,0xFFFFFFFF,true);
        dxDrawImage(this.getProperty(id,'x') + 30,this.getProperty(id,'y') + 35,25,25,tx[3],0,0,0,0xFFFFFFFF,true);
        dxDrawImage(this.getProperty(id,'x') + 61,this.getProperty(id,'y') + 35,25,25,(this.getProperty(id,'volume') > 0 and tx[4] or tx[5]),0,0,0,0xFFFFFFFF,true);
        dxDrawRectangle(this.getProperty(id,'x') + 95,this.getProperty(id,'y') + 40,((this.getAttribute(id,'volumeBarWidth'))),11,0xFF101010,true);
        dxDrawRectangle(this.getProperty(id,'x') + 95,this.getProperty(id,'y') + 40,((this.getAttribute(id,'volumeBarWidth')) * vl,11,0xFFFFFFFF,true);
        dxDrawText(time,(this.getProperty(id,'x') + 120) + (this.getAttribute(id,'xp')),this.getProperty(id,'y') + 37,80,60,0xFFFFFFFF,1.0,"default","left","top",false,false,true,false,false,0,0)
        dxDrawImage(this.getProperty(id,'x') + 320,this.getProperty(id,'y') + 35,25,25,tx[6],this.getAttribute(id,'settingsRot'),0,0,0xFFFFFFFF,true);
    end

    this.destroy = function(id)
        for k,v in pairs(tx) do
            v:destroy();
        end
        return this.destructor(id);
    end

    return this;
end