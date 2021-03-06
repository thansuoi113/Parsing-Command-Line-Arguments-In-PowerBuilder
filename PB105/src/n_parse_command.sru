$PBExportHeader$n_parse_command.sru
forward
global type n_parse_command from nonvisualobject
end type
end forward

global type n_parse_command from nonvisualobject autoinstantiate
end type

type variables
String is_arg[]
Int ii_numerror
end variables

forward prototypes
public function integer of_parse (string as_arg)
public function string of_msg (integer ai_numerror)
public function integer of_getvalue (string as_key, ref string as_value)
public function string of_getvalue (string as_key)
public subroutine of_listarg (ref string as_arg[])
end prototypes

public function integer of_parse (string as_arg);//====================================================================
// Function: n_parse_command.of_parse()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_arg	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/03/13
//--------------------------------------------------------------------
// Usage: n_parse_command.of_parse ( string as_arg )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_argcnt, li_arg, li_argnew
String ls_arg[], ls_argline, ls_cmd
Long ll_pos
Boolean lb_key
String ls_prefixkey

is_arg = ls_arg
ls_cmd = Trim(as_arg)

If IsNull(ls_cmd) Or Len(Trim(ls_cmd)) = 0 Then 
	ii_numerror = -3
	Return -3
End If

li_argcnt = 0

Do While Len(ls_cmd ) > 0
	li_argcnt++
	
	// Check for quotes
	If Left(ls_cmd, 1) = "'" Then
		// Find the end single quote
		ll_pos = Pos( ls_cmd, "'", 2)
	ElseIf Left(ls_cmd, 1) = '"' Then
		// Find the end double quote
		ll_pos = Pos( ls_cmd, '"', 2)
	Else
		// Find the first blank
		ll_pos = Pos( ls_cmd, " " )
	End If
	
	// If no blanks (only one argument), 
	// set i to point to the hypothetical character
	// after the end of the string
	If ll_pos = 0 Then
		ll_pos = Len(ls_cmd) + 1
	End If
	
	// Assign the arg to the argument array. 
	// Number of chars copied is one less than the 
	
	// position of the space found with Pos
	ls_argline = Left( ls_cmd, ll_pos - 1 )
	
	// Remove the argument from the string 
	// so the next argument becomes first
	If Left(ls_cmd, 1) = "'" Or Left(ls_cmd, 1) = '"' Then
		ls_cmd = Trim(Replace( ls_cmd, 1, ll_pos + 1, "" ))
		
		// Remove first quote
		ls_argline = Replace( ls_argline, 1, 1, "" )
	Else
		ls_cmd = Trim(Replace( ls_cmd, 1, ll_pos, "" ))
	End If
	
	ls_arg[li_argcnt] = ls_argline
Loop

If li_argcnt = 0 Then
	ii_numerror = -3
	Return -3
End If

//Parse argument null
lb_key = False
li_argnew = 0
For li_arg = 1 To li_argcnt
	ls_prefixkey = Trim(Left(Trim(ls_arg[li_arg]), 1))
	If ls_prefixkey = "-" Or  ls_prefixkey = "--" Or ls_prefixkey = "/" Then
		If lb_key Then
			li_argnew ++
			is_arg[li_argnew] = ""
		End If
		lb_key = True
	Else
		lb_key = False
	End If
	li_argnew ++
	is_arg[li_argnew] = ls_arg[li_arg]
Next

If lb_key Then
	li_argnew ++
	is_arg[li_argnew] = ""
End If

Return UpperBound(is_arg)
end function

public function string of_msg (integer ai_numerror);String ls_msg

Choose Case ai_numerror
	Case -1
		ls_msg = "Key Not Found"
	Case -2
		ls_msg = "Key Is Null"
	Case -3
		ls_msg = "No Arguments Found"
	Case Else
		ls_msg = ""
End Choose

Return ls_msg


end function

public function integer of_getvalue (string as_key, ref string as_value);//====================================================================
// Function: n_parse_command.of_getvalue()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	string	as_key  	
// 	reference	string	as_value	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/03/13
//--------------------------------------------------------------------
// Usage: n_parse_command.of_getvalue ( string as_key, ref string as_value )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Boolean lb_keyfound
Int li_argcnt,  li_arg
String ls_value, ls_keyline

If IsNull(as_key) Or Len(Trim(as_key)) = 0 Then
	ii_numerror = -2
	Return -2
End If

as_key = Trim(as_key)

li_argcnt = UpperBound(is_arg)

If li_argcnt <= 0 Then
	ii_numerror = -3
	Return -3
End If

For li_arg = 1 To li_argcnt Step 2
	ls_keyline = is_arg[li_arg]
	If   Upper(ls_keyline) = ( "-" + Upper( as_key)) Or  Upper(ls_keyline) = ( "--" +  Upper(as_key)) Or  Upper(ls_keyline) = ( "/" +  Upper(as_key)) Then
		If li_arg < li_argcnt Then
			ls_value = is_arg[li_arg + 1]
			lb_keyfound = True
			Exit
		End If
	End If
Next

If lb_keyfound Then
	as_value = ls_value
	ii_numerror = 1
	Return 1
Else
	ii_numerror = -1
	Return -1
End If

end function

public function string of_getvalue (string as_key);String ls_value
Int li_return

li_return = of_getvalue(as_key, ls_value)
Return ls_value

end function

public subroutine of_listarg (ref string as_arg[]);as_arg = is_arg
end subroutine

on n_parse_command.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_parse_command.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

