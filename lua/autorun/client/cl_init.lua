

	DDP = {}
	DDP.frame = nil
	DDP.elemente = {}
	DDP.selected = {}
	DDP.VGUI={}
	DDP.vgui = {}
	DDP.test ={}
	DDP.toolbox = {}
	DDP.MousePos = {0,0}
	DDP.MousePressed = { 0, 0 }
	DDP.Mousemove = false
	DDP.Mousepress = false
	DDP.Name = "Empty"
	DDP.copied = {}
	DDP.icon = ""

	--RunConsoleCommand("disconnect")
	
	local modules = file.Find( "lua/designer/modules/*.lua", "GAME" )
	local gui_modules = file.Find( "lua/designer/gui/*.lua", "GAME" )

	local head = 
[[==============================================================
	   Royal Derma Designer Version Alpha 0.1
==============================================================]]
local footer = 
[[==============================================================
	   
==============================================================]]

	MsgC( Color( 255, 0, 0 ), head .. "\n" )
	for _, file in ipairs( gui_modules ) do
		MsgC( Color( 255,215,0 )," [Royal Derma Designer] " , Color( 255, 255, 255 ), "Loading GUI module: " .. file .. " \n" )
		include( "designer/gui/" .. file )
	end

	for _, file in ipairs( modules ) do
		MsgC( Color( 255,215,0 )," [Royal Derma Designer] ", Color( 255, 255, 255 ), "Loading module: " .. file .. " \n" )
		include( "designer/modules/" .. file )
	end


	include( "designer/core/cl_main.lua" )
	MsgC( Color( 255, 0, 0 ), footer .. "\n" )



	

