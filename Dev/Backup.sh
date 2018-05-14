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
    2: Backs up the supplied folder to a supplied path. This essentially functions asa full backup if done on a folder.
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
     Automated_Full_Home_Folder_Backup
  fi

  if [ ! -d "$dir" ]; then
      sudo mkdir /home/Backup/
      Automated_Full_Home_Folder_Backup
  fi
}

Simple_Backup_Two()
{
    Custom_Full_Home_Folder_Backup
}

Set_Restore_Point()
{
    echo "Please select from one of the below options
    1) Daily
    2) Weekly
    3) Monthly
    4) Custom"
    read -p "Choice: " user_choice
    case $user_choice in
        1)
            Create_Daily_Cron_Job
            ;;

        2)
            Create_Weekly_Cron_Job
            ;;

        3)
            Create_Monthly_Cron_Job
            ;;

        4)
            Create_Custom_Cron_Job
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
 echo "no"
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
  sudo 7zr u -up0q3r2x2y2z1w2 $zip_file $tar_file
  sudo rm -rf /home/Backup/user-home-folder-backup.tar
  echo "Full backup completed on: " $date " at: " $time
}

Custom_Full_Home_Folder_Backup()
{

    date=`date +%Y-%m-%d`
    time=`date +%T`

    echo "Please input the path to the folder you want to backup without the last /
    Ie, /home/username
    "
    read to_backup

    echo "Please input the path where I should place the backed up folder without the last /
    Ie, /media/my-user-name/backuplocation
    "
    read save_location


    if [ ! -d "$save_location" ]; then
        sudo mkdir $save_location
        echo "Would you like to name this file?: (y/n)"
        read inp
        if [ $inp = 'y' -o $inp = 'Y' ]; then
            echo "Enter file name: "
            read file_name
            sudo tar -cvpzf $save_location"/"$file_name".tar" $to_backup
            sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/"$file_name".7z" $to_backup
            sudo rm -rf $save_location"/"$file_name".tar"
            echo "Full backup completed on: " $date " at: " $time
        elif [ $inp = 'n' -o $inp = 'N' ]; then
            sudo tar -cvpzf $save_location"/Backup_Data.tar" $to_backup
            sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/Backup_Data.7z" $to_backup
            sudo rm -rf $save_location"/Backup_Data.tar"
            echo "Full backup completed on: " $date " at: " $time
        fi
    elif [ -d "$save_location" ]; then
        echo "Would you like to name this file?: (y/n)"
        read inp
        if [ $inp = 'y' -o $inp = 'Y' ]; then
            echo "Enter file name: "
            read file_name
            sudo tar -cvpzf $save_location"/"$file_name".tar" $to_backup
            sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/"$file_name".7z" $to_backup
            sudo rm -rf $save_location"/"$file_name".tar"
            echo "Full backup completed on: " $date " at: " $time
        elif [ $inp = 'n' -o $inp = 'N' ]; then
            sudo tar -cvpzf $save_location"/Backup_Data.tar" $to_backup
            sudo 7zr u -up0q3r2x2y2z1w2 $save_location"/Backup_Data.7z" $to_backup
            sudo rm -rf $save_location"/Backup_Data.tar"
            echo "Full backup completed on: " $date " at: " $time
        fi
    fi
}

Create_Weekly_Cron_Job()
{
  echo "None"
}

Create_Monthly_Cron_Job()
{
  echo "None"
}

Create_Custom_Cron_Job()
{
  echo "None"
}

Create_Daily_Cron_Job()
{
    read -p "Well to the crontab job creation setup. Would you like these
             results to be emailed to you? (y\n): " choice
    if [ $choice = 'y' -o $choice = 'Y' ]; then
        echo "Enter valid email address: "
        read email
        test_bool='0'
        while [ $test_bool = '0' ]; do
            echo " Is this your email(y/n): " $email
            read verify
            if [ $verify = 'y' -o $verify = 'Y' ]; then
                test_bool='1'
            elif [ $verify = 'n' -o $verify = 'N' ]; then
                echo "Enter valid email address: "
                read email
            else
                echo "invalid option, try again."
            fi
        done
        echo "Enter the hour of the day that you want this job to run at: "
        read _hour # hour of the day the job will execute

        echo "Enter the minute of the day this job will execute."
        read _minute # Minute after the hour this job will run at

        echo "Enter the month you want this job to execute in. \n1: January
2: February\n3: March\n4: April\n5: May\n6: June\n7: July\n8: August
9: September\n10: October\n11: November\n12: December. \nIf you want this
daily full backup to occurr during multiple months, type them then
seperate with a coma Ie, 1,2,3,4"
        read _month # get the month that this job should execute

        echo "0: Sunday\n1: Monday\n2: Tuesday\n3: Wednesday\n4: Thursday
5: Friday\n6: Saturday \nPlease enter the number wich coresponds with
the day of week you want this to run:  "
        read _day # Day of the week the backup will run The current month will be added (possible all months)

        echo "Please choose your backup type by typing in the coresponding number.
1: Incremental \n2: Differential\n3: Full\n: "
        read _type # Backup type chosen by the user
        # Incremental
        # Differential
        # Full
        if [ $_type = '1' -o $_type = '2' -o $_type = "3" ]; then
            echo "The job will execute on: "$_month"-"$_day " at: "$_hour":"$_minute
            # Create cron job
            # Create cron job
        else
          echo "I'm sorry that wasn't a vlid choice please enter 1-3"
          echo "Please choose your backup type by typing in the coresponding number.
  1: Incremental \n2: Differential\n3: Full\n: "
          read _type # Backup type chosen by the user
          if [ $_type = '1' -o $_type = '2' -o $_type = "3" ]; then
              echo "The job will execute on: "$_month"-"$_day " at: "$_hour":"$_minute
              # Create cron job add more if statements to
              # determine the back up type and write it to cron
              # Create cron job
          else
              echo "You've failed to enter a valid choice twice, please try again."
              Create_Daily_Cron_Job
          fi
        fi
    elif [ $choice = 'n' -o $choice = 'N' ]; then
        echo "Not implemented yet"
    else
        echo "Invalid option, try again."
        Create_Cron_Job
    fi
}

Menu
