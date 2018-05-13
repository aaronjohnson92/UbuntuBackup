#!bin/bash

# Home Folder - Backup - Restore point: 2018-05-07
Menu()
{

    if [ $(id -u) = 0 ]; then
        echo 'Do not run as root.'
        exit 1
    fi

    echo 'Please select from the following options: '
    printf "    1: Backs up /home/ folder.
    2: Backs up the supplied folder to a supplied path.
    3: Select a backup type, location, and automate with a cron job.
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
          if [ $(dpkg-query -W -f='${Status}' p7zip-full 2>/dev/null | grep -c "ok installed") -eq 0 ];
              then
                  echo y |  sudo apt-get install p7zip-rar
              fi
          if [ $(dpkg-query -W -f='${Status}' p7zip-rar 2>/dev/null | grep -c "ok installed") -eq 0 ];
              then
                  echo y |  sudo apt-get install p7zip-rar
              fi
          Set_Restore_Point
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
  working_dir=`pwd`
  echo $working_dir
  dir='/home/Backup/'
  if [ -d "$dir" ]; then
     # sudo tar -cvpf /home/Backup/user-home-folder-backup.tar $working_dir
     # sudo 7zr u -up0q3r2x2y2z1w2 /home/Backup/user-home-folder-backup.7z /home/Backup/user-home-folder-backup.tar
     Automated_Full_Home_Folder_Backup
     # sudo rm -rf /home/Backup/user-home-folder-backup.tar
  fi

  if [ ! -d "$dir" ]; then
      sudo mkdir /home/Backup/
      Automated_Full_Home_Folder_Backup
      # sudo tar -cvpf /home/Backup/user-home-folder-backup.tar $working_dir
      # sudo 7zr u -up0q3r2x2y2z1w2 /home/Backup/user-home-folder-backup.7z /home/Backup/user-home-folder-backup.tar
      # sudo rm -rf /home/Backup/user-home-folder-backup.tar
  fi
}

Simple_Backup_Two()
{
  dir='/home/Backup/'

  echo "Please input the path to the folder you want to backup without the last /
  Ie, /home/username
  "

  read to_back_up

  echo "Please input the path where I should place the backed up folder without the last /
  Ie, /media/my-user-name/backuplocation
  "

  read save_location


  read -p "Would you like to name this file?: (y/n)" inp

  if [ -d "$dir" ]; then
      if ! [ $inp = 'y' -o $inp = 'Y' ]; then
          sudo mkdir $save_location"/Backup/"
          sudo tar -cvpf $save_location"/Backup/user-home-folder-backup.tar" $to_back_up
          sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/Backup/user-home-folder-backup.7z" $save_location"/Backup/user-home-folder-backup.tar"
          sudo rm -rf $save_location"/"$file_name".tar"
      elif [ $inp = 'y' -o $inp = 'Y' ]; then
        echo "Enter the name you'd like to give the file"
        read file_name
        sudo tar -cvpf $save_location"/"$file_name".tar" $to_back_up
        sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/"$file_name".7z" $save_location"/"$file_name".tar"
        sudo rm -rf $save_location"/"$file_name".tar"
      fi
  elif [ ! -d "$dir" ]; then
      if ! [ $inp = 'y' -o $inp = 'Y' ]; then
          sudo mkdir $save_location"/Backup/"
          sudo tar -cvpf $save_location"/Backup/user-home-folder-backup.tar" $to_back_up
          sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/Backup/user-home-folder-backup.7z" $save_location"/Backup/user-home-folder-backup.tar"
          sudo rm -rf $save_location"/"$file_name".tar"
      elif [ $inp = 'y' -o $inp = 'Y' ]; then
        echo "Enter the name you'd like to give the file"
        read file_name
        sudo tar -cvpf $save_location"/"$file_name".tar" $to_back_up
        sudo 7zr u -up0q3r2x2y2z1w2 $save_location'/'$file_name".7z" $save_location'/'$file_name".tar"
        sudo rm -rf $save_location"/"$file_name".tar"
      fi
  fi
  # Function backs eerything up like it should but it doesn't delete the default .tar
  # When you don't name the file
  # When you do name the file it deletes the tar and the folder generated but saves teh .7z in the working directory
}

Set_Restore_Point() # FINISH
{
    echo "Please select from one of the below options
    1) Daily: Incremental Backup
    2) Daily: Full Backup
    3) Daily: Differential Backup
    4) Weekly: Incremental Backup
    5) Weekly: Full Backup
    6) Weekly Differential Backup
    7) Custom: Incremental Backup
    8) Custom: Full Backup
    9) Custom: Differential Backup"

    read -p "Choice: " user_choice
    case $user_choice in
        1)
            echo "Option 1"
            ;;

        2)
            echo "Option 2"
            ;;

        3)
            echo "Option 3"
            ;;

        4)
            echo "Option 4"
            ;;

         5)
             echo "Option 5"
             ;;

         6)
             echo "Option 6"
             ;;

         7)
             echo "Option 7"
             ;;
         8)
             echo "Option 8"
             ;;
         9)
             echo "Option 9"
             ;;
        *)
           echo "Invalid Option, try again (y/n) "
           read answer
           if [ $answer = 'y' -o $answer = 'Y' ]; then
               Set_Restore_Point
           elif [ $answer = 'n' -o $answer = 'N' ]; then
               Menu
           fi
           ;;
    esac
}

Incremental_Backup()
{
 # tar commands -d compares files in an archive to find the differences
 # tar commands -r appends files to the end of an archive
 # tar commands -u update files that are newer than the ones in the current archive
 # tar commands --exclude-backups exclude backup and lock files
 # tar commands -g (--listed-incremental = filename) handle new GNU-format incremental backup
 # tar commands -G (--incremental) handle old GNU-format incremental backup
 # tar commands -n (--seek) archive is seekable
 # tar commands --keep-directory-symlink preserve existing symlinks to directories when extracting
 # tar commands --overwrite overwrite existing files when extracting
 # tar commands --overwrite-dir overwrite metadata of existing directories when extracting
 # tar commands -U --unlink-first remove each file prior to extracting over it
 # tar commands -p --preserve-permissions --same-permissions try extracting files with the same ownership in the archive
 # tar commands -s --preserve-order --same-order member arguments are listed in the same order as the files in the archive
 # tar commands -H --format=FORMAT -H gnu
 # tar commands --lzma filder the archive through xz '# tar commands -z --gzip filter the archive through gzip
 # tar commands -Z --compress filter the archive through compress
 # tar commands --deference follow hard links; archive and dump the files they refer to
 # tar commands --hard-deference follow the hard links; archive and dump the files they refer tic
 #
 echjo "no"
}

Automated_Full_Home_Folder_Backup()
{
  cd ~
  working_dir=`pwd`
  tar_file='/home/Backup/user-home-folder-backup.tar'
  zip_file='/home/Backup/user-home-folder-backup.7z'
  date=`date +%Y-%m-%d`
  time=`date +%T`
  sudo tar -cvpzf $tar_file --one-file-system $working_dir
  sudo 7zr u -up0q3r2x2y2z1w2 /$zip_file $save_location$user_backup".tar"
  sudo rm -rf /home/Backup/user-home-folder-backup.tar
  echo "Full backup completed on: " $date " at: " $time
}

Menu
