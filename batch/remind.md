# Batch User Prompt


<!-- vim-markdown-toc GitLab -->

* [SET /P in batch file - Default value after timeout for user prompt](#set-p-in-batch-file-default-value-after-timeout-for-user-prompt)
* [[How to ask for batch file user input with a timeout}(https://stackoverflow.com/questions/12331428/how-to-ask-for-batch-file-user-input-with-a-timeout)](#how-to-ask-for-batch-file-user-input-with-a-timeouthttpsstackoverflowcomquestions12331428how-to-ask-for-batch-file-user-input-with-a-timeout)
* [Wndows Batch Files for Fun and profite](#wndows-batch-files-for-fun-and-profite)
* [How to add a timeout or pause in a Batch file](#how-to-add-a-timeout-or-pause-in-a-batch-file)
* [recent file created in a folder to another destination automatically](#recent-file-created-in-a-folder-to-another-destination-automatically)
* [iterate all files in a dir](#iterate-all-files-in-a-dir)
* [In batch, how do i create space at the beginning of string](#in-batch-how-do-i-create-space-at-the-beginning-of-string)
* [create list or arrays in batch](#create-list-or-arrays-in-batch)
* [[SCHTASK] create schedule task for windows](#schtask-create-schedule-task-for-windows)
* [schtasks example](#schtasks-example)
* [how to execute a scheduled task with "schtasks" wo opening a new window](#how-to-execute-a-scheduled-task-with-schtasks-wo-opening-a-new-window)
* [have a task that runs every day and repeats every hour](#have-a-task-that-runs-every-day-and-repeats-every-hour)

<!-- vim-markdown-toc -->

## [SET /P in batch file - Default value after timeout for user prompt](https://groups.google.com/forum/#!topic/alt.msdos.batch.nt/u1MmJ1vp_pE)

Can anyone help please? I have a problem with something that used to
be easy with the CHOICE command in Win9x batch files, but I think I
must be missing something, as I can't find out how to do it using SET /
P, the replacement in WIN XP. Does anybody know if and how to get a
batch file to wait a limited time for user input, and to use a default
value
instead, if the time expires without user input? I thought it might be
possible to do something equivalent to

SET /P:30,Y choice=Enter your choice
(where it would wait 30s and then choose Y by default)

I know this syntax is just made up, its just an example of what I was
trying to do,
but does anybody know how I would go about doing this sort of thing? I
can't
find any relevant documentation anywhere .... any advice very
gratefully received!

Thanks very much!



## [How to ask for batch file user input with a timeout}(https://stackoverflow.com/questions/12331428/how-to-ask-for-batch-file-user-input-with-a-timeout)

- method 1

```batch
@echo off
setlocal enableDelayedExpansion
for /l %%N in (600 -1 1) do (
set /a "min=%%N/60, sec=%%N%%60, n-=1"
  if !sec! lss 10 set sec=0!sec!
  cls
  choice /c:CN1 /n /m "HIBERNATE in !min!:!sec! - Press N to hibernate Now, or C to Cancel. " /t:1 /d:1
  if not errorlevel 3 goto :break
)
cls
echo HIBERNATE in 0:00 - Press N to hibernate Now, or C to Cancel.
:break
if errorlevel 2 (%windir%\System32\rundll32.exe powrprof.dll,SetSuspendState Hibernate) else echo Hibernate Canceled
```

__Explaination__

workoverflow for loop counting down from 600 seconds, -1 at a time until 1. Calculate min and second from seconds. Just pad with 0 for seconds. min and sec is passed to choice string. /c:CN1 is mapping C and N characters from input to errorlevel. If errorlevel is 1 or 2, user pressed a key and jumps to break. errorlevel 2 is N so hibernate.


- method 2

 reccomend using CHOICE.EXE, it comes standard with most versions of Windows (with the exception of Windows NT, 2000 and XP, it used to be downloadable from Microsoft's website, but they seem to have overlooked this* one on their ftp site.) and is simple to use.

 ```batch
 @Echo off
 :START
 set waitMins=30

 echo PC WILL RESTART IN %waitMins% MINUTES: Press N to restart [N]ow or C to [C]ancel
 :: Calculate Seconds
 set /a waitMins=waitMins*60
 :: Choices are n and c, default choice is n, timeout = 1800 seconds
 choice /c nc /d n /t %waitMins%

 :: [N]ow = 1; [C]ancel = 2
 goto Label%errorlevel%

 :Label1

 shutdown -r -t 60 -f
 :: Make sure that the process doesn't fall through to Lable2
 goto :eof

 :Label2 
 exit
 ```

 imply CHOICE.EXE works like this...

 choice

 ...and is the same as...

 choice /c yn

 ...both will display...

 [Y,N]?

 ...and both will wait for the user to press a Y or N.

 Choice stores the result in %errorlevel%. Y=1, N=2.

 The code I provided takes advantage of the default /D <choice> and timeout /T <seconds> options.

 In example...

 choice /c yn /d y /t 5

 ...gives the user a choice of Y or N, will wait for 5 seconds then automaticlly select the default choice of Y, resulting in %ERRORLEVEL%==1.

 Another example is...

 choice /c abcdef /m "Make a choice. "

 ...and it displays...

 Make a choice. [A,B,C,D,E,F]? 
 ...and...

 A = %ERRORLEVEL% = 1
 B = %ERRORLEVEL% = 2
 C = %ERRORLEVEL% = 3
 D = %ERRORLEVEL% = 4
 E = %ERRORLEVEL% = 5
 F = %ERRORLEVEL% = 6

 There is no ERRORLEVEL 0.

 For more on the use of choice, type CHOICE /? at the command prompt.

## [Wndows Batch Files for Fun and profite](http://www.informit.com/articles/article.aspx?p=1154761&seqNum=12)

## [How to add a timeout or pause in a Batch file](https://www.howtogeek.com/196873/how-to-add-a-timeout-or-pause-in-a-batch-file/)

using the following on the command prompt will pause the terminal for 10 seconds unless you press a key:

`timeout /t 10`

Whereas this command will pause the terminal for 30 seconds whether you press a key or not:

`timeout /t 30 /nobreak`

nd this one will pause forever until you press a key:

`timeout /t -1`

## [recent file created in a folder to another destination automatically](https://community.spiceworks.com/scripts/show/2844-batch-copy-the-most-recent-file-created-in-a-folder-to-another-destination-automatically-handy-for-backups)

```batch
REM Copy the most recent database backups from their folders 
@echo off

REM Copy File in one destination to another --------------------------------------------

setlocal
set srcDir=\\sql1\Backups\Avidian
set destdir=E:\2014_Backups
set lastmod=
pushd %srcDir%
for /f "tokens=*" %%a in ('dir *.bak /b /o-d /a-d 2^>NUL') do set lastmod=%%a & goto :xx
:xx
if "%lastmod%"=="" echo Could not locate files.&goto :eof
:::
copy "%lastmod%" "%destDir%"
```

## [iterate all files in a dir](https://stackoverflow.com/questions/138497/iterate-all-files-in-a-directory-using-a-for-loop)
    
    * ...files in current dir : `for %f in (.\*) do @echo %f`
    * ...subdirs in current dir: `for /D %s in (.\*) do @echo %s`
    * ...files in current and all subdirs: `for /R %f in (.\*) do @echo %f`
    * ...subdirs in current and all subdirs: `for /D /R %s in (.\*) do @echo %s`

    The case of wanted the file content, name, etc
    ```
    @ECHO OFF
    setlocal enabledeltaexpansion
    for %%f in (dir\*.txt) do (
        set /p val=<%%f
        echo "fullname: %%f"
        echo "name: %%~nf"
        echo "contents: !val!"
    )
    ```

## [In batch, how do i create space at the beginning of string](https://stackoverflow.com/questions/9864620/in-batch-how-do-i-create-spaces-at-the-beginning-of-a-input-prompt-string)

    ```
    echo   without space 
    echo.  with space after dot
    ```

## [create list or arrays in batch](https://stackoverflow.com/questions/17605767/create-list-or-arrays-in-windows-batch)

    - List
        create a list : `set list=A B C D`
        process with `for` : 
        ```
        (for %%a in (%list%) do (
            echo %%a
            echo/
        ))> thefile.txt
        ```
    - Array
        create an array this way:
        ```
        setlocal EnableDelayedExpansion
        set n=0
        for %%a in (A B C D) do (
            set vecor[!n!]=%%a
            set /A n+=1
        )
        ```
        show the array elements this way
        ```
        (for /L %%i in (0,1,3) do (
            echo !vector[%%i]!
            echo/
        )) > theFile.txt
        ```
        if you use `for /L %%i in (0,1,%n%)` you should get them all, instead of just the first 3.

## [SCHTASK] create schedule task for windows

 @ECHO OFF
 SETLOCAL

 SET _src=\\FileServ1\user
 SET _dst=\\FileServ2\Back
 SET _what=/E /COPYALL /J
 SET _opt_bak=/R:1 /W:1 /LOG+:.\backup.log /TS /FP /TIMFIX /MOT:1
 SET _opt_revert=/R:1 /W:1 /LOG+:.\revert.log /TS /FP /TIMFIX

 SCHTASKS /Create /TN "backup_public" /TR backup.bat /ST 05:00 /ET 20:00 /SC DAILY /F /K
 ROBOCOPY %_dst% %_src% %_what% %_opt_bak%

 SCHTASKS /Create /TN "restore_public" /TR restore.bat /ST 20:01 /ET 04:59 /SC HOURLY /MO 1 /F /K
 ROBOCOPY %_dst% %_src% %_what% %_opt_revert%

  DIR /O:D /B *.bin 

## [schtasks example](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks#BKMK_minutes)

* __To schedule a task that runs every 100 minutes during non-business hours__

    The following command schedules a security script, Sec.vbs, to run on the local computer every 100 minutes between 5:00 P.M. and 7:59 A.M. each day. The command uses the /sc parameter to specify a minute schedule and the /mo parameter to specify an interval of 100 minutes. It uses the /st and /et parameters to specify the start time and end time of each day's schedule. It also uses the /k parameter to stop the script if it is still running at 7:59 A.M. Without /k, schtasks would not start the script after 7:59 A.M., but if the instance started at 6:20 A.M. was still running, it would not stop it.

    `schtasks /create /tn Security Script /tr sec.vbs /sc minute /mo 100 /st 17:00 /et 08:00 /k`

## [how to execute a scheduled task with "schtasks" wo opening a new window](https://superuser.com/questions/195249/how-to-execute-a-scheduled-task-with-schtasks-without-opening-a-new-command-li)

```vb
Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & "...\my_task.bat" & Chr(34), 0
Set WshShell = Nothing
```

saved it in `run_my_task.vbs` and scheduled `run_my_task.vbs` with `schtasks` as above.

## [have a task that runs every day and repeats every hour](https://stackoverflow.com/questions/21437787/schtasks-create-have-a-task-that-runs-every-day-and-repeats-every-hour)

Figured it out, Repeat Interval is essentially what I needed along with duration
Below is how to schedule something to run at 7:00 every day every 1 hour for a duration of 1 day.

`schtasks /create /tn "test" /tr "\"test.exe"" /sc DAILY /st 07:00 /f /RI 60 /du 24:00`
