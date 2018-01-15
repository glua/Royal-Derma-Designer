
--[[---------------------------------------------------------

 currently i am using global values and function to better debug bugs,exploits and error

-----------------------------------------------------------]]
--IsEditing
--LocalPlayer():ChatPrint

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
--SetZPos
print( "main loaded" )
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
local function Main()
local time = CurTime()
local Mainf = vgui.Create( "GMenu" )
Mainf:SetPos( ScrW() - .1817 * ScrW(), 0 )
Mainf:SetSize(  .1817 * ScrW(), ScrH() )
Mainf:SetTitle( "Derma Designer " .. DDP.version )
Mainf:SetDraggable( false )
Mainf:SetVisible( true )
Mainf:MakePopup()

	  local fadeout = vgui.Create("DImageButton",Mainf)
	  fadeout:SetPos(0,0)
	  fadeout:SetSize( Mainf:GetWide() * .0914, 30 )
	  fadeout:SetImage("DD/gui/close.png")
	  fadeout.DoClick = function()

	  if( fadeout:GetImage() == "DD/gui/close.png" ) then
		fadeout:SetImage("DD/gui/open.png")
		Mainf:SetSize( fadeout:GetWide(), fadeout:GetTall() )
		Mainf:SetPos(ScrW() - fadeout:GetWide(),0)
		Mainf:SetTitle( "" )
		Mainf:SetShowClose(false)
        if( DDP.frame:IsValid() ) then
          DDP.frame:SetVisible( false )
        end
	  else
      
		  fadeout:SetImage("DD/gui/close.png")
		  Mainf:SetPos( ScrW() - .1817 * ScrW(), 0 )
		  Mainf:SetSize( .1817 * ScrW(), ScrH() )
		  Mainf:SetTitle( "Derma Designer " .. DDP.version )
		  Mainf:SetShowClose(true)
			if( DDP.frame:IsValid() ) then
				DDP.frame:SetVisible( true )
			end
		end

	  end

	   local t = vgui.Create("GTab",Mainf)
		  t:SetPos(0,30)
		  t:SetSize(Mainf:GetWide(), Mainf:GetTall() * .0416 )
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
		  open:SetSize(Mainf:GetWide(), Mainf:GetTall() * .0208 )
		  function open:Clicked()
			 LoadTheFile()
		  end

		  local save = vgui.Create("GMenuButton",starten)
		  save:SetText("project save")
		  save:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.17)
		  save:SetSize(Mainf:GetWide(), Mainf:GetTall() * .0208)
		  function save:Clicked()
			  SaveTheFile()
		  end

		  local prun = vgui.Create("GMenuButton",starten)
		  prun:SetText("project debug")
		  prun:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.24)
		  prun:SetSize(Mainf:GetWide(), Mainf:GetTall() * .0208)
			  function prun:Clicked()
			  CreateFrameFile( DDP.Name )
		  end
		   local Skincreator = vgui.Create("GMenuButton",starten)
		  Skincreator:SetText("skin creator")
          Skincreator:SetDisabled( false )
		  Skincreator:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.31)
		  Skincreator:SetSize(Mainf:GetWide(), Mainf:GetTall()* .0208)
			  function Skincreator:Clicked()
			--  NewTemplate()
			PaintFrame( "unknown" )
		  end

		   local Settings = vgui.Create("GMenuButton",starten)
		  Settings:SetText("Controls")
		  Settings:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.38)
		  Settings:SetSize(Mainf:GetWide(), Mainf:GetTall() *.0208)
			  function Settings:Clicked()
			  Options()
		  end

		  local Scoreboardcreator = vgui.Create("GMenuButton",starten)
		  Scoreboardcreator:SetText("scoreboard creator")
          Scoreboardcreator:SetDisabled( true )
		  Scoreboardcreator:SetPos( starten:GetWide() * 0.1, starten:GetTall() * 0.45)
		  Scoreboardcreator:SetSize(Mainf:GetWide(), Mainf:GetTall()* .0208)
			  function Scoreboardcreator:Clicked()
				// fade out main

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

		  --[[ takes to long ....
		 local temp = {}
		 for k,v in ipairs( file.Find( "ride/projects/*.txt","DATA" ) ) do
		    if( string.find( v, "lua", 0, true ) == nil ) then
			 table.insert( temp,{ time = file.Time( "ride/projects/" .. v  , "DATA" )  , name = v } ) 
			end
		 end
		 
		 table.SortByMember( temp, "time" )

		  for k,v in ipairs( temp ) do

			if( k < 6 ) then
			 local test = vgui.Create("GMenuButton",zuletzt)
			 test:SetText( string.TrimRight(  v.name, ".txt" ) )
			 test:SetPos( zuletzt:GetWide() * 0.1, zuletzt:GetTall() * (0.03 + (0.035*k)) )
			 test:SetSize(200,25)
			end
		end 

		--  print( os.date( "%d.%m.%Y", file.Time( "ride\projects\*.txt", "DATA" ) ) )
		--]]




		  panel = vgui.Create( "DScrollPanel") -- DPanelList
		  panel:SetSize(  Mainf:GetWide()+11, Mainf:GetTall()*0.2 - (math.abs(Mainf:GetTall()*0.2 - 250) ))
		  panel:SetPos( 0, 25 )
		  panel:GetVBar():SetSize(0,0)



		  t:AddItem(panel,1)
		  table.SortByMember( DDP.toolbox, "count" )
		  for k,v in ipairs( DDP.toolbox ) do
			DDListButtom = panel:Add( "DDListButtom" )
			DDListButtom:Dock(TOP)
			DDListButtom:DockMargin(0,0,0,0)
			//DDListButtom:SetPos( 25, 50 ) 
			DDListButtom:SetImage("DD/icons/" .. v.classname .. ".png" )  --Game freeze huge fps drop!

			--"DD/icons/default.png"
			DDListButtom:Droppable("ele")
			DDListButtom:SetText( v.classname)                             // Set position
			DDListButtom:SetSize( panel:GetWide(), 25 )     
			function DDListButtom:DoClick() 
			local classname = self:GetText()
			DDP.icon = classname
			if( timer.Exists( "ddp_place" ) ) then timer.Destroy( "ddp_place" ) end
			
				--[[---------------------------------------------------------
				local classname = tostring(self:GetText())

				-----------------------------------------------------------]]
				timer.Create( "ddp_place", 0.00001, 0, function()
				if( !DDP.frame ) then  timer.Destroy( "ddp_place" ) return end
					 if( DDP.frame:IsHovered() ) then 
					
						if( input.IsMouseDown( MOUSE_LEFT ) ) then 
						local x,y = DDP.frame:LocalCursorPos()
							LocalPlayer():ChatPrint("placed " .. classname ) 
							UpdatePanelRank( classname )

							local val = #DDP.elemente+1
							DDP.elemente[val] = vgui.Create(classname,DDP.frame)
							DDP.elemente[val]:SetWide( 200 )
							DDP.elemente[val]:SetPos(x,y)

							local test = vgui.Create( "DDTransform", DDP.frame )
							test:SetPos( DDP.elemente[val].x, DDP.elemente[val].y )
							test:SetSize( DDP.elemente[val]:GetWide(), DDP.elemente[val]:GetTall() )
							test:SetTPanel( DDP.elemente[val] )
						
							timer.Destroy( "ddp_place" )
						end 
					end
				end )
				--DDP.elemente[val]:Buildmode(true)
			 end 
			DDListButtom:SizeToContents()                  
		  end

		  local searchBar = vgui.Create( "DTextEntry" ) -- create the form as a child of frame
		  searchBar:SetPos( 0, 0 )
		  searchBar:SetSize(  Mainf:GetWide()+11, 25)
	  
		  function searchBar:OnChange( )
			  for k,v in ipairs( DDP.toolbox ) do
				  if( string.match( string.lower(v.classname), string.lower(self:GetText()))) then
					panel:ScrollToChild(panel:GetCanvas():GetChildren()[k])
				  end
				end
		  end
		  t:AddItem(searchBar,1)

		
	local old =	DDP.selected[1]		  
	function Mainf:OverWrite()
	if( DDP.frame == nil ) then Mainf:Remove() return end
		if( old != DDP.selected[1]) then
			old = DDP.selected[1]
			if(#DDP.selected < 1 ) then return end 
			if( DProperties:IsValid() ) then
				DProperties:Remove()
				DProperties = vgui.Create( "DProperties" )

				visible = DProperties:CreateRow( "Properties", "IsVisible" )
				visible:Setup( "Boolean" )
				visible:SetValue( DDP.selected[1]:IsVisible() )
				visible.DataChanged = function( _, val ) DDP.selected[1]:SetVisible(tobool(val)) print(val)end


				if( DDP.vgui[DDP.selected[1].ClassName] ) then
					
						AS = {}
						
						for a,b in ipairs( DDP.vgui[DDP.selected[1].ClassName] ) do 
							ST={}

								if( b.typ == "string" ) then
									RunString( [[local succ, err = pcall( function() DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[()]] .. [[ end ) if( succ ) then  ST[1] = DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[() else ST[1] = "text" end]] ) 
									 c = DProperties:CreateRow( "Settings", b.name )
									 c:Setup( "Generic" )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val ) RunString([[DDP.selected[1]:]] .. b.name .. [[("]] .. val .. [[")]])  end
								elseif( b.typ == "number" ) then
									RunString( [[local succ, err = pcall( function() DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[()]] .. [[ end ) if( succ ) then  ST[1] = DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[() else ST[1] = 1.0 end]] ) 
									 c = DProperties:CreateRow( "Settings", b.name )
									 c:Setup( "Float", {min = 0, max = 255 } )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val ) RunString([[DDP.selected[1]:]] .. b.name .. [[(]] .. val .. [[)]] ) end
								elseif( b.typ == "boolean") then
									RunString( [[local succ, err = pcall( function() DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[()]] .. [[ end ) if( succ ) then  ST[1] = DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[() else ST[1] = false end]] ) 
									 c = DProperties:CreateRow( "Settings", b.name )
									 c:Setup( "Boolean" )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val )  RunString([[DDP.selected[1]:]] .. b.name .. [[(]] .. val .. [[)]]) end
								elseif( b.typ == "table" or b.typ == "color" ) then
									RunString( [[local succ, err = pcall( function() DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[()]] .. [[ end ) if( succ ) then  ST[1] = DDP.selected[1]:Get]] .. string.sub( b.name, 4, #b.name ) .. [[() else ST[1] = Vector(0,0,0) end]] ) 
									 c = DProperties:CreateRow( "Settings", b.name )
									 c:Setup( "VectorColor" )
									 if( isstring( ST[1] ) )then
									 c:SetValue( Vector( 1,1,1))
									 elseif( ST[1] == nil and b.typ == "color" ) then 
									 c:SetValue( Vector( 1,1,1 ) )
									 else
									 c:SetValue( Vector( ST[1].r/255, ST[1].g/255, ST[1].b/255 ) )
									 end
									 c.DataChanged = function( _, val )  col = string.Explode(" ",val) Col = Color(col[1],col[2],col[3])  RunString([[DDP.selected[1]:]] .. b.name .. [[( Color(Col.r * 255, Col.g* 255, Col.b * 255) )]])   end
								elseif( b.typ == "no value" ) then
								
									 c = DProperties:CreateRow( "Settings", b.name )
									 c:Setup( "Generic" )
									 c:SetValue("novalue" )
									 c.DataChanged = function( _, val )  end
								elseif( b.typ == "nil") then
									 c = DProperties:CreateRow( "Settings", b.name )
									 c:Setup( "Generic" )
									 c:SetValue( ST[1] )
									 c.DataChanged = function( _, val ) RunString([[DDP.selected[1]:]] .. b.name .. [[("]] .. val .. [[")]])  end
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

GetAllPanels()
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
table.Empty(DDP.toolbox)


end

--[[---------------------------------------------------------
   Vertical: 
   line == links
   line2 == rechts
-----------------------------------------------------------]]

line = vgui.Create("DButton",DDP.frame)
line:SetText("")
line:SetPos(0,0)
line:SetSize(5,0)
line:SetZPos(32766)
line:SetVisible(true)
function line:Paint()

surface.SetDrawColor(255,0,0,255)
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
   line3 = oben
   line4 = unten
-----------------------------------------------------------]]
line3 = vgui.Create("DButton",DDP.frame)
line3:SetText("")
line3:SetPos(0,0)
line3:SetSize(5,0)
line3:SetZPos(32766)
line3:SetVisible(true)
function line3:Paint( w, h )
surface.SetDrawColor(0,255,255,255)
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

 local _b = false

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
	local x,y = DDP.frame:LocalCursorPos()
	DDP.elemente[val]:SetPos(x,y)

	local transform = vgui.Create( "DDTransform", DDP.frame )
	transform:SetPos( x,y )
	transform:SetSize(  DDP.copied[1].w, DDP.copied[1].h )
	transform:SetTPanel( DDP.elemente[val] )

menu_pressed = nil  end ) 
end
menu_pressed:AddOption( "cut", function() if( #DDP.copied > 0 ) then table.Empty(DDP.copied) end for k,v in ipairs( table.GetKeys( DProperties.Categories ) ) do DProperties.Categories[v]:Clear() end table.insert( DDP.copied, { classname =  DDP.selected[1].ClassName, text = DDP.selected[1]:GetText(), w = DDP.selected[1]:GetWide(), h = DDP.selected[1]:GetTall() } ) DDP.selected[1]:Remove() table.remove(DDP.elemente,table.KeyFromValue( DDP.elemente, DDP.selected[1] ) ) table.Empty(DDP.selected) menu_pressed = nil  end ) 
//[ERROR] lua/vgui/dproperties.lua:125: Tried to use invalid object (type Panel) (Object was NULL or not of the right type)
menu_pressed:AddOption( "delete", function() for k,v in ipairs( table.GetKeys( DProperties.Categories ) ) do DProperties.Categories[v]:Clear() end DDP.selected[1]:Remove() table.remove(DDP.elemente,table.KeyFromValue( DDP.elemente, DDP.selected[1] ) ) table.Empty(DDP.selected) menu_pressed = nil  end ) 
menu_pressed:AddOption( "Code display", function() CodeView(  GetCurrentCode( ), DDP.Name ) menu_pressed = nil  end ) 
menu_pressed:Open()


end

		local px,py = nil, nil
		local parent = nil

 --[[---------------------------------------------------------
		NAME:CheckSelected
-----------------------------------------------------------]]
local function CheckSelected()
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
        if( !DDP.selected[1]:IsValid() ) then return end

	DDP.selected[1]:SetZPos( #DDP.elemente + 1 )

		for k,v in ipairs( DDP.elemente ) do

			if( v != DDP.selected[1] ) then
                if( !v:IsValid() ) then
                else
				    v:SetZPos( 0 )
                end

			end

		end
		local TYPE = { "DPanel", "DPanelList" }
		
		if( DDP.selected[1] and input.IsMouseDown( MOUSE_LEFT ) ) then
			DDP.Mousepress = true
		else
			DDP.Mousepress = false
		end

		local fx,fy = DDP.frame:LocalCursorPos()


		for k,v in ipairs( DDP.elemente ) do

			if( DDP.selected[1] ) then
				if( v != DDP.selected[1] ) then
                    if( !v:IsValid() ) then 
                    else
					    if( DDP.Mousepress ) then
					    	local x,y = v:LocalCursorPos()
						    if( x > 0 and x < v:GetWide() and y > 0 and y < v:GetTall() ) then
						    	if( table.HasValue( TYPE, v.ClassName ) ) then
								    px = DDP.selected[1].x - v.x
								    py = DDP.selected[1].y - v.y
								
								    parent = v
							    

						    	end
						    else
							    	px = DDP.selected[1].x
								    py =  DDP.selected[1].y
								    parent = DDP.frame
						    end
					    end
                    end
				end
			end
		end

		if( DDP.selected[1] and input.IsMouseDown( MOUSE_LEFT ) ) then
			DDP.Mousepress = true
		else
			DDP.Mousepress = false
		end
		
		if( DDP.selected[1] and !input.IsMouseDown( MOUSE_LEFT )  ) then

			DDP.selected[1].x = px
			DDP.selected[1].y = py

				DDP.selected[1]:SetParent( parent or DDP.selected[1]:GetParent() ) 
		
		else

		end

		if( DDP.Mousepress and DDP.selected[1]:GetParent() != DDP.frame ) then

			DDP.selected[1]:SetParent( DDP.frame )

		end
		-- parent

		--[[---------------------------------------------------------
				Lines WIP!!!!!
		-----------------------------------------------------------]]
		local x1,y1 = DDP.selected[1]:GetPos()
		-- change names of local values bad :(
		local cx,cy = DDP.frame:LocalCursorPos()
		local hit = 0
		local hit2 = 0
		local hit3 = 0
		local hit4 = 0
		for a,b in ipairs( DDP.elemente) do
            if( !b:IsValid() ) then
            else
			    local x2,y2 = b:GetPos()
			--vertikal
			    if( x1 == x2 and b != DDP.selected[1] ) then
				    hit = hit + 1
				    x2,y2 = DDP.elemente[a]:GetPos()
				    if( y1 > y2 ) then
					    line:SetPos(x1-line:GetWide(),y2)
					    line:SetSize(2,y1-y2+DDP.selected[1]:GetTall())
				--	DDP.selected[1]:SetVerticalTolerance(true)
					    DDP.selected[1].horizontal = true
					    line:SetVisible(true)
				    else
					    line:SetPos(x1-line:GetWide(),y1)
					    line:SetSize(2,y2-y1+b:GetTall())
				--	DDP.selected[1]:SetVerticalTolerance(true)
					    DDP.selected[1].horizontal = true
					    line:SetVisible(true)
				    end
			    end
			--horizontal
			    if( y1 == y2 and b != DDP.selected[1] ) then 
				    hit3 = hit3 + 1
				    if( x1 > x2 ) then
				
					    line3:SetPos(x2,y2) 
					    line3:SetSize((x1-x2)+DDP.selected[1]:GetWide(),2)
			--	DDP.selected[1]:SetHorizontalTolerance(true)
					    DDP.selected[1].vertical = true
					    line3:SetVisible(true)
				    else
					    line3:SetPos(x1,y2) 
					    line3:SetSize(x2-x1+b:GetWide(),2)
					    DDP.selected[1].vertical = true
			--		DDP.selected[1]:SetHorizontalTolerance(true)
					    line3:SetVisible(true)
					
				    end

			    end
			--vertikal
			    if( x1+DDP.selected[1]:GetWide() == x2 + b:GetWide() and b != DDP.selected[1] ) then
				    hit2 = hit2 + 1
				    if( y1 > y2 ) then
					    line2:SetPos(x1+DDP.selected[1]:GetWide(),y2) 
					    line2:SetSize(2,y1-y2+DDP.selected[1]:GetTall())
			--		    DDP.selected[1]:SetVerticalTolerance(true)
					    DDP.selected[1].horizontal = true
					    line2:SetVisible(true)
				    elseif( y2 > y1 ) then
					    line2:SetPos(x1+DDP.selected[1]:GetWide(),y1) 
					    line2:SetSize(2,y2-y1+b:GetTall())
			--		DDP.selected[1]:SetVerticalTolerance(true)
					    DDP.selected[1].horizontal = true
					    line2:SetVisible(true)
				    end
			    end
			--horizontal
			    if( y1 + DDP.selected[1]:GetTall() == y2 + b:GetTall() and b != DDP.selected[1] ) then 
			    	hit4 = hit4 + 1
				    if( x1 > x2 ) then
				    	line4:SetPos(x2,y2+b:GetTall()) 
					    line4:SetSize(x1-x2+DDP.selected[1]:GetWide(),2)
			--		DDP.selected[1]:SetHorizontalTolerance(true)
					    DDP.selected[1].vertical = true
					    line4:SetVisible(true)
				    else
					    line4:SetPos(x1,y2+b:GetTall()) 
					    line4:SetSize(x2-x1+b:GetWide(),2)
					    DDP.selected[1].vertical = true
			--		DDP.selected[1]:SetHorizontalTolerance(true)

					    line4:SetVisible(true)
				    end
			    end
			    if( hit == 0 ) then
				    line:SetVisible(false)
				    DDP.selected[1].horizontal = false
			--	DDP.selected[1]:SetVerticalTolerance(false)
			    end
			    if( hit2 == 0 ) then
				    line2:SetVisible(false)
				    DDP.selected[1].horizontal = false
			--	DDP.selected[1]:SetVerticalTolerance(false)
			    end
			    if( hit3 == 0  ) then
				    line3:SetVisible(false)
				    DDP.selected[1].vertical = false
			--	DDP.selected[1]:SetHorizontalTolerance(false)
			    end
			    if( hit4 == 0 ) then
				    line4:SetVisible(false)
				    DDP.selected[1].vertical = false
			--	DDP.selected[1]:SetHorizontalTolerance(false)
			    end
            end
        end
		--[[---------------------------------------------------------
		Parents		DDP.MousePos[1] = gui.MouseX()
		DDP.MousePos[2]
		-----------------------------------------------------------]]
		-- get selected
			local selected = DDP.selected[1]
			for a,b in ipairs( DDP.elemente) do
				if( selected != b ) then 
                    if( !b:IsValid()) then
                    else
					    if( selected.x >= b.x and selected.x + selected:GetWide() <= b.x + b:GetWide() and selected.y >= b.y and selected.y + selected:GetTall() <= b.y + b:GetTall() ) then
					    -- is parent allowed
					    	if( b.ClassName == "RPanel" ) then

						         DDP.selected[1].y = DDP.selected[1].y + 0.01
							    selected:SetParent(b)
						-- calc new pos
							    local parentposx, parentposy = b:GetPos()
							    local mx =  (DDP.frame.x  - gui.MouseX()) + selected:GetWide() 
							    local my = (DDP.frame.y  - gui.MouseY()) + selected:GetTall() 
						    end
					    end
                    end
				end
			end
		

		if(input.IsMouseDown(MOUSE_RIGHT)) then	OpenMenu() end
		if( input.IsMouseDown( MOUSE_LEFT ) and !_b ) then 
			_b = true
			local fx,fy = DDP.frame:LocalCursorPos()
			DDP.MousePressed = { fx, fy }
		elseif( !input.IsMouseDown( MOUSE_LEFT ) ) then
			_b = false
		end
	end

end
	
hook.Add("Think","DDP_vgui_think",CheckSelected)

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function DebugHud()

if( DDP.frame == nil ) then return end

if( DDP.selected[1] == nil ) then return end
if( !DDP.selected[1]:IsValid() ) then return end 
local x1,y1 = DDP.selected[1]:GetPos()
draw.SimpleText( "Selected: " , "DermaDefault", 50, 25, Color(255,0,0,255), 1, 1 )
draw.SimpleText( "X: " .. x1 .. " Y: " .. y1 .. " Z: " .. DDP.selected[1]:GetZPos() .. "" , "DermaDefault", 50, 50, Color(255,0,0,255), 1, 1 )

for k,v in ipairs( DDP.elemente ) do

	if(v != DDP.selected[1] ) then
     if( !v:IsValid() ) then
     else
	local fx,fy = DDP.frame:LocalCursorPos()
	local x,y = v:GetPos()
	draw.SimpleText( "X: " .. x .. " Y: " .. y .. " Z: " .. v:GetZPos() .. " Mousepos: " .. fy .. " " .. DDP.MousePressed[2] .. "" , "DermaDefault", 50, 50+k*25, Color(255,0,0,255), 1, 1 )
    end
	end
	end
end

hook.Add("HUDPaint","Paint",DebugHud)


-- Set type ermitteln ] lua_run_cl a = [[ {"bla"} ]] RunString( "print(type(" .. a .. "))")


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
local function CursorDisplay()

	if( timer.Exists( "ddp_place" ) ) then
		local x,y = input.GetCursorPos()

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( Material("DD/icons/" .. DDP.icon .. ".png") ) 
		surface.DrawTexturedRect( x+10,y+20,15,15 )
	end
	
	--DDP.icon
end
hook.Add("DrawOverlay","DDP_Cursor", CursorDisplay )



--[[---------------------------------------------------------
   Name: Test
-----------------------------------------------------------]]

function CreateTestSwitcher()

	
local frame = vgui.Create("DFrame")
frame:SetPos( 0.052083333333333 * ScrW(), 0.083333333333333 * ScrH() )
frame:SetSize( 0.5 * ScrW(), 0.5 * ScrH() )
frame:MakePopup()

local testswitcher = vgui.Create("DDPageSwitch", frame)
	  testswitcher:SetPos( 25,25)
	  testswitcher:SetSize( 0.5 * ScrW() - 50, 0.5 * ScrH() - 50 )

local panel1 = vgui.Create("DPanel")

local button1 = vgui.Create("DButton",panel1)
button1:SetPos(175,250)
button1:SetSize(150,20)
button1:SetText("21314523534")
local panel2 = vgui.Create("DPanel")

local button2 = vgui.Create("DButton",panel2)
button2:SetPos(150,300)
button2:SetText("asdjkaj1832238sdlkasjdk")
button2:SetSize(150,20)
local panel3 = vgui.Create("DPanel")

local button3 = vgui.Create("DButton",panel3)
button3:SetText("asdjkajsdlkasjdk")
button3:SetPos(150,150)
button3:SetSize(150,20)


testswitcher:AddPage(panel1)
testswitcher:AddPage(panel2)
testswitcher:AddPage(panel3)
end




