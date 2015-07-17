

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

	function PointOnCircle( ang, radius, offX, offY )
	ang = math.rad( ang )
	local x = math.cos( ang ) * radius + offX
	local y = math.sin( ang ) * radius + offY
	return x, y
	end

	function ASTS()

	 
	end

	hook.Add("HUDPaint", "draw", ASTS )




	local val = 1

	function nullstelle( a,b,c,d,max )



	print( "" .. a[1] .. " * " .. val .. " ^" .. a[2] .. " " .. 0+ b[1] .. " * " ..  val .. "^ " .. b[2] .. " " .. 0+ c[1] .. " * " .. val .. "^ " .. c[2] .. " + " .. 0 + d[1] .. " = " ..  ( a[1] * val ^ a[2] ) + ( b[1] * val ^ b[2] ) + ( c[1] * val ^ c[2] ) + d[1] )
	if( val == 0 ) then print( "sorry zu gross" ) val = 1 return  end

	if( a[1] * val ^a[2] + b[1] * val ^ b[2] + c[1] * val ^ c[2] + d[1] != 0 ) then
		if( val > max ) then
			val = -max
		end
		val = val + 1
		nullstelle( a,b,c,d,max )

	else

		print( val )

	end
	end

--plyInput = { "!announce", "Du", "bist", "eine","kleine", "schwuchtel" } local message = "" if( #plyInput > 2 ) then for k,v in ipairs( plyInput ) do if( k == 1 ) then else message = message .. " " .. v end end end print( message )


