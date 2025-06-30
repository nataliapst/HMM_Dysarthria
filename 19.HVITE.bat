@echo off
rem List of dysarthric and non-dysarthric patients
set disartria=F01 F03 F04 M01 M02 M03 M04 M05
set no_disartria=FC01 FC02 FC03 MC01 MC02 MC03 MC04

rem Loop through all combinations of dysarthric and non-dysarthric patients
for %%X in (%disartria%) do (
    for %%Y in (%no_disartria%) do (
        echo Running HVite for %%X with %%Y

        rem Loop from 1 to 40 to iterate over GMM models
        for /L %%Z in (1,1,40) do (
            echo Running HVite for %%X with %%Y in iteration %%Z (number of gaussian)

            HVite -H train_%%X_%%Y\hmm6_GMM%%Z\macro -H train_%%X_%%Y\hmm6_GMM%%Z\hmmdefs -S develop_%%X_%%Y.scp -l "*" -i recout_%%X_%%Y_%%Z.mlf -w wdnet1 dict.dict clases2.list
        )
      
