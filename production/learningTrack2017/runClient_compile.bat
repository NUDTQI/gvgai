@echo off

set path=%PATH%;C:\Program Files\Java\jdk1.8.0_121\bin
set build_folder=build
set gson=gson-2.6.2.jar
set src=..\clients\GVGAI-JavaClient\src
set root_path=..\

rem Find all the .java files and list their paths in a file called 'source_list.txt'
break>source_list.txt
for /f %%i in ('forfiles /p %src% /s /m *.java /c "cmd /c echo @PATH"') do @echo %%~i >> source_list.txt

rem Make a build folder if none exists
if not exist %build_folder% mkdir %build_folder%

rem Build all java files saved in source_list.txt
for /f "tokens=*" %%A in (source_list.txt) do javac -d %build_folder% -cp %src%;%src%\ontology;%root_path%\gson-2.6.2.jar %%A

rem Run the JavaClient class	
java -agentlib:jdwp=transport=dt_socket,server=y,address=8000,suspend=n -cp %build_folder%;..\%gson% JavaClient 