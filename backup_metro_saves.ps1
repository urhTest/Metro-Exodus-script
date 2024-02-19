<# Jan 20, 2024: Script runs indefinitely (requires manual interruption) and copies files at fixed time intervals. Used for Metro Exodus. #>

# All working paths:
$saves_path = "C:\Users\<your_user_name>\Saved Games\metro exodus\<game_id_in_steam>"
$saves_backup = "C:\Users\<your_user_name>\Saved Games\metro exodus\<game_id_in_steam>\backup"

# All files that we want to preserve.
# Static names:
$profile_file = "profile.cfg"
$user_file = "user.cfg"
$latest_profile_save = $saves_path + "\" + $profile_file
$latest_user_save = $saves_path + "\" + $user_file

# Dynamic names: 
$latest_auto_save=$(Get-ChildItem -Path $saves_path -Attributes !Directory -Filter "*auto_save*" | sort LastWriteTime -Descending | select -First 1 )
$latest_quick_save=$(Get-ChildItem -Path $saves_path -Attributes !Directory -Filter "*quick_save*" | sort LastWriteTime -Descending | select -First 1 )

# Copy interval (seconds) 600 = 10 mins
$copy_interval = 600

while($true){
    # Datetime suffix for backed up files
    $saved_at=$(get-date -Format "yyyyMMdd_HHmmss")

    # Copy/backup files
    # Static files:
    Copy-Item -Path $latest_profile_save -Destination $($saves_backup + "\" + $profile_file + "." + $saved_at)
    Copy-Item -Path $latest_user_save -Destination $($saves_backup + "\" + $user_file + "_" + $saved_at)

    #Dynamic files:
    Copy-Item -Path $latest_auto_save.FullName -Destination $($saves_backup + "\" + $latest_auto_save.BaseName + "." + $saved_at)
    Copy-Item -Path $latest_quick_save.FullName -Destination $($saves_backup + "\" + $latest_quick_save.BaseName + "." + $saved_at)

    Write-Host "Copied files at $saved_at"

    Start-Sleep -Seconds $copy_interval
}
