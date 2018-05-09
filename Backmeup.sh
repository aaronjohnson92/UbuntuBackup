#!bin/bash

# Home Folder - Backup - Restore point: 2018-05-07
Menu()
{
    echo 'Please select from the following options: '
    printf "    1: Backs up /home/ folder.
    2: Backs up the supplied folder to a supplied path.
    3:
    4:
    5:
    6:
    7:
    8:
    9:
    10:
    "
    read -p "Choice: " user_input

    case $user_input in
      1)
          echo "    This is a simplified automated backup procedure.
          You're entire home folder will be backed up and place in a
          directory /backup"
          if [ $(dpkg-query -W -f='${Status}' p7zip-full 2>/dev/null | grep -c "ok installed") -eq 0 ];
              then
                  echo y |  sudo apt-get install p7zip-rar
              fi
          if [ $(dpkg-query -W -f='${Status}' p7zip-rar 2>/dev/null | grep -c "ok installed") -eq 0 ];
              then
                  echo y |  sudo apt-get install p7zip-rar
              fi
          Simple_Backup
          ;;
      2)
          echo "This is a full backup of a folder that you specify.
          When prompted enter the path to the folder you want to back up.
          Ie, /path/to/folder
          You'll then be prompted for the path to the location you want to store the backup.
          Ie, /path/to/storage/medium"
          if [ $(dpkg-query -W -f='${Status}' p7zip-full 2>/dev/null | grep -c "ok installed") -eq 0 ];
              then
                  echo y |  sudo apt-get install p7zip-rar
              fi
          if [ $(dpkg-query -W -f='${Status}' p7zip-rar 2>/dev/null | grep -c "ok installed") -eq 0 ];
              then
                  echo y |  sudo apt-get install p7zip-rar
              fi
          Simple_Backup_Two
          ;;
      3)
          echo 'You selected option 3'
          ;;
      4)
          echo 'You selected option 4'
          ;;
      5)
          echo 'You selected option 5'
          ;;
      6)
          echo 'You selected option 6'
          ;;
      7)
          echo 'You selected option 7'
          ;;
      8)
          echo 'You selected option 8'
          ;;
      9)
          echo 'You selected option 9'
          ;;
      10)
          echo 'You selected option 10'
          ;;
      *)
          echo 'Invalid option rm -rf of /home will begin in five seconds'
          ;;
    esac
}

Simple_Backup()
{
  cd ~
  sudo 7zr u -up0q3r2x2y2z1w2 /home/Backup/user-home-folder-backup.7z `pwd`
}

Simple_Backup_Two()
{
  echo "Please input the path to the folder you want to backup without the last /
  Ie, /home/username
  " 
  
  read to_back_up

  echo "Please input the path where I should place the backed up folder without the last / 
  Ie, /media/my-user-name/backuplocation 
  " 
  
  read save_location

  7zr u -up0q3r2x2y2z1w2 $save_location"/Backup/home-folder-backup.7z" $to_back_up
}

Menu
