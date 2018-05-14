# UbuntuBackup
Simple shell script to back up your home folder. Currently in development.

1) The intention of this script was originally just to back up your home drive. However, it can currently be used to back up any file or folder that you specify if you choose the that option. The options are displayed when the program is run.

2) This file will be updated to reflect the status of the project as it progresses. Will it be updated daily? Probably not.

3) What works right now? Right now there are two working options.
                    . Automatically back up your home folder : /home/your-user-name and save that compressed data to /home/Backup

                    . The user can provide a file or folder path, and a location where they want to save the data. Please note that  
                      currently, even though you specify the file/folder path and save location. The file generated will be named
                      user-home-folder-backup.7z and will be saved to a directory /Backup where ever you've chosen to save that
                      file. I will add the option to rename the file as well.

4) What features can I expect next? None. I have every intention of doing more with this project but don't expect anything to be
   done. I do other things as well so this is just a side project. It is however gpl, so, you can clone this repo and add other
   features that you'd like to. If you do that considering sending the updates to this repo so that we can have one project which
   progresses rather than nine million stagnant dead projects.

5) A Glimpse: One of the features that I'd like to add is a restore point system which will back up your data at X time.

6) Another Glimpse: I'd also like to add a heavy encryption function to secure the data on top of having a password for the file.
