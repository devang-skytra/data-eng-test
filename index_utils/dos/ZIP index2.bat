cd /d c:

REM del c:\git\index2.zip

"C:\Program Files (x86)\7-Zip\7z" a -tzip -x!index2\.git -xr!*TEMPLATE.sql -xr!*.md c:\git\index2.zip c:\git\index2
