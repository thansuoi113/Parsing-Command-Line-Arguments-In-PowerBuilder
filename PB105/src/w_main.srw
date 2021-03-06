$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_parse from commandbutton within w_main
end type
type sle_cmd from singlelineedit within w_main
end type
type lv_list from listview within w_main
end type
type st_1 from statictext within w_main
end type
type sle_key from singlelineedit within w_main
end type
type cb_value from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2171
integer height = 1032
boolean titlebar = true
string title = "Pasre Cmd"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_parse cb_parse
sle_cmd sle_cmd
lv_list lv_list
st_1 st_1
sle_key sle_key
cb_value cb_value
end type
global w_main w_main

type variables
n_parse_command in_cmd
end variables

forward prototypes
public subroutine wf_listarg ()
end prototypes

public subroutine wf_listarg ();String ls_arglist[]
Long ll_item, ll_row

lv_list.deleteitems( )

in_cmd.of_listarg( ls_arglist )

For ll_item = 1 To UpperBound(ls_arglist) - 1 Step 2
	ll_row++
	//lv_list.InsertItem(ll_row , ls_arglist[ll_item]  , 1)
	lv_list.AddItem(ls_arglist[ll_item], 1)
	lv_list.SetItem(ll_row, 2 , ls_arglist[ll_item + 1])
Next
end subroutine

on w_main.create
this.cb_parse=create cb_parse
this.sle_cmd=create sle_cmd
this.lv_list=create lv_list
this.st_1=create st_1
this.sle_key=create sle_key
this.cb_value=create cb_value
this.Control[]={this.cb_parse,&
this.sle_cmd,&
this.lv_list,&
this.st_1,&
this.sle_key,&
this.cb_value}
end on

on w_main.destroy
destroy(this.cb_parse)
destroy(this.sle_cmd)
destroy(this.lv_list)
destroy(this.st_1)
destroy(this.sle_key)
destroy(this.cb_value)
end on

event open;String ls_arg
ls_arg = Message.StringParm

sle_cmd.text = ls_arg

in_cmd.of_parse( ls_arg)

wf_listarg()

end event

type cb_parse from commandbutton within w_main
integer x = 1426
integer y = 64
integer width = 219
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Parse"
end type

event clicked;String ls_arg
ls_arg = sle_cmd.text
in_cmd.of_parse( ls_arg)
wf_listarg()
end event

type sle_cmd from singlelineedit within w_main
integer x = 37
integer y = 172
integer width = 2048
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type lv_list from listview within w_main
integer x = 37
integer y = 288
integer width = 2048
integer height = 576
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean labelwrap = false
boolean fullrowselect = true
boolean underlinehot = true
listviewview view = listviewreport!
long largepicturemaskcolor = 536870912
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event constructor;lv_list.Border = true	

lv_list.AddColumn("Key" , Left! , 250)
lv_list.AddColumn("Value" , Left! , 1600)

lv_list.SetColumn (1, "Key", Left!, 250)
lv_list.SetColumn (2, "Value", Left!, 1600)
end event

type st_1 from statictext within w_main
integer y = 64
integer width = 183
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Key:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_key from singlelineedit within w_main
integer x = 219
integer y = 64
integer width = 805
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type cb_value from commandbutton within w_main
integer x = 1061
integer y = 64
integer width = 366
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Get Value"
end type

event clicked;String ls_key, ls_value

ls_key = sle_key.Text

ls_value = in_cmd.of_getvalue( ls_key)

MessageBox("Value", ls_value)

end event

