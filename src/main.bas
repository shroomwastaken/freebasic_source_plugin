#define voidptr any ptr
#define create_iface_fn function cdecl (byref name as zstring, byref ret as integer) as voidptr

dim shared PLUGIN_CALLBACK_VERSION as zstring * 26 => "ISERVERPLUGINCALLBACKS002"
dim shared PLUGIN_DESC as zstring * 26 => "shroom's freebasic plugin"

function get_plugin_description __THISCALL (byval this as voidptr) as zstring ptr export
	return @PLUGIN_DESC
end function

sub stub() export

end sub

function load __THISCALL (byval this as voidptr, byval iface1 as create_iface_fn, byval iface2 as create_iface_fn) as integer export
	return 1
end function

sub unload __THISCALL (byval this as voidptr) export

end sub

dim shared VTABLE(17) as voidptr => { _
	@load ,_
	@unload ,_
	@stub ,_
	@stub ,_
	@get_plugin_description ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub ,_
	@stub _
}


function create_iface cdecl alias "CreateInteface" (byref iface_name as zstring, byref ret as integer) as voidptr export
	if (iface_name = PLUGIN_CALLBACK_VERSION) then
		if (ret <> 0) then
			ret = 0
		endif
		return @VTABLE(1)
	endif
	if (ret <> 0) then
		ret = 1
	endif
	return 0
end function
