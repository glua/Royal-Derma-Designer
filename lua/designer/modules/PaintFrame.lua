--[[---------------------------------------------------------
Name: Skincreator
	function DDP_Designer.Projects[ #DDP_Designer.Projects ]:OverWrite()
	/*
		if( self.x < bounds.x ) then

			self.x = bounds.x 

		end

		if( self.y < bounds.y ) then

			self.y = bounds.y

		end

		if( self:GetWide() > bounds:GetWide() ) then
			
			self:SetWide( bounds:GetWide() )

		end

		if( self:GetTall() > bounds:GetTall() ) then

			self:SetTall( bounds:GetTall() )

		end
		*/
	end
-----------------------------------------------------------]]


DDP_Designer = {  Projects = {}  }
 nlayer = {}












 --[[---------------------------------------------------------
Name: AddDesigner( string, panel )
-----------------------------------------------------------]]
local function AddDesigner( name, sheet )
    --DDP_Designer.Projects[ #DDP_Designer.Projects + 1 ] = 
	local she = vgui.Create("DDDesigner")
	she:SetSize( 10,10 )

	table.insert( DDP_Designer.Projects, { panel = she, id = #DDP_Designer.Projects + 1, layer = {}, name = name } )

	sheet:AddSheet( name, DDP_Designer.Projects[ #DDP_Designer.Projects ].panel , "icon16/cross.png", false, false, "" )



end




 --[[---------------------------------------------------------
Name: 
-----------------------------------------------------------]]
 function NewTemplate( s )

local select = "basic"
local test = {}
 test["basic"] = { w = 750, h = 500, backg = Color( 255, 255, 255, 0) }


 local frame = vgui.Create("GMenu")
frame:SetPos(542,442)
frame:SetSize(300,177) 
frame:SetDragable( false )
 frame:MakePopup()


  local width = vgui.Create("DTextEntry",frame)
						 width:SetPos(0.19*frame:GetWide() ,0.49717514124294*frame:GetTall())
						 width:SetSize(0.32666666666667*frame:GetWide(),0.14124293785311*frame:GetTall())
						 width:SetText( test[select].w )

 local height = vgui.Create("DTextEntry",frame)
						 height:SetPos(0.62666666666667*frame:GetWide() ,0.49717514124294*frame:GetTall())
						 height:SetSize(0.32666666666667*frame:GetWide(),0.14124293785311*frame:GetTall())
						 height:SetText( test[select].h )

 local e = vgui.Create("DComboBox",frame)
						 e:SetPos(0.19*frame:GetWide() ,0.33898305084746*frame:GetTall())
						 e:SetSize(0.76333333333333*frame:GetWide(),0.14124293785311*frame:GetTall())
						 local settings = string.Explode( "\n", file.Read("ride/newmenu_settings.txt", "DATA") )
							for k,v in ipairs( settings ) do
								if( v == "" ) then

								else

								local t =  util.JSONToTable( v )
								test[t.name] = { w = t.w, h = t.h, backg = t.backg }
								e:AddChoice( t.name )
								end
							end 
							e.OnSelect = function( panel, index, value )
							select = value
							 height:SetText( test[select].h )
							 width:SetText( test[select].w )
							end

 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.046666666666667*frame:GetWide() ,0.18079096045198*frame:GetTall())
						 e:SetSize(0.16666666666667*frame:GetWide(),0.14124293785311*frame:GetTall())
						 e:SetText("Name:")
				
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.046666666666667*frame:GetWide() ,0.33898305084746*frame:GetTall())
						 e:SetSize(0.19*frame:GetWide(),0.14124293785311*frame:GetTall())
						 e:SetText("Settings:")

 local Name = vgui.Create("DTextEntry",frame)
						 Name:SetPos(0.19*frame:GetWide() ,0.18079096045198*frame:GetTall())
						 Name:SetSize(0.76333333333333*frame:GetWide(),0.14124293785311*frame:GetTall())
						 Name:SetText( "Unknown" )
				
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.046666666666667*frame:GetWide() ,0.49717514124294*frame:GetTall())
						 e:SetSize(0.15*frame:GetWide(),0.14124293785311*frame:GetTall())
						 e:SetText("Width:")

 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.53*frame:GetWide() ,0.49152542372881*frame:GetTall())
						 e:SetSize(0.11*frame:GetWide(),0.14689265536723*frame:GetTall())
						 e:SetText("Tall:")


 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.046666666666667*frame:GetWide() ,0.64971751412429*frame:GetTall())
						 e:SetSize(0.15*frame:GetWide(),0.14124293785311*frame:GetTall())
						 e:SetText("Backg.")
						
 local e = vgui.Create("DComboBox",frame)
						 e:SetPos(0.19*frame:GetWide() ,0.64971751412429*frame:GetTall())
						 e:SetSize(0.76333333333333*frame:GetWide(),0.14124293785311*frame:GetTall())
						 e:SetValue( tostring(test[select].backg) )
 local e = vgui.Create("DButton",frame)
						 e:SetPos(0.52*frame:GetWide() ,0.80790960451977*frame:GetTall())
						 e:SetSize(0.43333333333333*frame:GetWide(),0.14124293785311*frame:GetTall())
						 e:SetText("save settings")
						 e.DoClick = function()

							local save = vgui.Create("GMenu")
							save:SetPos(542,442)
							save:SetSize(400,60) 
							save:SetTitle( "Save settings")
							save:SetDragable( false )
							save:MakePopup()
						 local files = vgui.Create("DTextEntry",save)
						 files:SetPos(2,32)
						 files:SetSize(save:GetWide()-4,26)
						 files:SetText( "" )
						 function files:OnEnter()
						 if( string.len(self:GetText()) < 6 ) then
							LocalPlayer():ChatPrint( "[DermaDesigner]: Sorry the name length must equal 6 or greater than 6, try again")
						else
							local t = { backg = Color(0,0,0,0) , name = self:GetText() , h = height:GetText() , w = width:GetText() }
							local j = util.TableToJSON( t )
							file.Append( "ride/newmenu_settings.txt", "\n" .. j )
							self:GetParent():Remove()
						end
						 end

						 end
 local e = vgui.Create("DButton",frame)
	   e:SetPos(0.046666666666667*frame:GetWide() ,0.80790960451977*frame:GetTall())
	   e:SetSize(0.43333333333333*frame:GetWide(),0.14124293785311*frame:GetTall())
	   e:SetText("create")
	   e.DoClick = function()
	   AddDesigner( Name:GetText(), s )
					--	PaintFrame( tonumber(width:GetText()), tonumber(height:GetText()) , Name:GetText() )	
		frame:Remove()

	 end	


 end


 --[[---------------------------------------------------------
Name: 
-----------------------------------------------------------]]
  function PaintFrame( n )

	local frame = vgui.Create("GMenu")
	frame:SetTitle( "designer" )
	frame:SetPos(ScrW() * 0.11315789473684210526315789473684,ScrH() * 0.24)
	frame:SetDragable( false )
	frame:SetSize(ScrW() * 0.50526315789473684210526315789474,ScrH() * 0.5) 
	frame:MakePopup()

	local sheet = vgui.Create( "DPropertySheet", frame )
	sheet:SetPos(0.041666666666667*frame:GetWide(),30)
	sheet:SetSize( frame:GetWide() - 0.041666666666667*frame:GetWide() ,frame:GetTall() - 25)

	local datei = vgui.Create( "GMenuButton", frame )
	datei:SetPos( 2, 2 )
	datei:SetSize( frame:GetWide() * .06, 26 )
	datei:SetText( "FILE" )
	datei.Clicked = function()

	local datei_menu = DermaMenu() 
	datei_menu:AddOption( "New", function() NewTemplate( sheet ) end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	datei_menu:AddOption( "unset", function()  end )
	local x,y = frame:LocalToScreen( datei.x, datei.y + datei:GetTall( ) )
	datei_menu:Open( x, y )
	end


	local bearbeiten = vgui.Create( "GMenuButton", frame )
	bearbeiten:SetPos( frame:GetWide() * .06 + 2, 2 )
	bearbeiten:SetSize( frame:GetWide() * .06, 26 )
	bearbeiten:SetText( "EDIT" )


	local function GetDDesigner( )

	local panel = nil

	if(  #DDP_Designer.Projects > 0 ) then

		for k,v in ipairs( DDP_Designer.Projects ) do

			if( v.panel:IsVisible() ) then

				panel = v.panel
			end

		end
	end
		return panel

	end



	local e = vgui.Create("DDSideBoard",frame)
	e:SetPos(0 ,30)
	e:SetSize(0.041666666666667*frame:GetWide(),frame:GetTall()-30)
	e:AddButton("DD/gui/mouse.png",function()  if( GetDDesigner( ) != nil ) then  GetDDesigner( ):SetModus("mouse") end end )
	e:AddButton("DD/gui/frect.png",function()  if( GetDDesigner( ) != nil ) then  GetDDesigner( ):SetModus("rect") end end )
	e:AddButton("DD/gui/poly.png",function()  if( GetDDesigner( ) != nil ) then  GetDDesigner( ):SetModus("poly") end end )
	e:AddButton("DD/gui/poly_4.png",function()  if( GetDDesigner( ) != nil ) then  GetDDesigner( ):SetModus("4poly") end end )
	e:AddButton("DD/gui/orect.png",function()  if( GetDDesigner( ) != nil ) then  GetDDesigner( ):SetModus("orect") end end )
	e:AddButton("DD/gui/circle.png",function()  if( GetDDesigner( ) != nil ) then  GetDDesigner( ):SetModus("circle") end end )

	local Eframe = vgui.Create("GMenu",frame)
	Eframe:SetTitle( "Editor")
	Eframe:SetDragable( false )
	Eframe:SetPos(frame:GetWide() + frame.x + 10 ,ScrH() * 0.24)
	Eframe:SetSize(ScrW()*0.10526315789473684210526315789474,ScrH() * 0.5) 
	

	
	local EColor = vgui.Create("DColorMixer",Eframe)
	EColor:SetPos(2,Eframe:GetTall() * 0.25)
	EColor:SetSize(	Eframe:GetWide()-4,Eframe:GetTall() * 0.5 - 35)
	function EColor:ValueChanged(col)
	if( GetDDesigner( ) == nil ) then return end 
	GetDDesigner( ):SetDrawColor(col)

	if( EPanel ) then
		if( #EPanel:GetChildren() > 0 ) then
			for k,v in ipairs( EPanel:GetChildren() ) do
				if( v:GetSelect() ) then
				
					GetDDesigner( ).layer[v:GetID()].col = col

				end
			end
		end
	end
	
	end




	local Scroll = vgui.Create( "DScrollPanel", Eframe ) //Create the Scroll panel
	Scroll:SetSize( Eframe:GetWide()-4,Eframe:GetTall() * 0.3 - 2 )
	Scroll:SetPos( 2,Eframe:GetTall()*0.70 )

	 EPanel = vgui.Create( "DIconLayout", Scroll )
	EPanel:SetSize( Scroll:GetWide(),Scroll:GetTall() )
	EPanel:SetPos( 0, 0 )
	EPanel:SetSpaceY( 5 ) //Sets the space in between the panels on the X Axis by 5
	EPanel:SetSpaceX( 5 ) 
	EPanel:MakeDroppable( "layer", false )
	EPanel:SetSelectionCanvas( true )
	EPanel:SetUseLiveDrag( true )
	

-- List:Add


	--local EPanel = vgui.Create("DPanelList",Eframe)
	--EPanel:SetPos(2,Eframe:GetTall()*0.70)
	--EPanel:SetSize(	Eframe:GetWide()-4,Eframe:GetTall() * 0.3 - 2)
	--EPanel:EnableVerticalScrollbar()
	local selected = {}
	local Button_Layer = {}
	local sheet_active = nil
	function EPanel:Think()

	

	if( GetDDesigner( ) == nil ) then return end
	designer = GetDDesigner( )
		if( #self:GetChildren() < #designer.layer ) then
		--print( designer:GetLayer()[ #designer.layer ].id .. "new"  )
			Button_Layer[ designer:GetLayer()[ #designer.layer ].id ] = EPanel:Add( "DDLayer" )

			--Button:Droppable( "layer")
			Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetSize( EPanel:GetWide(), 60 )
			if( designer.layer[#designer.layer].typ == "4poly" or designer.layer[#designer.layer].typ == "poly" ) then
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = designer.layer[#designer.layer].poly, col = designer.layer[#designer.layer].col  } )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetID( #designer.layer )
			elseif( designer.layer[#designer.layer].typ == "rect" or designer.layer[#designer.layer].typ == "orect"  ) then
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w, h = designer.layer[#designer.layer].h, col = designer.layer[#designer.layer].col } } )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetID( #designer.layer )
			elseif( designer.layer[#designer.layer].typ == "circle" ) then
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w, col = designer.layer[#designer.layer].col} } )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetID( #designer.layer )
			end


			--EPanel:AddItem(Button)
			
		end 


			


	 		local key = nil

			for k,v in ipairs( DDP_Designer.Projects ) do

				if( v.panel:IsVisible() ) then

					key = k

				end

			end
			if( key != nil ) then 
				if( #designer.layer > #DDP_Designer.Projects[key].layer ) then
			
					table.insert(DDP_Designer.Projects[key].layer, Button_Layer[ designer:GetLayer()[ #designer.layer ].id ].rrot )
				end
			end


			if( sheet_active != sheet:GetActiveTab() ) then
				
				for k,v in ipairs( DDP_Designer.Projects ) do

					if( v.panel:GetParent() == sheet:GetActiveTab()  ) then
						print( DDP_Designer.Projects[k].layer.id )
					end
				end

				sheet_active = sheet:GetActiveTab()
			end

		if( GetDDesigner( ):GetMoving() != nil ) then

			for k,v in ipairs( designer:GetLayer() ) do

				if( v.id == GetDDesigner( ):GetMoving() ) then

				--print( v.id )

					if( v.typ == "rect" or v.typ == "orect" ) then
						Button_Layer[ v.id ]:SetPreView( { typ = v.typ , parent = designer, data = { x = v.x, y = v.y, w = v.w, h = v.h } } )
					elseif( v.typ == "4poly" or v.typ == "poly" ) then
						Button_Layer[ v.id ]:SetPreView( { typ = v.typ , parent = designer, data = v.poly } )
					elseif( v.typ == "circle" ) then
						Button_Layer[ v.id ]:SetPreView( { typ =v.typ , parent = designer, data = { x = v.x, y = v.y, w = v.w} })
					end

					

				end


			end


		end

		for k,v in ipairs( self:GetChildren()  ) do
	
			if( v:GetSelect() ) then
				if( table.HasValue( selected, v ) ) then
				else
					if( #selected > 0 ) then
						if( selected[1]:IsValid() ) then
							selected[1]:SetSelect( false )
						else
						end
							table.Empty( selected )
					end 
					table.insert( selected, v )
					designer:SetSelect( v:GetID() )
				end
			end
		end
	end


	function EPanel:Paint( w, h )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local save = vgui.Create("DButton",Eframe )
	save:SetPos(2,33)
	save:SetSize( Eframe:GetWide()-4, 25 )
	save:SetText("save")
	save.DoClick = function()

	local pfile = {}
	
	for k,v in ipairs( designer.layer ) do
	--if( v
		if( v.typ == "poly" ) then
			local line = [[ 
		surface.SetDrawColor( 225,0,0,255 )
		surface.SetTexture(-1)
		surface.DrawPoly({ { x = ]]  .. v.poly[1].x / designer:GetWide() .. " * w , y = " .. v.poly[1].y / designer:GetTall() .. " * h },{ x = " .. v.poly[2].x / designer:GetWide() .. " * w ,y = " .. v.poly[2].y / designer:GetTall() .. " * h },{x = " .. v.poly[3].x / designer:GetWide() .. " * w ,y = " .. v.poly[3].y / designer:GetTall() .. [[ * h } } )]]
		table.insert( pfile, line )
		elseif( v.typ == "4poly" ) then
			local line = [[ 
		surface.SetDrawColor( 225,0,0,255 )
		surface.SetTexture(-1)
		surface.DrawPoly({ { x = ]]  .. v.poly[1].x / designer:GetWide() .. " * w , y = " .. v.poly[1].y / designer:GetTall() .. " * h },{ x = " .. v.poly[2].x / designer:GetWide() .. " * w ,y = " .. v.poly[2].y / designer:GetTall() .. " * h },{x = " .. v.poly[3].x / designer:GetWide() .. " * w ,y = " .. v.poly[3].y / designer:GetTall() .. " * h },{ x = " .. v.poly[4].x / designer:GetWide() .. " * w , y = " .. v.poly[4].y / designer:GetTall() .. [[ * h} })]]
		table.insert( pfile, line )
		elseif( v.typ == "circle" ) then
			local line = [[ 
		surface.DrawCircle( ]] .. v.x / designer:GetWide() .. " * w," .. v.y / designer:GetTall() .. " * h," .. v.w / designer:GetTall() .. " * w , Color(" .. "255,0,0,255" ..  [[ ) )]]
		table.insert( pfile, line )
		elseif( v.typ == "rect" ) then
			local line = [[ 
		surface.SetDrawColor( 225,0,0,255 )
		surface.DrawRect( ]] .. v.x / designer:GetWide() .. " * w," .. v.y / designer:GetTall() .. " * h," .. v.w / designer:GetWide() .. " * w," .. v.h / designer:GetTall() .. [[ * h )]]
		table.insert( pfile, line )
		elseif( v.typ == "orect" ) then
			local line = [[ 
		surface.SetDrawColor( 225,0,0,255 )
		surface.DrawOutlinedRect(]] .. v.x / designer:GetWide() .. " * w ," .. v.y / designer:GetTall() .. " * h," .. v.w / designer:GetWide() .. " * w," .. v.h / designer:GetTall() .. [[ * h )]]
			table.insert( pfile, line )
		end
	end
	PrintTable( pfile )
	Msg("\n")

	if( file.Exists("ride/" .. name .. ".txt","DATA") ) then
		// overwirte question

		file.Delete("ride/" .. name .. ".txt")
	end

		for k,v in ipairs( pfile ) do
			if( file.Exists("ride/" .. name .. ".txt","DATA") ) then
				file.Write( "ride/" .. name .. ".txt", file.Read("ride/" .. name .. ".txt") .. "\n" .. v .. "" )
			else
				file.Write("ride/" .. name .. ".txt", v )

			end
		end

	local a,b = 250,25
	local temp = [[
function ]] .. name .. [[()
	local frame = vgui.Create( "DFrame" )
	frame:SetPos(500, 500 )
	frame:SetSize(500, 500)
	frame:SetTitle( "]] .. name .. [[" )
	frame:SetVisible( true )
	frame:SetDraggable( true )
	frame:SetSizable( true )
	frame:ShowCloseButton( true )
	frame:MakePopup()

	local preview = vgui.Create("DPanel", frame )
	preview:SetPos(5,35)
	preview:SetSize( ]] .. a .. [[, ]] .. b .. [[)
	function preview:Paint(w,h)

	]] .. file.Read("ride/" .. name .. ".txt","DATA")  .. [[  

	end

end

	]] .. name .. [[() ]]
	RunString( temp )

	end

 end
