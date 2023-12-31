$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type lb_file from listbox within w_main
end type
type cb_1 from commandbutton within w_main
end type
type lb_printer from listbox within w_main
end type
end forward

global type w_main from window
integer width = 2203
integer height = 1672
boolean titlebar = true
string title = "Printing"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
lb_file lb_file
cb_1 cb_1
lb_printer lb_printer
end type
global w_main w_main

type variables
nov_runprinter invo_printer
end variables

on w_main.create
this.lb_file=create lb_file
this.cb_1=create cb_1
this.lb_printer=create lb_printer
this.Control[]={this.lb_file,&
this.cb_1,&
this.lb_printer}
end on

on w_main.destroy
destroy(this.lb_file)
destroy(this.cb_1)
destroy(this.lb_printer)
end on

event open;
String ls_printer_name[]
Int li_i, li_rtn

li_rtn = invo_printer.of_getprinterlist(ls_printer_name)
For li_i = 1 To  UpperBound(ls_printer_name)
	lb_printer.InsertItem ( ls_printer_name[li_i], li_i)
Next

If lb_printer.TotalItems( ) > 0 Then
	String ls_name
	ls_name = invo_printer.of_getprinterdefalut()
	lb_printer.SelectItem(  ls_name, 1)
End If

String ls_path

ls_path = invo_printer.of_getmodulepath( )

lb_file.AddItem(ls_path + "\cust1.pdf")
lb_file.AddItem(ls_path + "\cust2.pdf")

end event

type lb_file from listbox within w_main
integer x = 73
integer y = 768
integer width = 2048
integer height = 736
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

type cb_1 from commandbutton within w_main
integer x = 73
integer y = 608
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Printing"
end type

event clicked;Int li_i
String ls_printer, ls_pdf

ls_printer = lb_printer.Text(lb_printer.SelectedIndex( ))

For li_i = 1 To lb_file.TotalItems( )
	ls_pdf = lb_file.Text(li_i)
	invo_printer.of_printing( ls_pdf, ls_printer)
Next

end event

type lb_printer from listbox within w_main
integer x = 73
integer y = 32
integer width = 2048
integer height = 544
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

