--[[
    Author: FileEX
]]
local screen = Vector2(guiGetScreenSize());

local isPlayer = false;
local ind = 0;

local newPlayer = {};

function createMediaPlayer(x,y,w,h,path,vol,stop,loop,throttled,volume,speed,autostart,isRadio)
    local x,y,w,h = tonumber(x),tonumber(y),tonumber(w),tonumber(h)
    assert(x, "Bad argument 1 @ createMediaPlayer [Number expected got "..type(x).."]");
    assert(y, "Bad argument 2 @ createMediaPlayer [Number expected got "..type(y).."]");
    assert(w, "Bad argument 3 @ createMediaPlayer [Number expected got "..type(w).."]");
    assert(h, "Bad argument 4 @ createMediaPlayer [Number expected got "..type(h).."]");
    assert(path, "Bad argument 5 @ createMediaPlayer [String expected got "..type(path).."]");
    local vol = vol ~= nil and vol or false;
    local stop = stop ~= nil and stop or false;
    local loop = loop ~= nil and loop or false;
    local throttled = throttled ~= nil and throttled or false;
    local autostart = autostart ~= nil and autostart or false;
    local isRadio = isRadio ~= nil and isRadio or false;
    local id = #newPlayer + 1;
    newPlayer[id] = player.media();

    newPlayer[id].setProperties(id,{
        x = x,
        y = y,
        width = w,
        height = h,
        path = path,
        setVolume = vol,
        stopSound = stop,
        loop = loop,
        throttled = throttled,
        volume = volume or 1.0,
        speed = speed or 1.0,
        playlist = (type(path) == "table" and path or false);
    });

    newPlayer[id].setAttribute(id,'autostart',autostart);
    newPlayer[id].setAttribute(id,'isRadio',isRadio);

    isPlayer = true;

    newPlayer[id].startSound(id,path,loop,throttled,autostart);

    outputDebugString("Player ID: "..id.." created.",3);
    addEventHandler("onClientRender",root,render);
    addEventHandler("onClientClick",root,click);
    return id;
end

function destroyMediaPlayer(id)
    assert(id,"Bad argument 1 @ destroyMediaPlayer [Number expected got "..type(id).."]");
        if newPlayer[id].getID() == id then
            newPlayer[id].destroy(id)
            outputDebugString("Player ID: "..id.." destroyed.",3);
            removeEventHandler("onClientRender",root,render);
            removeEventHandler("onClientClick",root,click);
    end
end

function setMediaPlayerVolume(id,volume)
    assert(id,"Bad argument 1 @ setMediaPlayerVolume [Number expected got "..type(id).."]");
    assert(volume,"Bad argument 2 @ setMediaPlayerVolume [Number expected got "..type(volume).."]");
        if newPlayer[id].getID() == id then
            newPlayer[id].setVolume(id,volume);
            outputDebugString("Player ID: "..id.." set volume to "..volume,3);
    end
end

function getMediaPlayerVolume(id)
    assert(id,"Bad argument 1 @ getMediaPlayerVolume [Number expected got "..type(id).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].getVolume(id);
    end
end

function setMediaPlayerPath(id,path)
    assert(id,"Bad argument 1 @ setMediaPlayerPath [Number expected got "..type(id).."]");
    assert(path,"Bad argument 2 @ setMediaPlayerPath [String expected got "..type(path).."]");
    if newPlayer[id].getID() == id then
        newPlayer[id].setPath(id,path);
        outputDebugString("Player ID: "..id.." set path to "..path,3);
    end
end

function getMediaPlayerPath(id)
    assert(id,"Bad argument 1 @ getMediaPlayerPath [Number expected got "..type(id).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].getPath(id);
    end
end

function setMediaPlayerLoop(id,loop)
    assert(id,"Bad argument 1 @ setMediaPlayerLoop [Number expected got "..type(id).."]");
    assert(loop,"Bad argument 2 @ setMediaPlayerLoop [Boolean expected got "..type(loop).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].setLoop(id,loop);
    end
end

function getMediaPlayerLoop(id)
    assert(id,"Bad argument 1 @ getMediaPlayerLoop [Number expected got "..type(id).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].getLoop(id);
        end
end

function pauseMediaPlayer(id,pause)
    assert(id,"Bad argument 1 @ pauseMediaPlayer [Number expected got "..type(id).."]");
    if type(pause) ~= "boolean" then
    assert(pause,"Bad argument 2 @ pauseMediaPlayer [Boolean expected got "..type(pause).."]");
    end
        if newPlayer[id].getID() == id then
            return newPlayer[id].setMediaPause(id,pause);
        end
end

function isMediaPlayerPaused(id)
    assert(id,"Bad argument 1 @ isMediaPlayerPaused [Number expected got "..type(id).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].isMediaPlayerPaused(id);
        end
end

function setMediaPlayerSpeed(id,speed)
    assert(id,"Bad argument 1 @ setMediaPlayerSpeed [Number expected got "..type(id).."]");
    assert(speed,"Bad argument 2 @ setMediaPlayerSpeed [Number expected got "..type(speed).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].setSoundSpeed(id,speed);
        end
end

function getMediaPlayerSpeed(id)
    assert(id,"Bad argument 1 @ getMediaPlayerSpeed [Number expected got "..type(id).."]");
        if newPlayer[id].getID() == id then
            return newPlayer[id].getSoundSpeed(id);
        end
end

function render()
    for i = 1,#newPlayer do
        newPlayer[i].onDraw(newPlayer[i].getID());
    end
end

function click(btn,state)
    if btn == "left" and state == "down" then
        if isPlayer then
        for id, v in pairs(newPlayer) do
            if isMouseInPosition(newPlayer[id].getProperty(newPlayer[id].getID(),'x') + 1,newPlayer[id].getProperty(id,'y') + 35,25,25) then
                if newPlayer[id].isSound(newPlayer[id].getID()) then
                    if isMediaPlayerPaused(newPlayer[id].getID()) then
                       pauseMediaPlayer(newPlayer[id].getID(),false);
                    else
                        pauseMediaPlayer(newPlayer[id].getID(),true);
                    end
                end
            elseif isMouseInPosition(newPlayer[id].getProperty(id,'x') + 30,newPlayer[id].getProperty(id,'y') + 35,25,25) and type(newPlayer[id].getProperty(id,'path')) == "table" then
                    newPlayer[id].setAttribute(id,'setIndex',false);
                    local newIndex = (newPlayer[id].getProperty(id,'playlistIndex') + 1 <= #newPlayer[id].getProperty(id,'playlist') and newPlayer[id].setProperty(id,'playlistIndex',newPlayer[id].getProperty(id,'playlistIndex') + 1) or newPlayer[id].setProperty(id,'playlistIndex',1));
                    newPlayer[id].setPlaylistIndex(id,newIndex);
                    newPlayer[id].setPath(id,newPlayer[id].getProperty(id,'playlist'));
            elseif isMouseInPosition(newPlayer[id].getProperty(id,'x') + 8,newPlayer[id].getProperty(id,'y') + 20,((newPlayer[id].getAttribute(id,'_width') + newPlayer[id].getProperty(id,'width')) - 14),13) and not newPlayer[id].getAttribute(id,'isRadio') then
                    if newPlayer[id].isSound(id) and newPlayer[id].isSound(id).playbackPosition > 0 then
                    local cx,_ = getCursorPosition();
                    local ax = (cx * screen.x);
                    local x = (newPlayer[id].getProperty(id,'x') + 8);
                    local w = ((newPlayer[id].getAttribute(id,'_width') + newPlayer[id].getProperty(id,'width')) - 14);
                    local mat = (ax - x) / w;
                    local fin = newPlayer[id].isSound(id).length * (mat);
                    newPlayer[id].setSoundPos(id,fin);
                end
            elseif isMouseInPosition(newPlayer[id].getProperty(id,'x') + 61,newPlayer[id].getProperty(id,'y') + 35,25,25) then
                    if not newPlayer[id].getAttribute(id,'openSound') then
                        newPlayer[id].setAttribute(id,'openSound',true);
                        newPlayer[id].setAttribute(id,'volumeBarWidth',40);   
                        newPlayer[id].setAttribute(id,'xp',30);      
                    else
                        newPlayer[id].setAttribute(id,'openSound',false);
                        newPlayer[id].setAttribute(id,'volumeBarWidth',0);
                        newPlayer[id].setAttribute(id,'xp',0);
                    end
            elseif isMouseInPosition(newPlayer[id].getProperty(id,'x') + 95,newPlayer[id].getProperty(id,'y') + 40,newPlayer[id].getAttribute(id,'volumeBarWidth'),11) then
                    if newPlayer[id].getAttribute(id,'openSound') then
                        local cx,_ = getCursorPosition();
                        local ax = (cx * screen.x);
                        local x = math.floor((newPlayer[id].getProperty(id,'x') + 95));
                        local w = math.floor((newPlayer[id].getAttribute(id,'volumeBarWidth')));
                        local mat = (ax - x) / w;
                        local mat = mat < 0 and 0 or (mat > 1 and 1 or mat);
                        newPlayer[id].setVolume(id,mat);
                    end
            elseif isMouseInPosition(newPlayer[id].getProperty(id,'x') + 320,newPlayer[id].getProperty(id,'y') + 35,25,25) then
                    if not newPlayer[id].getAttribute(id,'openSettings') then
                        newPlayer[id].setAttribute(id,'openSettings',true);
                        newPlayer[id].setAttribute(id,'tick',getTickCount());
                    else
                        newPlayer[id].setAttribute(id,'openSettings',false);
                        newPlayer[id].setAttribute(id,'tick',getTickCount());
                    end
            end 
        end
        end
    end
end


local playlista = {
    {"http://www.radio.pionier.net.pl/stream.pls?radio=merkury"},
    {"http://www.miastomuzyki.pl/n/rmfbaby.pls"},
}

local sound = "https://eez.ymcdn.cc/ae90720d8bfa924e925ff455bf0b8674/Z2igmj0a4Ao";

createMediaPlayer(screen.x/2 - 240,screen.y/2,200,21,playlista,true,true,false,false,1.0,1.0,true,true)
createMediaPlayer(480,250,200,21,sound,true,true,false,false,1.0,1.0,true,false)

showCursor(true)