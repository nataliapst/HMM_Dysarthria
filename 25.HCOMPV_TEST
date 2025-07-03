@echo off
rem Automatically generated to run HCompV with all combinations

rem Enable delayed expansion
setlocal EnableDelayedExpansion

rem Dysarthric subjects
set DYSARTHRIA=F01 F03 F04 M01 M02 M03 M04 M05
rem Non-dysarthric subjects
set NO_DYSARTHRIA=FC01 FC02 FC03 MC01 MC02 MC03 MC04

rem Base directory
set BASE_DIR=C:\Users\root\Desktop\htk-3.2.1

for %%X in (%DYSARTHRIA%) do (
    for %%Y in (%NO_DYSARTHRIA%) do (
        rem Create output folder train_develop/HMM0 if it doesn't exist
        set OUTPUT_DIR=!BASE_DIR!\train_develop_%%X_%%Y\hmm0
        if not exist "!OUTPUT_DIR!" (
            mkdir "!OUTPUT_DIR!"
        )
        echo Running HCompV for train_%%X_%%Y.scp
        HCompV -f 0.01 -m -S train_develop_%%X_%%Y.scp -M "!OUTPUT_DIR!" proto.txt
    )
)

echo All HCompV commands have been executed.
pause
