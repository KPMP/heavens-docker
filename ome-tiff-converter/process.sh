#!/bin/bash
CWD="toBeProcessed"
CWDTWO=$CWD"/unzipped"
mkdir unzipped

#handle zip and non-zipped correctly
for fileAndDir in "$CWD"/*; do
  if [[ "$fileAndDir" == *".zip"* ]]; then
    packageNameWithExtension=$(echo $fileAndDir| cut -d'/' -f 2)
    packageNameWithoutExtension=$(echo $packageNameWithExtension| cut -d'.' -f 1)
    unzip $fileAndDir -d unzipped/$packageNameWithoutExtension

    for unzippedPackage in "unzipped/$packageNameWithoutExtension/*"; do
      for file in $unzippedPackage; do
          filenameWithExtension=$(echo $file | cut -d'/' -f 3)
          filenameWithoutExtension=$(echo $filenameWithExtension| cut -d'.' -f 1)
          newFilename=$filenameWithoutExtension'-ome.tif'

          bioformats2raw $file processing/ \
              && raw2ometiff processing/ processedData/$newFilename
          rm -rf processing/
          
        #todo remove duplicate code
        bftools/tiffcomment processedData/$newFilename > ome.xml
        if [[ "$newFilename" == *"stained"* ]]; then

          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0']/@Name" -v "DAPI" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0'][not(@Name)]" -type attr --name "Name"  -v "DAPI" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1']/@Name" -v "Phalloidin" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1'][not(@Name)]" -type attr --name "Name"  -v "Phalloidin" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2']/@Name" -v "Sheep anti-THP (Uromodulin)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2'][not(@Name)]" -type attr --name "Name"  -v "Sheep anti-THP (Uromodulin)" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3']/@Name" -v "Goat anti-AQP1 (Aquaporin-1, indirect)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3'][not(@Name)]" -type attr --name "Name"  -v "Goat anti-AQP1 (Aquaporin-1, indirect)" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:4']/@Name" -v "Rabbit anti-MPO (Myeloperoxidase, indirect)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:4'][not(@Name)]" -type attr --name "Name"  -v "Rabbit anti-MPO (Myeloperoxidase, indirect)" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:5']/@Name" -v "Mouse anti-CD68 (indirect)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:5'][not(@Name)]" -type attr --name "Name"  -v "Mouse anti-CD68 (indirect)" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:6']/@Name" -v "Mouse anti-CD3" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:6'][not(@Name)]" -type attr --name "Name"  -v "Mouse anti-CD3" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:7']/@Name" -v "Mouse anti-Siglec8" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:7'][not(@Name)]" -type attr --name "Name"  -v "Mouse anti-Siglec8" ome.xml


      elif [[ "$newFilename" == *"labelfree"* ]]; then
      echo labelfree 
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0']/@Name" -v "Second harmonics (collagens)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0'][not(@Name)]" -type attr --name "Name"  -v "Second harmonics (collagen)" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1']/@Name" -v "Autofluorescense2" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1'][not(@Name)]" -type attr --name "Name"  -v "Autofluorescense1" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2']/@Name" -v "Autofluorescense2" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2'][not(@Name)]" -type attr --name "Name"  -v "Autofluorescense2" ome.xml
          xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3']/@Name" -v "Autofluorescense3" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3'][not(@Name)]" -type attr --name "Name"  -v "Autofluorescense3" ome.xml
      fi

      bftools/tiffcomment -set ome.xml processedData/$newFilename
      rm ome.xml
      done
    done
  fi
done

#### unzipped already

for unzippedPackage in "$CWD"/*; do
  for file in "$unzippedPackage"/*; do
      echo $file
      filenameWithExtension=$(echo $file | cut -d'/' -f 3)
      filenameWithoutExtension=$(echo $filenameWithExtension| cut -d'.' -f 1)
      newFilename=$filenameWithoutExtension'-ome.tif'
      echo $file
   
   
   
   
      bioformats2raw $file processing/ \
          && raw2ometiff processing/ processedData/$newFilename
      rm -rf processing/


      bftools/tiffcomment processedData/$newFilename > ome.xml
      if [[ "$newFilename" == *"stained"* ]]; then

        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0']/@Name" -v "DAPI" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0'][not(@Name)]" -type attr --name "Name"  -v "DAPI" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1']/@Name" -v "Phalloidin" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1'][not(@Name)]" -type attr --name "Name"  -v "Phalloidin" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2']/@Name" -v "Sheep anti-THP (Uromodulin)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2'][not(@Name)]" -type attr --name "Name"  -v "Sheep anti-THP (Uromodulin)" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3']/@Name" -v "Goat anti-AQP1 (Aquaporin-1, indirect)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3'][not(@Name)]" -type attr --name "Name"  -v "Goat anti-AQP1 (Aquaporin-1, indirect)" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:4']/@Name" -v "Rabbit anti-MPO (Myeloperoxidase, indirect)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:4'][not(@Name)]" -type attr --name "Name"  -v "Rabbit anti-MPO (Myeloperoxidase, indirect)" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:5']/@Name" -v "Mouse anti-CD68 (indirect)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:5'][not(@Name)]" -type attr --name "Name"  -v "Mouse anti-CD68 (indirect)" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:6']/@Name" -v "Mouse anti-CD3" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:6'][not(@Name)]" -type attr --name "Name"  -v "Mouse anti-CD3" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:7']/@Name" -v "Mouse anti-Siglec8" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:7'][not(@Name)]" -type attr --name "Name"  -v "Mouse anti-Siglec8" ome.xml


    elif [[ "$newFilename" == *"labelfree"* ]]; then
    echo labelfree 
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0']/@Name" -v "Second harmonics (collagens)" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:0'][not(@Name)]" -type attr --name "Name"  -v "Second harmonics (collagen)" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1']/@Name" -v "Autofluorescense1" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:1'][not(@Name)]" -type attr --name "Name"  -v "Autofluorescense1" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2']/@Name" -v "Autofluorescense2" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:2'][not(@Name)]" -type attr --name "Name"  -v "Autofluorescense2" ome.xml
        xmlstarlet ed --inplace -u "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3']/@Name" -v "Autofluorescense3" --insert "//_:OME/_:Image/_:Pixels/_:Channel[@ID='Channel:0:3'][not(@Name)]" -type attr --name "Name"  -v "Autofluorescense3" ome.xml
    fi

    bftools/tiffcomment -set ome.xml processedData/$newFilename
    rm ome.xml
  
 done
done



