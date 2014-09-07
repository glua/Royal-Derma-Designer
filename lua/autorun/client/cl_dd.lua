
--[[---------------------------------------------------------

 currently i am using global values and function to better debug bugs,exploits and error

-----------------------------------------------------------]]
DDP = {}
DDP.frame = nil
DDP.elemente = {}
DDP.selected = {}
DDP.VGUI={}
DDP.test ={}
DDP.toolbox = {"Button","Panel","Image","ImageButton","Label","TextEntry","ColorButton","ColorMixer","ColorPalette","ComboBox","ModelPanel","CheckBoxLabel","NumberWang","NumPad","Progress"}
DDP.MousePos = {0,0}
DDP.Mousemove = false
DDP.Name = "Empty"
DDP.copied = {}
CreateClientConVar("dd_gap",15,false,false)

surface.CreateFont( "Test_font", {
	font = "DermaDefault",
	size = 25,
	weight = 450,
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

--[[---------------------------------------------------------
				    2
			==================
			=				 =
			=				 =
	1   	=				 =		3
			=				 =
			=				 =
			==================
					4
-----------------------------------------------------------]]
local DDP_PANEL_LEFT = 1
local DDP_PANEL_TOP = 2
local DDP_PANEL_RIGHT = 3
local DDP_PANEL_BOTTOM = 4

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function GetPosition( str )

local s,e = string.find( str ,"%d+")

local cleanstring = (string.TrimRight( string.sub( str, s, string.len(str)), "]"  ) .. "\n")

	return {x = string.Explode(",",cleanstring)[1], y = string.Explode(",",cleanstring)[2]}
	--fram:SetPos( GetPosition(tostring(tab.frame:GetTable().Panel)).x, GetPosition(tostring(tab.frame:GetTable().Panel)).y)
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
   Name: GetModsByFilename
-----------------------------------------------------------]]
function GetModsByFilename( filename ) 
local t = {}
local content = string.Explode( "\n", file.Read("vgui/".. filename .. "","LUA") )
local classname = string.Explode(""..[["]].."",content[#content])[2]
if(classname != nil ) then table.insert(t, {vgui = classname , methods = { } } ) end
	for line,row in ipairs( content ) do	
		local met = string.find( tostring(row), "PANEL", 1 )
		if( met != nil ) then
			local wordpos = string.find( tostring(row), "Set", 1 )
			if( wordpos != nil ) then
				local wordend = string.find( row, " ", wordpos )
				if( wordend != nil ) then
					local method = string.sub( row, wordpos, wordend-2  )
					for a,b in ipairs( t ) do
						if( !table.HasValue(b.methods, method) and method:len() > 3 and string.lower(method) != "setup" and method != [[Settings"]] ) then
							table.insert(b.methods, method )
						end
					end
				end
			end
		else
		end
	end
	PrintTable(t)
end
--[[---------------------------------------------------------
   Name: GetMethods
-----------------------------------------------------------]]
function GetMods()

local files, dir = file.Find( "vgui/*.lua", "LUA", "nameasc" )
local t = {}
	for k,v in ipairs( files ) do
		local str =  file.Read("vgui/".. v .. "","LUA") or ""
		local content = string.Explode( "\n", str )
		local classname = string.Explode(""..[["]].."",content[#content])[2]
		if(classname != nil ) then table.insert(t, {vgui = classname , methods = { } } ) end
		for line,row in ipairs( content ) do
			local met = string.find( tostring(row), "PANEL", 1 )
			if( met != nil ) then
				local wordpos = string.find( tostring(row), "Set", 1 )
				if( wordpos != nil ) then
					local wordend = string.find( row, " ", wordpos )
					if( wordend != nil ) then
						local method = string.sub( row, wordpos, wordend-2  )
						for a,b in ipairs( t ) do
							if( !table.HasValue(b.methods, method) and method:len() > 3 and string.lower(method) != "setup" and method != [[Settings"]] ) then
								table.insert(b.methods, method )
							end
						end
					end
				end
			else
			end
		end
	end
	DDP.VGUI = table.Copy(t)
end
GetMods()

//RunString("if(DDP.selected[1]:Get" .. string.Right( b, string.len( b )-3 ).. "() != nil ) then AS[1] = type(DDP.selected[1]:Get" .. string.Right( b, string.len( b )-3 ).. "() ) else Msg(tostring(NIL))end")

--[[---------------------------------------------------------
   Name: CreateFrameFile( name )
-----------------------------------------------------------]]
function CreateFrameFile( name )
local name = name .. "_lua"
local path = "ride/projects/"
local parent = "frame"
local fname = "RunWindow"
if( file.Exists(path .. name .. ".txt", "DATA") ) then file.Delete( path .. name .. ".txt" )end

file.Write(path .. name .. ".txt", "" .. [[local function ]] .. fname .. [[()
local frame = vgui.Create("]] .. DDP.frame:GetTable().Derma.ClassName .. [[")
frame:SetPos(]] .. DDP.frame.x .. [[,]] .. DDP.frame.y .. [[)
frame:SetSize(]] .. DDP.frame:GetWide() .. [[,]] .. DDP.frame:GetTall() .. [[) ]] .. "\n frame:MakePopup()\n")
for k,v in ipairs( DDP.elemente ) do
	local str = [[ local e = vgui.Create("]] .. v.ClassName .. [[",]] .. parent .. [[)
						 e:SetPos(]] .. v.x / DDP.frame:GetWide()  .. "*" .. parent .. [[:GetWide() ,]] .. v.y / DDP.frame:GetTall() .. "*" ..  parent .. [[:GetTall())
						 e:SetSize(]] .. v:GetWide() / DDP.frame:GetWide() .. "*" .. parent .. [[:GetWide(),]] .. v:GetTall() / DDP.frame:GetTall() .. "*" ..  parent .. [[:GetTall())
				]]

	file.Write(path .. name .. ".txt", "" .. file.Read(path .. name .. ".txt","DATA") .. "\n" .. str .. "")
end
	file.Write(path .. name .. ".txt", "" .. file.Read(path .. name .. ".txt","DATA") .. "\n end\n" .. fname .. "()")
	Msg( file.Read(path .. name .. ".txt","DATA") )
	RunString( file.Read(path .. name .. ".txt","DATA") ) 
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
	for k,v in ipairs( tab.elemente ) do
		DDP.elemente[k] = vgui.Create(v.classname,DDP.frame)
		DDP.elemente[k]:SetText( v.text )
		DDP.elemente[k]:SetSize(v.w,v.h)
		DDP.elemente[k]:SetPos(v.x,v.y)
		DDP.elemente[k]:Buildmode(true)
	end
end

--[[---------------------------------------------------------
   Name: CreateProjectFile
-----------------------------------------------------------]]
function CreateProjectFile( name )

--fillme!
local path = "ride/projects/"
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
	table.insert( tab.elemente, { classname = v.ClassName, text = v:GetText(), x = v.x, y = v.y, w = v:GetWide(), h = v:GetTall() } )
end

local json = util.TableToJSON( tab )
	file.Write( path .. name .. ".txt", json )
	LocalPlayer():ChatPrint( name .. " was saved!")
end

--[[---------------------------------------------------------
   Name: LoadProjectFile
-----------------------------------------------------------]]
function LoadProjectFile( name )
local path = "ride/projects/"
	if( !file.Exists( path .. name .. ".txt", "DATA" ) ) then LocalPlayer():ChatPrint("File: " .. name .. " doesnt exists!") return end
	local tab = util.JSONToTable( file.Read( path .. name .. ".txt", "DATA") )
	CreateWindowFromFile( tab )
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
   Name: GetValidMethods
-----------------------------------------------------------]]
function GetValidMethods( gui )
t = {}
t2 = {}
AST = gui
for k,v in ipairs( DDP.VGUI ) do
	if( v.vgui == gui.ClassName ) then
		for a,b in ipairs( v.methods ) do
			local Rstring = [[
				local succ, err = pcall( function() AST:Get]] .. string.Right( b, string.len( b )-3 ) .. [[()]] .. [[ end ) 
				if( succ ) then
				table.insert(t,{ name = "Get]] .. string.Right( b, string.len( b )-3 ).. [[()", t = type(AST:Get]] .. string.Right( b, string.len( b )-3 ).. [[() )} )  else
				end
				]]
			RunString(Rstring)
		end
	else

	end
end

local rt = table.Copy(t)
t,t2,AST = nil
PrintTable(rt)

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
local function Main()

local Mainf = vgui.Create( "GMenu" )
Mainf:SetPos( ScrW()-350, 0 )
Mainf:SetSize( 350, ScrH() )
Mainf:SetTitle( "Derma Designer Alpha 0.1" )
Mainf:SetDragable( false )
Mainf:SetVisible( true )
Mainf:MakePopup()

	  local fadeout = vgui.Create("DImageButton",Mainf)
	  fadeout:SetPos(0,0)
	  fadeout:SetSize(32,32)
	  fadeout:SetImage("DD/gui/close.png")
	  fadeout.DoClick = function()

	  if( fadeout:GetImage() == "DD/gui/close.png" ) then
		fadeout:SetImage("DD/gui/open.png")
		Mainf:SetSize( 32, 32 )
		Mainf:SetPos(ScrW()-32,0)
		Mainf:SetTitle( "" )
		Mainf:SetShowClose(false)
	  else
		  fadeout:SetImage("DD/gui/close.png")
		  Mainf:SetPos( ScrW()-350, 0 )
		  Mainf:SetSize( 350, ScrH() )
		  Mainf:SetTitle( "Derma Designer Alpha 0.1" )
		  Mainf:SetShowClose(true)
			if( !DDP.frame:IsVisible() ) then
				DDP.frame:SetVisible( true )
			end
		end

	  end

	   local t = vgui.Create("GTab",Mainf)
		  t:SetPos(0,32)
		  t:SetSize(Mainf:GetWide(),50)
		  t:GetParent( Mainf )
		  t:AddTab(" Toolbox " )
		  t:AddTab(" Settings " )

		  starten = vgui.Create( "DPanel")
		  starten:SetPos(0,0)
		  starten:SetSize(Mainf:GetWide()+11,Mainf:GetTall() * 0.333)
		  function starten:Paint( w, h )
		  surface.SetDrawColor(42,42,42,255)
		  surface.DrawRect(0,0,w,h)
		  end

		  function starten:PaintOver( w, h )
			draw.SimpleText(   "Start" , "Test_font", w * 0.1, h * 0.03, Color(255,255,255,255), 0, 1 )
		  end

		  local open = vgui.Create("GMenuButton",starten)
		  open:SetText("project open")
		  open:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.1)
		  open:SetSize(200,25)
		  function open:Clicked()
			 LoadTheFile()
		  end

		  local save = vgui.Create("GMenuButton",starten)
		  save:SetText("project save")
		  save:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.17)
		  save:SetSize(200,25)
		  function save:Clicked()
			  SaveTheFile()
		  end

		  local prun = vgui.Create("GMenuButton",starten)
		  prun:SetText("project debug")
		  prun:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.24)
		  prun:SetSize(200,25)
			  function prun:Clicked()
			  CreateFrameFile( DDP.Name )
		  end
		   local Skincreator = vgui.Create("GMenuButton",starten)
		  Skincreator:SetText("skin creator")
		  Skincreator:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.31)
		  Skincreator:SetSize(200,25)
			  function Skincreator:Clicked()
			  NewTemplate()
		  end

		  local Scoreboardcreator = vgui.Create("GMenuButton",starten)
		  Scoreboardcreator:SetText("scoreboard creator")
		  Scoreboardcreator:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.38)
		  Scoreboardcreator:SetSize(200,25)
			  function Scoreboardcreator:Clicked()
				// fade out main

					fadeout:SetImage("DD/gui/open.png")
					Mainf:SetSize( 32, 32 )
					Mainf:SetPos(ScrW()-32,0)
					Mainf:SetTitle( "" )
					Mainf:SetShowClose(false)

					if( DDP.frame != nil ) then

						if( DDP.frame:IsVisible() ) then
							DDP.frame:SetVisible( false )
						end

					end

				// open scoreboard ... 
				scoreboard_menu()
		  end


		  t:AddItem(starten,2)

		  zuletzt = vgui.Create( "DPanel")
		  zuletzt:SetPos(0,Mainf:GetTall() * 0.3334)
		  zuletzt:SetSize(Mainf:GetWide()+11,(Mainf:GetTall() - Mainf:GetTall() * 0.333))
		  function zuletzt:Paint( w, h )
			 surface.SetDrawColor( 42, 42, 42, 255 )
			 surface.DrawRect( 0, 0, w, h )
		  end
		  function zuletzt:PaintOver( w, h )
			draw.SimpleText( "Latest" , "Test_font", w * 0.1, h * 0.03, Color(255,255,255,255), 0, 1 )
		  end
		  t:AddItem(zuletzt,2)
		  local bc = {1,2,3,4,5,6,7,8,9}
		  for k,v in ipairs(bc) do
			 local test = vgui.Create("GMenuButton",zuletzt)
			 test:SetText("test" .. k .. "")
			 test:SetPos( zuletzt:GetWide() * 0.1, zuletzt:GetTall() * (0.03 + (0.035*k)) )
			 test:SetSize(200,25)
		  end

		  panel = vgui.Create( "DPanelList")
		  panel:SetSize(  Mainf:GetWide()+11, Mainf:GetTall()-Mainf:GetTall()*0.5)
		  panel:SetPos( 0, 0 )
		  panel:EnableVerticalScrollbar()

		  panel.VBar.btnUp:SetVisible(false)
		  panel.VBar.btnDown:SetVisible(false)
		  panel.VBar.btnGrip:SetVisible(false)
		  function panel.VBar:Paint(w,h)
	 	  surface.SetDrawColor(0,0,0,0)
	 	  surface.DrawRect(0,0,w,h)
		  return true
		  end
		  t:AddItem(panel,1)
		  for i = 1, #DDP.toolbox do 
			DDListButtom = vgui.Create( "DDListButtom" )
			DDListButtom:SetPos( 25, 50 ) 
			DDListButtom:SetImage("DD/icons/" .. DDP.toolbox[i] .. ".png")
			DDListButtom:Droppable("ele")
			DDListButtom:SetText( DDP.toolbox[i])                             // Set position
			DDListButtom:SetSize( panel:GetWide(), 25 )     
			function DDListButtom:DoClick() 
				local classname = "R" .. tostring(self:GetText())
				local val = #DDP.elemente+1
				DDP.elemente[val] = vgui.Create(classname,DDP.frame)
				DDP.elemente[val]:SetWide( 200 )
				DDP.elemente[val]:SetPos(50,100)
				DDP.elemente[val]:Buildmode(true)
			 end 
			DDListButtom:SizeToContents()                  
			panel:AddItem( DDListButtom) 
		  end
	local old =	DDP.selected[1]		  
	function Mainf:OverWrite()
	if( DDP.frame == nil ) then Mainf:Remove() return end
		if( old != DDP.selected[1]) then
			old = DDP.selected[1]
			if(#DDP.selected < 1 ) then return end 
			if( DProperties:IsValid() ) then
				DProperties:Remove()
				DProperties = vgui.Create( "DProperties" )

				Row2 = DProperties:CreateRow( "Properties", "IsVisible" )
				Row2:Setup( "Boolean" )
				Row2:SetValue( DDP.selected[1]:IsVisible() )
				Row2.DataChanged = function( _, val ) DDP.selected[1]:SetVisible(tobool(val)) print(val)end

				Row3 = DProperties:CreateRow( "Settings", "X" )
				Row3:Setup( "Float", {min = 0, max = ScrW()} )
				Row3:SetValue( DDP.selected[1].x )
				Row3.DataChanged = function( _, val ) DDP.selected[1].x = val end

				Row4 = DProperties:CreateRow( "Settings", "Y" )
				Row4:Setup( "Float", {min = 0, max = ScrH()} )
				Row4:SetValue( DDP.selected[1].y )
				Row4.DataChanged = function( _, val ) DDP.selected[1].y = val end

				Rowa = DProperties:CreateRow( "Settings", "W" )
				Rowa:Setup( "Float", {min = 0, max = ScrW()} )
				Rowa:SetValue( DDP.selected[1]:GetWide() )
				Rowa.DataChanged = function( _, val ) DDP.selected[1]:SetWide(val) end

				Rowb = DProperties:CreateRow( "Settings", "H" )
				Rowb:Setup( "Float", {min = 0, max = ScrH()} )
				Rowb:SetValue( DDP.selected[1]:GetTall() )
				Rowb.DataChanged = function( _, val ) DDP.selected[1]:SetTall(val) end
				for k,v in ipairs(DDP.VGUI) do
					if( v.vgui == DDP.selected[1].ClassName or v.vgui == string.Replace( DDP.selected[1].ClassName, "R", "D" ) ) then
						AS = {}
						for a,b in ipairs( v.methods ) do 
						local Rstring = [[
								local succ, err = pcall( function() DDP.selected[1]:Get]] .. string.Right( b, string.len( b )-3 ) .. [[()]] .. [[ end ) 
								if( succ ) then
								AS[1] = type(DDP.selected[1]:Get]] .. string.Right( b, string.len( b )-3 ).. [[() )  else
								AS[1] = nil
								end
								]]
						RunString(Rstring)
							if( AS[1] != nil ) then
								ST = {}
								if( AS[1] == "string" ) then
									RunString( [[ST[1] = DDP.selected[1]:Get]] .. string.Right( b, string.len( b )-3 ) .. [[()]] ) 
									 c = DProperties:CreateRow( "Settings", b )
									 c:Setup( "Generic" )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val ) RunString([[DDP.selected[1]:]] .. b .. [[("]] .. val .. [[")]])  end
								elseif( AS[1] == "number" ) then
									RunString( [[ST[1] = DDP.selected[1]:Get]] .. string.Right( b, string.len( b )-3 ) .. [[()]] ) 
									 c = DProperties:CreateRow( "Settings", b )
									 c:Setup( "Float", {min = 0, max = 255 } )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val ) RunString([[DDP.selected[1]:]] .. b .. [[(]] .. val .. [[)]] ) end
								elseif( AS[1] == "boolean") then
									RunString( [[ST[1] = DDP.selected[1]:Get]] .. string.Right( b, string.len( b )-3 ) .. [[()]] ) 
									 c = DProperties:CreateRow( "Settings", b )
									 c:Setup( "Boolean" )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val )  RunString([[DDP.selected[1]:]] .. b .. [[(]] .. val .. [[)]]) end
								elseif( AS[1] == "table" ) then
									RunString( [[ST[1] = DDP.selected[1]:Get]] .. string.Right( b, string.len( b )-3 ) .. [[()]] ) 
									 c = DProperties:CreateRow( "Settings", b )
									 c:Setup( "VectorColor" )
									 c:SetValue( Vector( ST[1].r/255, ST[1].g/255, ST[1].b/255 ) )
									 c.DataChanged = function( _, val )  col = string.Explode(" ",val) Col = Color(col[1],col[2],col[3])  RunString([[DDP.selected[1]:]] .. b .. [[( Color(Col.r * 255, Col.g* 255, Col.b * 255) )]])   end
								elseif( AS[1] == "no value" ) then
									 c = DProperties:CreateRow( "Settings", b )
									 c:Setup( "Generic" )
									 c:SetValue("novalue" )
									 c.DataChanged = function( _, val )  end
								elseif( AS[1] == "table") then
									 c = DProperties:CreateRow( "Settings", b )
									 c:Setup( "Generic" )
									 c:SetValue("table" )
									 c.DataChanged = function( _, val )  end
								end
							end
						end
					end
				 end
				DProperties:SetSize( Mainf:GetWide(), Mainf:GetTall()*0.5 )
				DProperties:SetPos(0,Mainf:GetTall()*0.5)
				t:AddItem(DProperties,1)
			  else
			end
		end
	end

		 DProperties = vgui.Create( "DProperties" )
		 Row2 = DProperties:CreateRow( "Properties", "IsVisible" )
		 Row2:Setup( "Boolean" )
		 Row2:SetValue( true )

		 Row3 = DProperties:CreateRow( "Settings", "X" )
		 Row3:Setup( "Float", {min = 0, max = ScrW()} )
		 Row3:SetValue( 2.5 )

		 Row4 = DProperties:CreateRow( "Settings", "Y" )
		 Row4:Setup( "Float", {min = 0, max = ScrH()} )
		 Row4:SetValue( 2.5 )

		 Rowa = DProperties:CreateRow( "Settings", "W" )
		 Rowa:Setup( "Float", {min = 0, max = ScrW()} )
		 Rowa:SetValue( 2.5 )

		 Rowb = DProperties:CreateRow( "Settings", "H" )
		 Rowb:Setup( "Float", {min = 0, max = ScrH()} )
		 Rowb:SetValue( 2.5 )

		 Row5 = DProperties:CreateRow( "Settings", "Text" )
		 Row5:Setup( "Generic" )
		 Row5:SetValue( DDP.frame.lblTitle:GetText())
		 Row5.DataChanged = function( _, val ) DDP.frame.lblTitle:SetText(val) end
		 
		DProperties:SetSize( Mainf:GetWide(), Mainf:GetTall()*0.5 )
		DProperties:SetPos(0,Mainf:GetTall()*0.5)
		t:AddItem(DProperties,1)
end

--[[---------------------------------------------------------
   Name: OpenDDD
-----------------------------------------------------------]]
function OpenDDD()


DDP.frame = vgui.Create( "DFrame" )
DDP.frame:SetPos( 100, 100 )
DDP.frame:SetSize(ScrW()/2,ScrH()/2)
DDP.frame:SetTitle( "My new Derma frame" )
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
function line3:Paint( w, h )
surface.SetDrawColor(0,0,255,255)
surface.DrawRect(0,0,w,h)
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

Main()
	 
end
concommand.Add("open_dd",OpenDDD)
 --net.Receive( "dermades", OpenDDD )

  --[[---------------------------------------------------------
NAME:GetRange
-----------------------------------------------------------]]
function GetRange( selected, elemente, gap )
local a = false
local b = false
	local ausgabe = {}
		for k,v in ipairs( elemente ) do
			if( v != selected ) then
				if( v.x + v:GetWide() >= selected.x - gap and v.x + v:GetWide() <= selected.x and v.y >= selected.y and v.y + v:GetTall() <= selected.y + selected:GetTall() ) then
					// left
					table.insert( ausgabe, { panel = v, posi = DDP_PANEL_LEFT } )
				elseif( v.y + v:GetTall() >= selected.y - gap and v.y +v:GetTall() <= selected.y and v.x + v:GetWide() >= selected.x and v.x <= selected.x + selected:GetWide() ) then
					// top
					table.insert( ausgabe, { panel = v, posi = DDP_PANEL_TOP } )
				elseif(a) then
					// right

				elseif(b) then
					// bottom

				end
			end
		end
	return ausgabe
end

 --[[---------------------------------------------------------
NAME: Open the rightclk menu
-----------------------------------------------------------]]
function OpenMenu()

if( menu_pressed != nil ) then 
if( !menu_pressed:IsVisible() ) then menu_pressed = nil end return end

menu_pressed = DermaMenu() 
menu_pressed:AddOption( "copie", function() if( #DDP.copied > 0 ) then table.Empty(DDP.copied) end table.insert( DDP.copied, { classname =  DDP.selected[1].ClassName, text = DDP.selected[1]:GetText(), w = DDP.selected[1]:GetWide(), h = DDP.selected[1]:GetTall() } )  menu_preesed = nil  end )
if( #DDP.copied > 0 ) then
menu_pressed:AddOption( "paste", function() 
	local val = #DDP.elemente + 1
	DDP.elemente[val] = vgui.Create(DDP.copied[1].classname,DDP.frame)
	DDP.elemente[val]:SetText( DDP.copied[1].text )
	DDP.elemente[val]:SetWide( DDP.copied[1].w )
	DDP.elemente[val]:SetTall( DDP.copied[1].h )
	local x,y = DDP.frame:GetWide() * 0.5 - DDP.elemente[val]:GetWide() * 0.5, DDP.frame:GetTall() * 0.5 - DDP.elemente[val]:GetTall() * 0.5
	DDP.elemente[val]:SetPos(x,y)
	DDP.elemente[val]:Buildmode(true)
menu_pressed = nil  end ) 
end
menu_pressed:AddOption( "cut", function() if( #DDP.copied > 0 ) then table.Empty(DDP.copied) end table.insert( DDP.copied, { classname =  DDP.selected[1].ClassName, text = DDP.selected[1]:GetText(), w = DDP.selected[1]:GetWide(), h = DDP.selected[1]:GetTall() } ) DDP.selected[1]:Remove() table.remove(DDP.elemente,table.KeyFromValue( DDP.elemente, DDP.selected[1] ) ) table.Empty(DDP.selected) menu_pressed = nil  end ) 
menu_pressed:AddOption( "delete", function() DDP.selected[1]:Remove() table.remove(DDP.elemente,table.KeyFromValue( DDP.elemente, DDP.selected[1] ) ) table.Empty(DDP.selected) menu_pressed = nil  end ) 
menu_pressed:AddOption( "Code display", function() LocalPlayer():ChatPrint("wip") menu_pressed = nil  end ) 
menu_pressed:Open()


end

 --[[---------------------------------------------------------
		NAME:CheckSelected
-----------------------------------------------------------]]
function CheckSelected()
if( DDP.frame == nil) then return end
	if( DDP.frame:IsActive()) then
		if( DDP.MousePos[1] != gui.MouseX() or DDP.MousePos[2] != gui.MouseY() ) then
			DDP.Mousemove = true
			DDP.MousePos[1] = gui.MouseX()
			DDP.MousePos[2] = gui.MouseY()
		else
			DDP.Mousemove = false
		end
		for k,v in ipairs( DDP.elemente ) do
			if( v:IsSelected() ) then
				if( table.HasValue( DDP.selected, v ) ) then
				else
					if( #DDP.selected > 0 ) then
						DDP.selected[1]:Select(false)
						table.Empty(  DDP.selected )
					end 
					table.insert(  DDP.selected, v )
				end
			end
		end
		if( DDP.selected[1] == nil ) then return end
		--[[---------------------------------------------------------
				Lines WIP!!!!!
		-----------------------------------------------------------]]
		local x1,y1 = DDP.selected[1]:GetPos()
		-- change names of local values bad :(
		local hit = 0
		local hit2 = 0
		local hit3 = 0
		local hit4 = 0
		for a,b in ipairs( DDP.elemente) do
			local x2,y2 = b:GetPos()
			--vertikal
			if( x1 == x2 and b != DDP.selected[1] ) then
				hit = hit + 1
				x2,y2 = DDP.elemente[a]:GetPos()
				if( y1 > y2 ) then
					line:SetPos(x1-line:GetWide(),y2)
					line:SetSize(2,y1-y2+DDP.selected[1]:GetTall())
					DDP.selected[1]:SetVerticalTolerance(true)
					line:SetVisible(true)
				else
					line:SetPos(x1-line:GetWide(),y1)
					line:SetSize(2,y2-y1+b:GetTall())
					DDP.selected[1]:SetVerticalTolerance(true)
					line:SetVisible(true)
				end
			end
			--horizontal
			if( y1 == y2 and b != DDP.selected[1] ) then 
				hit3 = hit3 + 1
				if( x1 > x2 ) then
				
					line3:SetPos(x2,y2) 
					line3:SetSize((x1-x2)+DDP.selected[1]:GetWide(),2)
					DDP.selected[1]:SetHorizontalTolerance(true)
					line3:SetVisible(true)
				else
					line3:SetPos(x1,y2) 
					line3:SetSize(x2-x1+b:GetWide(),2)
					DDP.selected[1]:SetHorizontalTolerance(true)
					line3:SetVisible(true)
					
				end

			end
			--vertikal
			if( x1+DDP.selected[1]:GetWide() == x2 + b:GetWide() and b != DDP.selected[1] ) then
				hit2 = hit2 + 1
				if( y1 > y2 ) then
					line2:SetPos(x1+DDP.selected[1]:GetWide(),y2) 
					line2:SetSize(2,y1-y2+DDP.selected[1]:GetTall())
					DDP.selected[1]:SetVerticalTolerance(true)
					line2:SetVisible(true)
				elseif( y2 > y1 ) then
					line2:SetPos(x1+DDP.selected[1]:GetWide(),y1) 
					line2:SetSize(2,y2-y1+b:GetTall())
					DDP.selected[1]:SetVerticalTolerance(true)
					line2:SetVisible(true)
				end
			end
			--horizontal
			if( y1 + DDP.selected[1]:GetTall() == y2 + b:GetTall() and b != DDP.selected[1] ) then 
				hit4 = hit4 + 1
				if( x1 > x2 ) then
					line4:SetPos(x2,y2+b:GetTall()) 
					line4:SetSize(x1-x2+DDP.selected[1]:GetWide(),2)
					DDP.selected[1]:SetHorizontalTolerance(true)
					line4:SetVisible(true)
				else
					line4:SetPos(x1,y2+b:GetTall()) 
					line4:SetSize(x2-x1+b:GetWide(),2)
					DDP.selected[1]:SetHorizontalTolerance(true)

					line4:SetVisible(true)
				end
			end
			if( hit == 0 ) then
				line:SetVisible(false)
				DDP.selected[1]:SetVerticalTolerance(false)
			end
			if( hit2 == 0 ) then
				line2:SetVisible(false)
				DDP.selected[1]:SetVerticalTolerance(false)
			end
			if( hit3 == 0  ) then
				line3:SetVisible(false)
				DDP.selected[1]:SetHorizontalTolerance(false)
			end
			if( hit4 == 0 ) then
				line4:SetVisible(false)
				DDP.selected[1]:SetHorizontalTolerance(false)
			end
		--[[---------------------------------------------------------
		Parents		DDP.MousePos[1] = gui.MouseX()
		DDP.MousePos[2]
		-----------------------------------------------------------]]
		-- get selected
			local selected = DDP.selected[1]
			for a,b in ipairs( DDP.elemente) do
				if( selected != b ) then 
					if( selected.x >= b.x and selected.x + selected:GetWide() <= b.x + b:GetWide() and selected.y >= b.y and selected.y + selected:GetTall() <= b.y + b:GetTall() ) then
					-- is parent allowed
						if( b.ClassName == "RPanel" ) then
						--LocalPlayer():ChatPrint("in Panel!")
						DDP.selected[1].y = DDP.selected[1].y + 0.01
							selected:SetParent(b)
							--selected:SetPos(0,0)
						-- calc new pos
							local parentposx, parentposy = b:GetPos()
							local mx =  (DDP.frame.x  - gui.MouseX()) + selected:GetWide() 
							local my = (DDP.frame.y  - gui.MouseY()) + selected:GetTall() 
							Msg( mx .. " " .. my .. "\n")
							--selected.x = 0  // mx - selected:GetParent().x
						--	selected.y = 10 // my - selected:GetParent().y
					--	DDP.selected[1]:SetPos(0,0)
					--	LocalPlayer():ChatPrint("X: " .. selected.x .. " Y: " ..  selected.y .. "")
						--	LocalPlayer():ChatPrint("X: " .. mx .. " Y: " .. my .. "")
						end
					end
				end
			end
		end
		local selected = DDP.selected[1]
		local elemente = DDP.elemente
		for k,v in ipairs( GetRange( selected, elemente, 15 ) ) do
	--		LocalPlayer():ChatPrint( v.panel:GetText() .. " ist " .. v.posi .. "")
		end
		if(input.IsMouseDown(MOUSE_RIGHT)) then	OpenMenu() end
	end
end
	
hook.Add("Think","check",CheckSelected)

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function DebugHud()

if( DDP.frame == nil ) then return end

if( DDP.selected[1] == nil ) then return end
local x1,y1 = DDP.selected[1]:GetPos()
draw.SimpleText( "Selected: " , "DermaDefault", 50, 25, Color(255,0,0,255), 1, 1 )
draw.SimpleText( "X: " .. x1 .. " Y: " .. y1 .. " " , "DermaDefault", 50, 50, Color(255,0,0,255), 1, 1 )

for k,v in ipairs( DDP.elemente ) do

	if(v != DDP.selected[1] ) then
	local x,y = v:GetPos()
	draw.SimpleText( "X: " .. x .. " Y: " .. y .. " " , "DermaDefault", 50, 50+k*25, Color(255,0,0,255), 1, 1 )
	end
	end
end

hook.Add("HUDPaint","Paint",DebugHud)


