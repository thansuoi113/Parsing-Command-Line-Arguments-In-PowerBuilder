$PBExportHeader$parsecmd.sra
$PBExportComments$Generated Application Object
forward
global type parsecmd from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type parsecmd from application
string appname = "parsecmd"
end type
global parsecmd parsecmd

on parsecmd.create
appname="parsecmd"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on parsecmd.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String ls_cmd

ls_cmd = Trim(CommandParm())
//ls_cmd ="-a gaga -t ooo -y"

openwithparm(w_main, ls_cmd)
end event

