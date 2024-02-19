# Metro2077 Exodus (local backup of save files)
  Basically, the game offers only 4 last saves.  Any new quick/manual and auto saves will overwrite older save files leaving you with 4 previous saves to choose from..  I find it quite inconvenient -  especially when I want to return further back, or to replay a chapter.  So.. the ```backup_metro_saves.ps1``` powershell script helps with the issue.

### How does it work?
  The script saves the **last modified** quick/manual and auto saves, plus profile.cfg and user.cfg, to ``` $saves_backup ``` location.  The script will immediatelly make a copy of selected files on start up and continue taking backups at fixed interval until the script is terminated.  You can terminate it either by pressing ```Ctrl+C``` or close the console window.  Adjust parameters and double click on script(no need to execute script with admin permissions).
  
  Whenever you need to restore the earlier save, simply copy a file from ``` $saves_backup ``` to ``` $saves_path ```. Keep the original name of the save file, but strip the date suffix (``` _yyyyMMdd_HHmmss ```) off the file.  **Note** that this does not work while the game is running. You will need to restart the game for it to load saves that you restored.

### Adjusting parameters
  1. ```$saves_path = "C:\Users\<your_user_name>\Saved Games\metro exodus\<game_id_in_steam>" ``` is the place where the game keeps its save files. ```<your_user_name>``` is your user name that you use to login on windows. ``` <game_id_in_steam> ``` as far as I understand, it is a unqiue id that is assigned in steam to the game(should be a large number). You can look it up in steam client, or just dig through ``` Saved Games\metro exodus ``` folder until you find it.
  2. ```$saves_backup = "C:\Users\<your_user_name>\Saved Games\metro exodus\<game_id_in_steam>\backup" ``` is the path of your choosing where you want to keep the copies of save files. 
  3. ```$copy_interval = 600 ``` is the interval at which script will be coping files. 10 mins by default. **Note** that files are quite large.  You can run out of disk space if the interval is less and you are low on available disk space. *_Adjust this setting according to your system._*
