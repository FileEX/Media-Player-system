# Media-Player-system

The system is underway and contains some errors. It is also not finally finished. It is 80% ready.

## Functions: 

### Function: `createMediaPlayer`

```lua

createMediaPlayer(x,y,w,h,path,vol,stop,loop,throttled,volume,speed,autostart,isRadio)
```

  *__x -__ The position of the X axis on the screen.
  
  *__y -__ The position of the Y axis on the screen.
  
  *__w -__ Width.
  
  *__h -__ Height.
  
  *__path -__ String file path or URL path. If type of path is table then is playlist.
  
  *__vol -__ Boolean representing on whether you can change the volume.
  
  *__stop -__ Boolean representing on whether you can stop/pause the sound.
  
  *__loop -__ Boolean representing whether the sound will be looped. To loop the sound, use true. Loop is not available for streaming sounds, only for sound files.
  
  *__throttled -__ Boolean representing whether the sound will be throttled (i.e. given reduced download bandwidth). To throttle the sound, use true. Sounds will be throttled per default and only for URLs.
  
  *__volume -__ Int volume of the sound.
  
  *__speed -__ Int speed of the sound.
  
  *__autostart -__ Boolean representing on whether player can start without you contest
  
  *__isRadio -__ Boolean representing on whether path is radioed.
  
  Returns a id of the created player.
  
  ### Function: `destroyMediaPlayer`
  ```lua
 destroyMediaPlayer(id)
 ```
 
  *__id -__ The ID of the media player which you want destroy.
  
  ### Function: `setMediaPlayerVolume`
  
 ```lua
 setMediaPlayerVolume(id, volume)
 ```
 
  *__id -__ The ID of the media player which you want change volume.
  *__volume -__ A floating point number representing the desired volume level.
  
  ### Function: `getMediaPlayerVolume`
  
  ```lua
 getMediaPlayerVolume(id)
 ```
 
  *__id -__ The ID of the media player which you want get volume.
  
  Returns a volume of media player.
 
 ### Function: `setMediaPlayerPath`
 
 ```lua
 setMediaPlayerPath(id,path)
 ```
 
  *__id -__ The ID of the media player which you want change path.
  *__path -__ - String file path or URL path. If type of path is table then is playlist
  
  ### Function: `getMediaPlayerPath`
  
  ```lua
 getMediaPlayerPath(id)
 ```
 
  *__id -__ The ID of the media player which you want get path.
  
  Returns a path of media player.
  
  ### Function: `setMediaPlayerLoop`
  
 ```lua
 setMediaPlayerLoop(id, loop)
 ```
 
  *__id -__ The ID of the media player which you want change loop.
  *__loop -__ Boolean representing whether the sound will be looped. To loop the sound, use true. Loop is not available for streaming sounds, only for sound files.
  
  ### Function: `getMediaPlayerLoop`
  
 ```lua
 getMediaPlayerLoop(id)
 ```
 
  *__id -__ The ID of the media player which you want get loop.
  
  Returns the loop of the media player.
  
  ### Function: `pauseMediaPlayer`
  
  ```lua  
pauseMediaPlayer(id, pause)
```

  *__id -__ The ID of the media player which you want change paused value.
  *__pause -__ The boolean representing whether the sound should be paused.
  
  ### Function: `isMediaPlayerPaused`
  
  ```lua
 isMediaPlayerPaused(id)
 ```
 
  *__id -__ The ID of the media player which you want get paused value.
  
  Returns a boolean representing whether the media player is paused.
  
  ### Function `setMediaPlayerSpeed`
  
  ```lua
 setMediaPlayerSpeed(id, speed)
 ```
 
  *__id -__ The ID of the media player which you want change speed.
  *__speed -__ Floating point number representing the desired sound playback speed.
  
  ### Function: `getMediaPlayerSpeed`
  
  ```lua
 getMediaPlayerSpeed(id)
 ```
 
  *__id -__ The ID of the media player which you want get speed.
  
 setMediaPlayerSpeed and getMediaPlayerSpeed do not work correctly yet. This will fixed soon.
  
