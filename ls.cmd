@ECHO OFF

set ARGS=

IF "%1"=="" GOTO NOARGS
IF "%1"=="-l" GOTO LIST
IF "%1"=="-la" GOTO LISTALL

:NOARGS
set ARGS=/B
GOTO EXEC

:LIST
set ARGS=
GOTO EXEC

:LISTALL
set ARGS=/L /Q /R
GOTO EXEC

:EXEC
dir * %ARGS%

:END
