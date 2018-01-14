



surface.CreateFont( "Button", {
	font = "DermaDefault",
	size = ScrH() * .0166,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

--RunString
if( !file.IsDir("DD/db","DATA" ) ) then
	file.CreateDir("DD/db")
end

local head = 
[[==============================================================
	   Royal Derma Designer Version Alpha 45w15b
==============================================================
			Changelog


		   Open DermaDesigner
		    Command: open_dd


]]
local footer = 
[[==============================================================
	   
==============================================================]]

MsgC( Color( 255,215,0 ), head .. "\n" )
MsgC( Color( 255,215,0 ), footer .. "\n" )


	DDP = {}
	DDP.version = "Alpha 45w15b"
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

--[[---------------------------------------------------------
Name: FilterString( string )
-----------------------------------------------------------]]
local function FilterString( str )

newstring = ""

    for i=1,#str do

     if( string.sub( str, i, i ) == "(" or string.sub( str, i, i )  == ")" ) then
        else
         newstring = newstring .. string.sub( str, i, i )
        end
    end
    return newstring
end


--[[---------------------------------------------------------
Name: GetValidMethod( panel, string )
-----------------------------------------------------------]]
local function GetValidMethod( panel ,method )

Check = false
panel = panel
if( method == nil ) then return false end

	local Rstring = [[
				local succ, err = pcall( function() panel:Get]] .. FilterString( method ) .. [[()]] .. [[ end )  if( succ ) then Check = true else Check = false end	]]
	RunString(Rstring)

	return Check
end

--[[---------------------------------------------------------
Name: GetValueOfMethod( number, string )
Desc: Get the Value of spec. panel( not mainframe )
-----------------------------------------------------------]]
local function GetValueOfMethod( index, method )

if( method == nil ) then return nil end

ValueOfMethod = nil

RunString( "ValueOfMethod = DDP.elemente[" ..index .. "]:Get" .. FilterString( method )  .. "()" )

return ValueOfMethod

end

--[[---------------------------------------------------------
Name: GetTypByString( string )
-----------------------------------------------------------]]
function GetTypByString( str )

t = nil
local tab = {}

	if( string.find(  string.lower(str), "col" , 0, true )  or string.find(  string.lower(str), "color" , 0, true ) ) then

		return "color"
	elseif( string.find(  string.lower(str), "tonumber" , 0, true ) ) then
		return "number"
	elseif( string.find(  string.lower(str), "format" , 0, true ) ) then
		return "string"
	elseif( string.find(  string.lower(str), ":len(" , 0, true ) ) then
		return "number"
	elseif( string.find(  string.lower(str), "vector" , 0, true ) ) then
		return "vector"
	elseif( string.find(  string.lower(str), "==" , 0, true ) or string.find(  string.lower(str), ">" , 0, true ) or string.find(  string.lower(str), "<" , 0, true ) ) then
		return "boolean"
	elseif( string.find(  string.lower(str), "self" , 0, true ) ) then
		return "nil"
	elseif( string.find( string.lower( str ), "%a%.%a", 0, false ) ) then
		return "table"
	elseif( string.find(  string.lower(str), "+" , 0, true ) or string.find(  string.lower(str), "-" , 0, true ) or string.find(  string.lower(str), "*" , 0, true ) or string.find(  string.lower(str), "/" , 0, true )  ) then
		return "number"
	else
		RunString( " t = type( " .. FilterString( str ) .. " ) " )
		tab[1] = t
		t = nil

		return tab[1]
	end
end

--[[---------------------------------------------------------
Name: GetPosition( string )
-----------------------------------------------------------]]
function GetPosition( str )

local s,e = string.find( str ,"%d+")

local cleanstring = (string.TrimRight( string.sub( str, s, string.len(str)), "]"  ) .. "\n")

	return {x = string.Explode(",",cleanstring)[1], y = string.Explode(",",cleanstring)[2]}
end

--[[---------------------------------------------------------
Name: TrimString( string )
-----------------------------------------------------------]]
local function TrimString( str )

local s,e = string.find(  string.lower(str), "(" , 0, true ) 
local s1,e1 = string.find(  string.lower(str), ")" , #str-1, true ) 

return string.Trim(string.sub( str, e+1, #str-2 )," " )

end
--[[---------------------------------------------------------
   Name: GetFileByClassName
-----------------------------------------------------------]]
function GetFileByClassName( classname )

local files, dir = file.Find( "vgui/*.lua", "LUA", "nameasc" )
	for k,v in ipairs( files ) do
		local content = string.Explode( "\n", file.Read( "vgui/" .. v .. "", "LUA" ) )
		for a,b in ipairs( content ) do
			local qmarks = [["]]
			local s,e = string.find( b, "derma.DefineControl", 1, false )
			if( e != nil ) then
				local s1,e1 = string.find( b, qmarks, e, false )
				local s2,e2 = string.find( b, qmarks, e1+1, false )
				local CName = string.sub( b, s1+1, e2-1 )
				classname = string.lower( classname )
				CName = string.lower( CName )
				if( classname == CName ) then
					return { cname = CName, file = v }
				else
				end
			end
		end 
	end
end

--[[---------------------------------------------------------
Name: GetCatImage( )
-----------------------------------------------------------]]
function GetCatImage( n )
 n = string.lower(n)
 t = {}
 local val = ""
	local files, dir = file.Find( "materials/DD/icons/*.png", "GAME")
		for k,v in ipairs( files ) do

			local name = string.lower(string.TrimRight( v, ".png") )
			if( string.find(  n, string.lower(name) , 0 ) ) then
				table.insert( t, name )
			else
				table.insert( t, "!" )
			end

		end
		for k,v in ipairs( files ) do

			local str = string.lower(string.TrimRight( v, ".png") )

			if( string.find(  str, string.lower(t[1]) , 0 )  ) then

				val = v
			else
				val = "default.png"
			end

		end
		return val
   end

--[[---------------------------------------------------------
   Name: GetClassNameByFile( )
-----------------------------------------------------------]]
function GetClassNameByFile( f )

local needle = { "derma.DefineControl","vgui.Register" }
local t = {}
local b = {}

		local str =  file.Read("vgui/".. f .. "","LUA") or ""
		--	print( str )
			for key,value in ipairs( string.Explode( "\n", str ) ) do

			local found = string.find(  string.lower(value), string.lower(needle[1]) , 0 )
			if( found ) then
				table.insert( t, value )
			end

			local found1 = string.find(  string.lower(value), string.lower(needle[2]) , 0 )
			if( found1 ) then
				table.insert( t, value )
			end

			end
		for k,v in ipairs( t ) do

	local classname = (string.Explode( "" .. [["]] .. "", v )[2] )
		if( classname != nil and classname != "" ) then
			if( vgui.GetControlTable(classname) ) then
				--print( classname )
			table.insert( b, classname ) 
			end

		end

	end

	return b[1]

end

--[[---------------------------------------------------------
   Name: UpdatePanelRank( string )
-----------------------------------------------------------]]
function UpdatePanelRank( name )

	local f = util.JSONToTable( file.Read( "dd/db/vgui_names.txt", "DATA" ) )

	for k,v in ipairs( f ) do

		if( v.classname == name ) then
			v.count = v.count + 1
		end
			
	end
		
	file.Write( "dd/db/vgui_names.txt", util.TableToJSON( f ) )

	hook.Call( "DDP_UpdatePanelRank", nil, name )
end

--[[---------------------------------------------------------
   Name: GetAllPanels
-----------------------------------------------------------]]
function GetAllPanels()
local time = CurTime()
local needle = { "derma.DefineControl","vgui.Register","AccessorFunc","self:Set" }
local ingnore = { "SetDraggableName","SetPanel", "SetPropertySheet", "SetPos", "SetSize", "SetTall", "SetWide","SetHeight","SetVisible", "SetKeyboardInputEnabled", "SetMouseInputEnabled","if","end","return"}
local known = { {name = "SetSaturation", typ = "number"}, { name = "SetHue", typ = "number" }, { name = "SetConVar", typ = "string" }, { name = "SetModel", typ = "string"}, {name = "SetToolTip",  typ = "string" }, { name = "SetMin", typ = "number"}, { name = "SetMax", typ = "number"}, { name = "SetTitle", typ = "string"}, { name = "SetAlpha", typ = "number"}, { name = "SetExpanded", typ = "boolean"}, { name = "SetText", typ = "string" }, { name = "SetValue", typ = "number" }, { name = "SetCaretPos", typ = "number" }, { name = "SetColor", typ = "color" }, { name = "SetFont", typ = "string" }, { name = "SetExpanded", typ = "boolean" }, { name = "SetZPos", typ = "number" }}


local t = {}
local m = {}
local files, dir = file.Find( "vgui/*.lua", "LUA", "nameasc" )
if( !file.Exists( "dd/db/vgui_raw.txt","DATA") ) then

	for k,v in ipairs( files ) do
		local str =  file.Read("vgui/".. v .. "","LUA") or ""
		--	print( str )
			for key,value in ipairs( string.Explode( "\n", str ) ) do

			local found = string.find(  string.lower(value), string.lower(needle[1]) , 0 )
			if( found ) then
				table.insert( t, value )
			end

			local found1 = string.find(  string.lower(value), string.lower(needle[2]) , 0 )
			if( found1 ) then
				table.insert( t, value )
			end

			end
	end

    file.Write("dd/db/vgui_raw.txt", util.TableToJSON( t ) )
else
    t = util.JSONToTable( file.Read( "dd/db/vgui_raw.txt","DATA" ) )
end
  


//	if( !file.Exists( "dd/db/vgui.txt","DATA") and !file.Exists( "dd/db/vgui_names.txt","DATA") ) then

	--[[---------------------------------------------------------
   		local str =  file.Read("vgui/".. v .. "","LUA") or ""
			--	print( str )
			--AccessorFuncs
			for key,value in ipairs( string.Explode( "\n", str ) ) do

				local found = string.find(  string.lower(value), string.lower(needle[3]) , 0 )
				if( found ) then
				local name = (string.Explode( "" ..  .. "", value )[4] )
					if( GetClassNameByFile( v ) != nil ) then
						if( DDP.vgui[ GetClassNameByFile( v ) ] ) then
							table.insert( DDP.vgui[ GetClassNameByFile( v )], name )
						else
							DDP.vgui[ GetClassNameByFile( v ) ] = {}
						end
					end
				end
			end

	-----------------------------------------------------------]]
		for k,v in ipairs( files ) do

		--All SetValues
        --RunString
		local str =  file.Read("vgui/".. v .. "","LUA") or ""
			for key,value in ipairs( string.Explode( "\n", str ) ) do
				local found = string.find(  string.lower(value), string.lower(needle[4]) , 0 )
               -- print( DDP.vgui[#DDP.vgui] )
				if( found ) then
					local name = (string.Explode( "" .. [[) ]] .. "", value ) )
					local show = true
					local func = ""
					local typ = ""
                    
						for a,b in ipairs( name ) do

							for c,d in ipairs( ingnore ) do

								if( string.find(  string.lower(b), string.lower(d) , 0 ) ) then
									show = false
								end
							end
							if( #name > 1 ) then
							func = func .. " " .. b
							else 
							func = name[1]
							end
						end

					local s,e = string.find(  string.lower(func), string.lower("self:") , 0 ) 
					func = string.sub( func, e+1, #func )
					local s,e = string.find(  string.lower(func), "(" , 0, true ) 
					typ = string.sub( func, e, #func )

					--get typ
					
					if( show ) then
				
		
						if( GetClassNameByFile( v ) != nil ) then
							if( DDP.vgui[GetClassNameByFile( v )] != nil ) then
							local f = false
							local exist = false
							local content = {}
						
								for a,b in ipairs( known ) do
								
									if( string.find(  string.lower(func), string.lower(b.name) , 0 ) ) then f = true content = known[a]  end

								end

								-- method exists
								 for a,b in ipairs( DDP.vgui[GetClassNameByFile( v )] ) do

									if( string.find(  string.lower(func), string.lower(b.name) , 0 ) ) then exist = true end

								 end

								if( !exist ) then
								
									if( f ) then
										table.insert(DDP.vgui[GetClassNameByFile( v )], content )

									else
										table.insert(DDP.vgui[GetClassNameByFile( v )], { name = string.Explode( "(", func )[1], typ =  GetTypByString(TrimString(typ)) } )

									end
								end
							else
							DDP.vgui[GetClassNameByFile( v )] = {}
							local f = false
							local content = {}
								for a,b in ipairs( known ) do
									
									if( string.find(  string.lower(func), string.lower(b.name) , 0 ) ) then f = true content = known[a]  end

								end
								if( f ) then
									if( #content < 1 ) then
									else
										table.insert(DDP.vgui[GetClassNameByFile( v )], content )

									end
								else
									table.insert(DDP.vgui[GetClassNameByFile( v )], { name = string.Explode( "(", func )[1], typ =  GetTypByString(TrimString(typ)) } )

								end
								
							end
						else

						end
				--	print(func)
					end
				else

				end

			end
		end
    --    print( "check" )
        
        if( #table.GetKeys( DDP.vgui ) > 0 ) then
        print( "Write DDP.vgui")
		    file.Write( "dd/db/vgui.txt", util.TableToJSON( DDP.vgui ) )
        end


	for k,v in ipairs( t ) do
		local classname = (string.Explode( "" .. [["]] .. "", v )[2] )
		if( classname != nil and classname != "" ) then
			if( vgui.GetControlTable(classname) ) then
				table.insert( DDP.toolbox, { classname = classname, count = 0 } ) 
			end
		end
	end
    if( #DDP.toolbox > 0 ) then
	  file.Write( "dd/db/vgui_names.txt", util.TableToJSON( DDP.toolbox ) )
	else
        if( file.Exists( "dd/db/vgui.txt","DATA" ) ) then
		    local tab = util.JSONToTable( file.Read( "dd/db/vgui.txt","DATA" ) )
             DDP.vgui = table.Copy( tab )
        end
        if( file.Exists( "dd/db/vgui_names.txt","DATA" ) ) then
		    local names = util.JSONToTable( file.Read( "dd/db/vgui_names.txt","DATA" ) )
		    DDP.toolbox = table.Copy( names )
        end
	end
	--PrintTable( DDP.vgui )
hook.Call( "DDP_panelswasloaded", nil, name )	
end
GetAllPanels()



//RunString("if(DDP.selected[1]:Get" .. string.Right( b, string.len( b )-3 ).. "() != nil ) then AS[1] = type(DDP.selected[1]:Get" .. string.Right( b, string.len( b )-3 ).. "() ) else Msg(tostring(NIL)end")

--[[---------------------------------------------------------
 Name: GetCurrentCode(  )
-----------------------------------------------------------]]
function GetCurrentCode( )

local parent = "frame"
local fname = "RunWindow"
local ostr = ""

local header = [[
local function ]] .. fname .. [[()
local frame = vgui.Create("]] .. DDP.frame:GetTable().Derma.ClassName .. [[")
frame:SetPos( ]] .. DDP.frame.x / ScrW() .. [[ * ScrW(), ]] .. DDP.frame.y / ScrH() .. [[ * ScrH() )
frame:SetSize( ]] .. DDP.frame:GetWide() / ScrW() .. [[ * ScrW(), ]] .. DDP.frame:GetTall() / ScrH() .. [[ * ScrH() )
frame:MakePopup() 
]]

-- Bug if list includes [null] clear list before! ( Codeview )

for k,v in ipairs( DDP.elemente ) do
    if( v != nil ) then
        if( v:IsValid() ) then
	         str = [[ local e = vgui.Create( "]] .. v.ClassName .. [[", ]] .. parent .. [[ )
						 e:SetPos( ]] .. v.x / DDP.frame:GetWide()  .. " * " .. parent .. [[:GetWide(), ]] .. v.y / DDP.frame:GetTall() .. " * " ..  parent .. [[:GetTall() )
						 e:SetSize( ]] .. v:GetWide() / DDP.frame:GetWide() .. " * " .. parent .. [[:GetWide(), ]] .. v:GetTall() / DDP.frame:GetTall() .. " * " ..  parent .. [[:GetTall() )
				]] 
   
	        for a,b in ipairs( DDP.vgui[v.ClassName] or {} ) do

		        if( GetValidMethod( v, b.name ) ) then 
		            value_X = nil
			
		    	    RunString( "value_X = DDP.elemente[" ..k .. "]:Get" .. FilterString( b.name ) .. "()" )
			        if( type( value_X ) == "string" ) then
			        str = str .. [[ e:]] .. b.name .. [[( "]] .. tostring(value_X) .. [[" )
						]]

			        else
			        str = str .. [[ e:]] .. b.name .. [[( ]] .. tostring(value_X) .. [[ )
						]]
			        end
		        end
	        end
        end
    end
     ostr = ostr .. "\n" ..  str
end


return header .. "\n" .. ostr .. "\n end" 


end

--[[---------------------------------------------------------
Name: CreateFrameFile( name )
-----------------------------------------------------------]]
function CreateFrameFile( name )
local name = name .. "_lua"
local path = "dd/db/projects/"
local parent = "frame"
local fname = "RunWindow"

if( file.Exists(path .. name .. ".txt", "DATA") ) then file.Delete( path .. name .. ".txt" )end

file.Write(path .. name .. ".txt", "" .. [[local function ]] .. fname .. [[()
local frame = vgui.Create("]] .. DDP.frame:GetTable().Derma.ClassName .. [[")
frame:SetPos( ]] .. DDP.frame.x / ScrW() .. [[ * ScrW(), ]] .. DDP.frame.y / ScrH() .. [[ * ScrH() )
frame:SetSize( ]] .. DDP.frame:GetWide() / ScrW() .. [[ * ScrW(), ]] .. DDP.frame:GetTall() / ScrH() .. [[ * ScrH() ) ]] .. "\nframe:MakePopup()\n")
for k,v in ipairs( DDP.elemente ) do
    if( v != nil ) then
        if( v:IsValid() ) then
	        local str = [[ local e = vgui.Create( "]] .. v.ClassName .. [[", ]] .. parent .. [[ )
						 e:SetPos( ]] .. v.x / DDP.frame:GetWide()  .. " * " .. parent .. [[:GetWide(), ]] .. v.y / DDP.frame:GetTall() .. " * " ..  parent .. [[:GetTall() )
						 e:SetSize( ]] .. v:GetWide() / DDP.frame:GetWide() .. " * " .. parent .. [[:GetWide(), ]] .. v:GetTall() / DDP.frame:GetTall() .. " * " ..  parent .. [[:GetTall() )
				]] 
	        for a,b in ipairs( DDP.vgui[v.ClassName] ) do

	        	if( GetValidMethod( v, b.name ) ) then 
	            	value_X = nil
			
		           	RunString( "value_X = DDP.elemente[" ..k .. "]:Get" .. FilterString( b.name )  .. "()" )
			        if( type( value_X ) == "string" ) then
		            	str = str .. [[ e:]] .. b.name .. [[( "]] .. tostring(value_X) .. [[" )
						]]
		        	else
		        	str = str .. [[ e:]] .. b.name .. [[( ]] .. tostring(value_X) .. [[ )
						]]
			        end
			
		        end

	        end
			file.Write(path .. name .. ".txt", "" .. file.Read(path .. name .. ".txt","DATA") .. "\n" .. str .. "")
			
        end
    end

end

	file.Write(path .. name .. ".txt", "" .. file.Read(path .. name .. ".txt","DATA") .. "\n end\n" .. fname .. "()")
	RunString( file.Read(path .. name .. ".txt","DATA") ) 

	hook.Call( "DDP_Debug", nil, name  )
end

--[[---------------------------------------------------------
   Name: LoadFromFile( name )
-----------------------------------------------------------]]
function LoadFromFile( name, typ )
local Fa = {}
local content = file.Read( name, typ )

 // first check if a locked file
	
	local rows = string.Explode( "\n",content )
	if( #rows >= 2 ) then
	local row = nil
		// search functions
			for k,v in ipairs( rows ) do
				// get words 
				local words = string.Explode( " ", v ) 
					// function ?
					for ws,w in ipairs( words ) do

						if( w == "function" ) then
							row = k // row where the function begins
							local FName = words[ws+1]
							table.insert(Fa, { fname = FName} )
							if( FName == nil ) then 
							// error 
							return end
						elseif( string.find( w, [[vgui.Create]], 1, false ) != nil ) then
							// found Vgui
							local s,e = string.find( v, [[vgui.Create]], 1, false )
							local qmarks = [["]]
							local ts,te = string.find( v, qmarks, e, false )
							local ts1,te2 = string.find( v, qmarks, te+1, false )
						
							local VName = string.sub( v, ts+1, ts1-1 )
							table.insert( Fa, {vg = VName, x = 0, y = 0, w = 0, h = 0, text = "none", parent = "N/A" } )
						end
					
					end
					
			end
	elseif( #rows == 0 ) then
		// file is empty
	elseif( #rows == 1 ) then
		// file is locked
	end

	Msg( "\n" .. "=========================\n" )
	PrintTable(Fa)
	Msg( "\n" .. "=========================\n" )

	hook.Call( "DDP_Decompile", nil, name )
end

--[[---------------------------------------------------------
  CreateWindowFromFile
-----------------------------------------------------------]]
function CreateWindowFromFile( tab )

if( DDP.frame != nil ) then
	DDP.frame:Remove()
	DDP.frame = nil
	table.Empty(DDP.elemente)
	table.Empty(DDP.selected)
end

DDP.frame = vgui.Create( "DFrame" )
DDP.frame:SetPos( tab.frame.x, tab.frame.y )
DDP.frame:SetSize(tab.frame.w, tab.frame.h)
DDP.frame:SetTitle( tab.frame.title )
DDP.frame:SetVisible( true )
DDP.frame:SetDraggable( true )
DDP.frame:SetSizable( true )
DDP.frame:ShowCloseButton( true )
DDP.frame:MakePopup()
function DDP.frame:OnClose()
LocalPlayer():ChatPrint( "[DermaDesigner]: closed")
DDP.frame = nil
table.Empty(DDP.elemente)
table.Empty(DDP.selected)

end

--[[---------------------------------------------------------
   Vertical: 
-----------------------------------------------------------]]

line = vgui.Create("DButton",DDP.frame)
line:SetText("")
line:SetPos(0,0)
line:SetSize(5,0)
line:SetZPos(32766)
line:SetVisible(true)
function line:Paint()
    surface.SetDrawColor(0,0,255,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

line2 = vgui.Create("DButton",DDP.frame)
line2:SetText("")
line2:SetPos(0,0)
line2:SetSize(5,0)
line2:SetZPos(32766)
line2:SetVisible(true)
function line2:Paint()
    surface.SetDrawColor(0,0,255,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

--[[---------------------------------------------------------
   Horizontal: 
-----------------------------------------------------------]]
line3 = vgui.Create("DButton",DDP.frame)
line3:SetText("")
line3:SetPos(0,0)
line3:SetSize(5,0)
line3:SetZPos(32766)
line3:SetVisible(true)
function line3:Paint()
    surface.SetDrawColor(0,0,255,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end

line4 = vgui.Create("DButton",DDP.frame)
line4:SetText("")
line4:SetPos(0,0)
line4:SetSize(5,0)
line4:SetZPos(32766)
line4:SetVisible(true)
function line4:Paint()
    surface.SetDrawColor(0,0,255,255)
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
end
	for i=1, #table.GetKeys( tab.elemente ) do

		for index, panel in ipairs( tab.elemente[table.GetKeys( tab.elemente )[i]] ) do
			vgui_element = vgui.Create(tostring(table.GetKeys( tab.elemente )[i]),DDP.frame)
		
			for k,v in ipairs( panel ) do

				if( k == #panel ) then
					vgui_element:SetSize(v.w,v.h)
					vgui_element:SetPos(v.x,v.y)
				else
					print( v.value )
					VGUI_VALUE = v.value
					RunString( "vgui_element:" .. v.method .. "( VGUI_VALUE )" )
				end
			end
			transform = vgui.Create( "DDTransform", DDP.frame )
			transform:SetPos( vgui_element.x, vgui_element.y )
			transform:SetSize( vgui_element:GetWide(), vgui_element:GetTall() )
			transform:SetTPanel( vgui_element )
			table.insert( DDP.elemente, vgui_element )
		end
	end
	VGUI_VALUE = nil

    DDP.selected[1] = DDP.elemente[1]
end

--[[---------------------------------------------------------
   Name: CreateProjectFile
-----------------------------------------------------------]]
function CreateProjectFile( name )

--fillme!
local path = "db/projects/"
-- if projects folder dont exists
if( !file.IsDir( path, "DATA" ) ) then file.CreateDir( path ) end
-- if file exists do ... bla
local tab = {
name = name,
author = LocalPlayer():GetName(),
date = os.date("*t")["day"] .. "/" .. os.date("*t")["month"] .. "/" .. os.date("*t")["year"] .. "",
frame = { title = DDP.frame.lblTitle:GetText(), x = DDP.frame.x, y = DDP.frame.y, w = DDP.frame:GetWide(), h = DDP.frame:GetTall()},
elemente = {}
}
// parents of the panel ?...

for k,v in ipairs( DDP.elemente ) do
	if( !tab.elemente[v.ClassName] ) then tab.elemente[v.ClassName] = { } tab.elemente[v.ClassName][1] = {} else tab.elemente[v.ClassName][#tab.elemente[v.ClassName]+1] = {} end
	local methods = DDP.vgui[v.ClassName] or {}
	for number, method in ipairs( methods ) do

		if( GetValidMethod( v, method.name ) ) then
			table.insert( tab.elemente[v.ClassName][#tab.elemente[v.ClassName]], { method = method.name, value = GetValueOfMethod( k, method.name )} )

		end

	end
	--
	table.insert( tab.elemente[v.ClassName][#tab.elemente[v.ClassName]], {x = v.x, y = v.y, w = v:GetWide(), h = v:GetTall()} )
end

local json = util.TableToJSON( tab )
file.Write( path .. name .. ".txt", json )
	LocalPlayer():ChatPrint( name .. " was saved!")
	hook.Call( "DDP_SavedFile", nil, name )
end

--[[---------------------------------------------------------
   Name: LoadProjectFile
-----------------------------------------------------------]]
function LoadProjectFile( name )
local path = "db/projects/"
	if( !file.Exists( path .. name .. ".txt", "DATA" ) ) then LocalPlayer():ChatPrint("File: " .. name .. " doesnt exists!") return end
	local tab = util.JSONToTable( file.Read( path .. name .. ".txt", "DATA") )
	CreateWindowFromFile( tab )
	hook.Call( "DDP_LoadFile", nil, name )
end

--[[---------------------------------------------------------
   Name: SaveProjectFile
-----------------------------------------------------------]]
function SaveProjectFile( name, content )

--fillme!
end

--[[---------------------------------------------------------
   Name: AutoSaveProjectFile
-----------------------------------------------------------]]
function AutoSaveProjectFile( name, content )

--fillme!

end


--[[---------------------------------------------------------
   Name: PanelMethodsFromWiki
-----------------------------------------------------------]]
function PanelMethodsFromWiki( name )

--fillme!

end



