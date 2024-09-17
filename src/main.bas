type voidptr as any ptr
type create_iface_fn as function cdecl (byval as zstring ptr, byval as integer ptr) as voidptr

dim shared PLUGIN_CALLBACK_VERSION as zstring * 26 => "ISERVERPLUGINCALLBACKS002"

type plugin
	vtable as voidptr ptr
end type

' actually important functions

function get_plugin_description __Thiscall (byval this as voidptr) as zstring ptr export
	return @"shroom's freebasic plugin"
end function

function load __Thiscall (byval this as voidptr, byval iface1 as create_iface_fn, byval iface2 as create_iface_fn) as integer export
	return 1
end function

sub unload __Thiscall (byval this as voidptr) export

end sub

' stubs

sub pause __Thiscall (byval this as voidptr) export
end sub

sub unpause __Thiscall (byval this as voidptr) export
end sub

sub level_init __Thiscall (byval this as voidptr, byval map_name as zstring ptr) export
end sub

sub server_activate __Thiscall (byval this as voidptr, byval edict_list as voidptr, byval edict_count as integer, byval client_max as integer) export
end sub

sub game_frame __Thiscall (byval this as voidptr, byval simulating as integer) export
end sub

sub level_shutdown __Thiscall (byval this as voidptr) export
end sub

sub client_active __Thiscall (byval this as voidptr, byval entity as voidptr) export
end sub

sub client_disconnect __Thiscall (byval this as voidptr, byval entity as voidptr) export
end sub

sub client_put_in_server __Thiscall (byval this as voidptr, byval entity as voidptr, byval player_name as zstring ptr) export
end sub

sub set_command_client __Thiscall (byval this as voidptr, byval index as integer) export
end sub

sub client_settings_changed __Thiscall (byval this as voidptr, byval edict as voidptr) export
end sub

function client_connect __Thiscall (byval this as voidptr, byval allow_connect as integer ptr, byval entity as voidptr, byval client_name as zstring ptr, byval address as zstring ptr, byval reject as voidptr, byval max_reject_len as integer) as integer export
    return 0
end function

function client_command __Thiscall (byval this as voidptr, byval entity as voidptr, byval args as voidptr) as integer export
    return 0
end function

function network_id_validated __Thiscall (byval this as voidptr, byval user_name as zstring ptr, byval network_id as zstring ptr) as integer export
    return 0
end function

sub on_query_cvar_value_finished __Thiscall (byval this as voidptr, byval cookie as integer, byval player_entity as voidptr, byval status as integer, byval cvar_name as zstring ptr, byval cvar_value as zstring ptr) export
end sub

' vtable

dim shared vtable(17) as voidptr => { _
	@load,_
	@unload,_
	@pause,_
	@unpause,_
	@get_plugin_description,_
	@level_init,_
	@server_activate,_
	@game_frame,_
	@level_shutdown,_
	@client_active,_
	@client_disconnect,_
	@client_put_in_server,_
	@set_command_client,_
	@client_settings_changed,_
	@client_connect,_
	@client_command,_
	@network_id_validated,_
	@on_query_cvar_value_finished _
}

dim shared basic_plugin as plugin
basic_plugin.vtable = @vtable(0)

function create_iface cdecl alias "CreateInterface" (byval module_name as zstring ptr, byval ret as integer ptr) as voidptr export
	if *module_name = plugin_callback_version then
		if ret <> 0 then
			*ret = 0
		endif
		return @basic_plugin
	endif
	if ret <> 0 then
		*ret = 1
	endif
	return 0
end function
