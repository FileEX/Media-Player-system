# Media-Player-system

The system is underway and contains some errors. It is also not finally finished. It is 80% ready.

List of functions:

createMediaPlayer(x,y,w,h,path,vol,stop,loop,throttled,volume,speed,autostart,isRadio)
  x - The position of the X axis on the screen.
  y - The position of the Y axis on the screen.
  w - Width.
  h - Height.
  path - String file path or URL path. If type of path is table then is playlist.
  vol - Boolean representing on whether you can change the volume.
  stop - Boolean representing on whether you can stop/pause the sound.
  loop - Boolean representing whether the sound will be looped. To loop the sound, use true. Loop is not available for streaming sounds, only for sound files.
  throttled - Boolean representing whether the sound will be throttled (i.e. given reduced download bandwidth). To throttle the sound, use true. Sounds will be throttled per default and only for URLs.
  volume - Int volume of the sound.
  speed - Int speed of the sound.
  autostart - Boolean representing on whether player can start without you contest.
  isRadio - Boolean representing on whether path is radioed.
  
  Returns a id of the created player.
  
 destroyMediaPlayer(id)
  id - The ID of the media player which you want destroy.
  
 setMediaPlayerVolume(id, volume)
  id - The ID of the media player which you want change volume.
  volume -  A floating point number representing the desired volume level.
  
 getMediaPlayerVolume(id)
  id - The ID of the media player which you want get volume.
  
  Returns a volume of media player.
 
 setMediaPlayerPath(id,path)
  id - The ID of the media player which you want change path.
  path - String file path or URL path. If type of path is table then is playlist
  
 getMediaPlayerPath(id)
  id - The ID of the media player which you want get path.
  
  Returns a path of media player.
 
 setMediaPlayerLoop(id, loop)
  id - The ID of the media player which you want change loop.
  loop - Boolean representing whether the sound will be looped. To loop the sound, use true. Loop is not available for streaming sounds, only for sound files.
  
 getMediaPlayerLoop(id)
  id - The ID of the media player which you want get loop.
  
  Returns the loop of the media player.
  
pauseMediaPlayer(id, pause)
  id - The ID of the media player which you want change paused value.
  pause - The boolean representing whether the sound should be paused.
  
 isMediaPlayerPaused(id)
  id - The ID of the media player which you want get paused value.
  
  Returns a boolean representing whether the media player is paused.
  
 setMediaPlayerSpeed(id, speed)
  id - The ID of the media player which you want change speed.
  speed - Floating point number representing the desired sound playback speed.
  
 getMediaPlayerSpeed(id)
  id - The ID of the media player which you want get speed.
  
 setMediaPlayerSpeed and getMediaPlayerSpeed do not work correctly yet. This will fixed soon.
  
