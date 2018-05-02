--[[
    Author: FileEX
]]
local screen = Vector2(guiGetScreenSize());
local isPlayer = false;

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
    newPlayer = player.media();
    local id = newPlayer.getID();

    newPlayer.setProperties(id,{
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

    newPlayer.setAttribute(id,'autostart',autostart);
    newPlayer.setAttribute(id,'isRadio',isRadio);

    isPlayer = true;

    newPlayer.startSound(id,path,loop,throttled,autostart);

    outputDebugString("Player ID: "..id.." created.",3);
    addEventHandler("onClientRender",root,render);
    addEventHandler("onClientClick",root,click);
    return id;
end

function destroyMediaPlayer(id)
    assert(id,"Bad argument 1 @ destroyMediaPlayer [Number expected got "..type(id).."]");
        if newPlayer.getID() == id then
            newPlayer.destroy(id)
            outputDebugString("Player ID: "..id.." destroyed.",3);
            removeEventHandler("onClientRender",root,render);
            removeEventHandler("onClientClick",root,click);
    end
end

function setMediaPlayerVolume(id,volume)
    assert(id,"Bad argument 1 @ setMediaPlayerVolume [Number expected got "..type(id).."]");
    assert(volume,"Bad argument 2 @ setMediaPlayerVolume [Number expected got "..type(volume).."]");
        if newPlayer.getID() == id then
            newPlayer.setVolume(id,volume);
            outputDebugString("Player ID: "..id.." set volume to "..volume,3);
    end
end

function getMediaPlayerVolume(id)
    assert(id,"Bad argument 1 @ getMediaPlayerVolume [Number expected got "..type(id).."]");
        if newPlayer.getID() == id then
            return newPlayer.getVolume(id);
    end
end

function setMediaPlayerPath(id,path)
    assert(id,"Bad argument 1 @ setMediaPlayerPath [Number expected got "..type(id).."]");
    assert(path,"Bad argument 2 @ setMediaPlayerPath [String expected got "..type(path).."]");
    if newPlayer.getID() == id then
        newPlayer.setPath(id,path);
        outputDebugString("Player ID: "..id.." set path to "..path,3);
    end
end

function getMediaPlayerPath(id)
    assert(id,"Bad argument 1 @ getMediaPlayerPath [Number expected got "..type(id).."]");
        if newPlayer.getID() == id then
            return newPlayer.getPath(id);
    end
end

function setMediaPlayerLoop(id,loop)
    assert(id,"Bad argument 1 @ setMediaPlayerLoop [Number expected got "..type(id).."]");
    assert(loop,"Bad argument 2 @ setMediaPlayerLoop [Boolean expected got "..type(loop).."]");
        if newPlayer.getID() == id then
            return newPlayer.setLoop(id,loop);
    end
end

function getMediaPlayerLoop(id)
    assert(id,"Bad argument 1 @ getMediaPlayerLoop [Number expected got "..type(id).."]");
        if newPlayer.getID() == id then
            return newPlayer.getLoop(id);
        end
end

function pauseMediaPlayer(id,pause)
    assert(id,"Bad argument 1 @ pauseMediaPlayer [Number expected got "..type(id).."]");
    if type(pause) ~= "boolean" then
    assert(pause,"Bad argument 2 @ pauseMediaPlayer [Boolean expected got "..type(pause).."]");
    end
        if newPlayer.getID() == id then
            return newPlayer.setMediaPause(id,pause);
        end
end

function isMediaPlayerPaused(id)
    assert(id,"Bad argument 1 @ isMediaPlayerPaused [Number expected got "..type(id).."]");
        if newPlayer.getID() == id then
            return newPlayer.isMediaPlayerPaused(id);
        end
end

function setMediaPlayerSpeed(id,speed)
    assert(id,"Bad argument 1 @ setMediaPlayerSpeed [Number expected got "..type(id).."]");
    assert(speed,"Bad argument 2 @ setMediaPlayerSpeed [Number expected got "..type(speed).."]");
        if newPlayer.getID() == id then
            return newPlayer.setSoundSpeed(id,speed);
        end
end

function getMediaPlayerSpeed(id)
    assert(id,"Bad argument 1 @ getMediaPlayerSpeed [Number expected got "..type(id).."]");
        if newPlayer.getID() == id then
            return newPlayer.getSoundSpeed(id);
        end
end

function render()
    if newPlayer then
    newPlayer.onDraw(newPlayer.getID());
    end
end

function click(btn,state)
    if btn == "left" and state == "down" then
        if isPlayer then
        local id = newPlayer.getID();
            if isMouseInPosition(newPlayer.getProperty(newPlayer.getID(),'x') + 1,newPlayer.getProperty(id,'y') + 35,25,25) then
                if newPlayer.isSound(newPlayer.getID()) then
                    if isMediaPlayerPaused(newPlayer.getID()) then
                       pauseMediaPlayer(newPlayer.getID(),false);
                    else
                        pauseMediaPlayer(newPlayer.getID(),true);
                    end
                end
            elseif isMouseInPosition(newPlayer.getProperty(id,'x') + 30,newPlayer.getProperty(id,'y') + 35,25,25) and type(newPlayer.getProperty(id,'path')) == "table" then
                    newPlayer.setAttribute(id,'setIndex',false);
                    local newIndex = (newPlayer.getProperty(id,'playlistIndex') + 1 <= #newPlayer.getProperty(id,'playlist') and newPlayer.setProperty(id,'playlistIndex',newPlayer.getProperty(id,'playlistIndex') + 1) or newPlayer.setProperty(id,'playlistIndex',1));
                    newPlayer.setPlaylistIndex(id,newIndex);
                    newPlayer.setPath(id,newPlayer.getProperty(id,'playlist'));
            elseif isMouseInPosition(newPlayer.getProperty(id,'x') + 8,newPlayer.getProperty(id,'y') + 20,((newPlayer.getAttribute(id,'_width') + newPlayer.getProperty(id,'width')) - 14),13) and not newPlayer.getAttribute(id,'isRadio') then
                    if newPlayer.isSound(id) and newPlayer.isSound(id).playbackPosition > 0 then
                    local cx,_ = getCursorPosition();
                    local ax = (cx * screen.x);
                    local x = (newPlayer.getProperty(id,'x') + 8);
                    local w = ((newPlayer.getAttribute(id,'_width') + newPlayer.getProperty(id,'width')) - 14);
                    local mat = (ax - x) / w;
                    local fin = newPlayer.isSound(id).length * (mat);
                    newPlayer.setSoundPos(id,fin);
                end
            elseif isMouseInPosition(newPlayer.getProperty(id,'x') + 61,newPlayer.getProperty(id,'y') + 35,25,25) then
                    if not newPlayer.getAttribute(id,'openSound') then
                        newPlayer.setAttribute(id,'openSound',true);
                        newPlayer.setAttribute(id,'volumeBarWidth',40);   
                        newPlayer.setAttribute(id,'xp',30);      
                    else
                        newPlayer.setAttribute(id,'openSound',false);
                        newPlayer.setAttribute(id,'volumeBarWidth',0);
                        newPlayer.setAttribute(id,'xp',0);
                    end
            elseif isMouseInPosition(newPlayer.getProperty(id,'x') + 95,newPlayer.getProperty(id,'y') + 40,newPlayer.getAttribute(id,'volumeBarWidth'),11) then
                    if newPlayer.getAttribute(id,'openSound') then
                        local cx,_ = getCursorPosition();
                        local ax = (cx * screen.x);
                        local x = math.floor((newPlayer.getProperty(id,'x') + 95);
                        local w = math.floor((newPlayer.getAttribute(id,'volumeBarWidth')));
                        local mat = (ax - x) / w;
                        local mat = mat < 0 and 0 or (mat > 1 and 1 or mat);
                        newPlayer.setVolume(id,mat);
                    end
            elseif isMouseInPosition(newPlayer.getProperty(id,'x') + 320,newPlayer.getProperty(id,'y') + 35,25,25) then
                    if not newPlayer.getAttribute(id,'openSettings') then
                        newPlayer.setAttribute(id,'openSettings',true);
                        newPlayer.setAttribute(id,'tick',getTickCount());
                    else
                        newPlayer.setAttribute(id,'openSettings',false);
                        newPlayer.setAttribute(id,'tick',getTickCount());
                    end
            end 
        end
    end
end


local playlista = {
    {"http://www.radio.pionier.net.pl/stream.pls?radio=merkury"},
    {"http://www.miastomuzyki.pl/n/rmfbaby.pls"},
}

createMediaPlayer(screen.x/2,screen.y/2,200,60,playlista,true,true,false,false,1.0,1.0,true,true)

showCursor(true)