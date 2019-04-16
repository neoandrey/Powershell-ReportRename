
 
 $filePath      = Read-Host  "Please enter the complete path to the folder" 

 $fileFilter    = Read-Host  "Please type a filter for the files to be renamed"
 $originalStr   = Read-Host  "Please enter the string in the filenames to be replaced"
 $replaceStr    = Read-Host  "Please enter the replacement string"
 $finalStr      = ""
   
   function  Get-SubFolders {

param (

[Parameter(Mandatory=$true) ][System.Object] $folder,
[Parameter(Mandatory=$true) ][System.Object] $filter,
[Parameter(Mandatory=$true) ][System.Object] $originalStr,
[Parameter(Mandatory=$true) ][System.Object] $replaceStr
 )


   Get-ChildItem  $folder | 
    Foreach-Object {
      $isDirectory = Test-Path  $_.FullName.ToString() -PathType Container
        if ($isDirectory -eq $true){
            
            $subFolder  = $_.FullName.ToString()


            Get-SubFolders $subFolder $filter $originalStr $replaceStr

         }else{

            $directory  =  $_.Directory.ToString();
            $name       =  $_.BaseName.ToString();
            $fileName   =  $_.FullName.ToString();
            $finalStr   =  $name.Replace($originalStr, $replaceStr); 
            $finalStr   =  "$directory\$finalStr"

            Write-Host  "Replacing  $originalStr with  $replaceStr in  $fileName ..."
	        Write-Host  "Renaming  to  $finalStr"
  
          try{ 
                    Write-Host "Running  Rename-Item -Path  $fileName  -NewName $finalStr "
			        Rename-Item -Path  $fileName  -NewName $finalStr
			        Write-Host  "Rename successful"
 
                    }catch{
             
                        Write-host -ForegroundColor yellow "Could not rename  $fileName  to $finalStr  ";
                    }


           }
         }
        
        
     


 



 }




 
   #Get-ChildItem $(filePath)  -Recurse | ?{ $_.PSIsContainer } | Select-Object FullName |
 
 Get-ChildItem -Path $filepath -Force -ErrorAction SilentlyContinue  |
  
 Foreach-Object {

    $folder            =  $_.FullName.ToString()
    $isDirectory       =  Test-Path  $_.FullName.ToString() -PathType Container

  if ($isDirectory -eq $true){

          Get-SubFolders $_.FullName.ToString() $fileFilter $originalStr $replaceStr

    } elseif($_.BaseName.ToString().Contains($fileFilter)) {
            

            $directory  =  $_.Directory.ToString();
            $name       =  $_.BaseName.ToString();
            $fileName   =  $_.FullName.ToString();
            $finalStr   =  $name.Replace($originalStr, $replaceStr); 
            $finalStr   =  "$directory\$finalStr"

            Write-Host  "Replacing  $originalStr with  $replaceStr in  $fileName ..."
	        Write-Host  "Renaming  to  $finalStr"
  
          try{ 
                    Write-Host "Running  Rename-Item -Path  $fileName  -NewName $finalStr "
			        Rename-Item -Path  $fileName  -NewName $finalStr
			        Write-Host  "Rename successful"
 
                    }catch{
             
                        Write-host -ForegroundColor yellow "Could not rename  $fileName  to $finalStr  ";
                    }
       
       
       
       
       
       }

 }




