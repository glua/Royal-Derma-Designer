--[[---------------------------------------------------------
Name: Skincreator
Desc:
Note: Some of the panel was created with the Derma Designer
-----------------------------------------------------------]]

DDP_Designer = {  Projects = {}  }

 --[[---------------------------------------------------------
Name: AddDesigner( string, panel )
-----------------------------------------------------------]]
local function AddDesigner( name, sheet, w, h )
 
 if( w > sheet:GetWide() - sheet:GetPadding() * 2 ) then w = sheet:GetWide() - sheet:GetPadding() * 2 end
 if( h > ( sheet:GetTall() - 28 ) - sheet:GetPadding() ) then h = ( sheet:GetTall() - 28 ) - sheet:GetPadding()  end
 if( w <= 0 ) then w = 10 end
 if( h <= 0 ) then h = 10 end

	local she = vgui.Create("DDDesigner")
	she:SetSize( w,h )

	table.insert( DDP_Designer.Projects, { panel = she, id = #DDP_Designer.Projects + 1, layer = {}, name = name } )

	sheet:AddSheet( name, DDP_Designer.Projects[ #DDP_Designer.Projects ].panel , "icon16/cross.png", true, true, "" )



end

function MessageBoxDesigner()

local frame = vgui.Create("DFrame")
frame:SetPos( 0.30677083333333 * ScrW(), 0.13166666666667 * ScrH() )
frame:SetSize( 0.30364583333333 * ScrW(), 0.083333333333333 * ScrH() )
frame:MakePopup() 

 local e = vgui.Create( "DButton", frame )
						 e:SetPos( 0.018867924528302 * frame:GetWide(), 0.68 * frame:GetTall() )
						 e:SetSize( 0.30531732418525 * frame:GetWide(), 0.22 * frame:GetTall() )
						 e:SetDrawBackground( true )
						 e:SetText( "Anwenden" )
						 e:SetFont( "DermaDefault" )
						 e:SetDisabled( false )
						
 local e = vgui.Create( "DButton", frame )
						 e:SetPos( 0.67581475128645 * frame:GetWide(), 0.68 * frame:GetTall() )
						 e:SetSize( 0.30531732418525 * frame:GetWide(), 0.22 * frame:GetTall() )
						 e:SetDrawBackground( true )
						 e:SetText( "Nicht anwenden" )
						 e:SetFont( "DermaDefault" )
						 e:SetDisabled( false )
						
 local e = vgui.Create( "DButton", frame )
						 e:SetPos( 0.34819897084048 * frame:GetWide(), 0.68 * frame:GetTall() )
						 e:SetSize( 0.30531732418525 * frame:GetWide(), 0.22 * frame:GetTall() )
						 e:SetDrawBackground( true )
						 e:SetText( "Abbrechen" )
						 e:SetFont( "DermaDefault" )
						 e:SetDisabled( false )
						
 local e = vgui.Create( "DLabel", frame )
						 e:SetPos( 0.10806174957118 * frame:GetWide(), 0.32 * frame:GetTall() )
						 e:SetSize( 0.39108061749571 * frame:GetWide(), 0.2 * frame:GetTall() )
						 e:SetDisabled( false )
						 e:SetText( "M�chten Sie die Transformation anwenden ?" )
						
 local e = vgui.Create( "DImage", frame )
						 e:SetPos( 0.0085763293310463 * frame:GetWide(), 0.32 * frame:GetTall() )					
						 e:SetSize( 0.075471698113208 * frame:GetWide(), 0.28 * frame:GetTall() )
end

 --[[---------------------------------------------------------
Name: NewTemplate( panel ) --sheet
-----------------------------------------------------------]]
function NewTemplate( s )

local select = "basic"
local test = {}
test["basic"] = { w = 750, h = 500, backg = Color( 255, 255, 255, 0) }

local frame = vgui.Create("GMenu")
frame:SetPos(ScrW() * .2822,ScrH() *.3683)
frame:SetSize(ScrW() * .1562,ScrH()*.1475) 
frame:SetDraggable( false )
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
						 /*local settings = string.Explode( "\n", file.Read("ride/newmenu_settings.txt", "DATA") )
							for k,v in ipairs( settings ) do
								if( v == "" ) then

								else

								local t =  util.JSONToTable( v )
								test[t.name] = { w = t.w, h = t.h, backg = t.backg }
								e:AddChoice( t.name )
								end
							end */
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
                         Name.count = 0
                         Name.PaintOver = function( self, w, h )
                        if( self:IsEditing() ) then return end
                        for k,v in ipairs( s:GetAllTabs() ) do

                            if( string.Explode( "(", v.Name  )[1]== string.Explode( "(", self:GetText()  )[1] ) then

                                  self.count = self.count + 1
                           end
                         end
                         
                         if( self.count > 0 ) then self:SetText( string.Explode( "(", self:GetText()  )[1] .. "(" .. self.count .. ")" ) self.count = 0 end

                         end
				
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
						 save:SetPos(ScrW() * .2822,ScrH() * .3683)
						 save:SetSize(ScrW() * .2083,ScrH() * .05 ) 
						 save:SetTitle( "Save settings")
						 save:SetDraggable( false )
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
       e.DoClick = function( self )

	   AddDesigner( Name:GetText(), s, tonumber( width:GetText() ), tonumber( height:GetText() ) )
	   frame:Remove()

	 end
 end

--[[---------------------------------------------------------
Name: CreateTransform( string, number, number, number, number, panel, table )
-----------------------------------------------------------]]
local function CreateTransform( typ, x, y, w, h, parent, data, poly )

	--if( typ == nil or x == nil or y == nil or w == nil or h == nil or parent == nil or data == nil ) then print( "[DermaDesigner]: nil value in CreateTranform()") return end
	parent:SetModus( "none" )
	if( typ == "circle" ) then 
	h = w
	local t = vgui.Create( "DDTransform", parent )
	t:SetPos( w, y  )
	t:SetSize( w * 2, h * 2 )
	t:SetDraw( true )
	t:SetDrawTable( data )
	t:SetTyp( typ )
	elseif( typ == "4poly" or typ == "poly" ) then


		// poly

		local tx = {}
		local ty = {}
		for k,v in ipairs( poly ) do

			table.insert( tx, v.x )
			table.insert( ty, v.y )

		end
		table.sort( tx, function( a, b ) return a > b end )
		table.sort( ty, function( a, b ) return a > b end )

		local t = vgui.Create( "DDTransform", parent )
		t:SetPos( tx[#tx],ty[#ty] )
		t:SetSize( tx[1] - tx[#tx], ty[1] - ty[#ty] )


		local mid_x = tx[#tx] + t:GetWide()*.5
		local mid_y = ty[#ty] + t:GetTall()*.5

		local relative = {}
		//Relative Position 
		for k,v in ipairs( poly ) do
			local tmp = {x=nil,y=nil,vx=nil,vy=nil}
			local x = mid_x - v.x
			local y = mid_y - v.y
			if( x > 0 ) then//  section 1 rechts
				tmp.vx = 1
				tmp.x = x
			else // section 0 links
				x = math.abs(x)
				tmp.vx = 0
				tmp.x = x
			end

			if( y > 0 ) then //  section 2 oben

				tmp.vy = 1
				tmp.y = y
			else // section 3 unten
			y = math.abs(y)
				tmp.vy = 0
				tmp.y = y
			end
			table.insert(relative, tmp)
		end

PrintTable(relative)







		t:SetDraw( true )
		t:SetDrawTable( data )
		t:SetTyp( typ )
		t:SetInit( { tx[#tx],ty[#ty], tx[1] - tx[#tx], ty[1] - ty[#ty], relative } )

	elseif( typ == "rect" or typ == "orect" ) then

	local t = vgui.Create( "DDTransform", parent )
	t:SetPos( x, y )
	t:SetSize( w, h )
	t:SetDraw( true )
	t:SetDrawTable( data )
	t:SetTyp( typ )
	end


/*

local tx = {}
local ty = {}
for k,v in ipairs( poly ) do

	table.insert( tx, v.x )
	table.insert( ty, v.y )

end
table.sort( tx, function( a, b ) return a > b end )
table.sort( ty, function( a, b ) return a > b end )

local t = vgui.Create( "DDTransform", parent )
t:SetPos( tx[#tx],ty[#ty] )
t:SetSize( tx[1] - tx[#tx], ty[1] - ty[#ty] )
t:SetDraw( true )
t:SetDrawTable( data )
t:SetTyp( typ )
t:SetInit( { tx[#tx],ty[#ty], tx[1] - tx[#tx], ty[1] - ty[#ty], poly } )
*/

end

--[[---------------------------------------------------------
Name: PaintFrame( string )
-----------------------------------------------------------]]
function PaintFrame( n )

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

	local frame = vgui.Create("GMenu")
	frame:SetTitle( "designer" )
	frame:SetPos(ScrW() * 0.11315789473684210526315789473684,ScrH() * 0.24)
	frame:SetDraggable( false )
	frame:SetSize(ScrW() * 0.50526315789473684210526315789474,ScrH() * 0.5) 
	frame:MakePopup()

	local sheet = vgui.Create( "DPropertySheet", frame )
	sheet:SetPos(0.041666666666667*frame:GetWide(),30)
	sheet:SetSize( frame:GetWide() - 0.041666666666667*frame:GetWide() ,frame:GetTall() - 25)
    sheet.GetActive = function( self ) 
        local t = nil
        for k,v in ipairs( self.Items ) do 
            if( v.Panel:IsVisible() ) then
             t = v
            end 
        end
     return t
     end 

     sheet.GetAllTabs = function( self )


        return self.Items

     end
    
	local datei = vgui.Create( "GMenuButton", frame )
	datei:SetPos( 2, 2 )
	datei:SetSize( frame:GetWide() * .06, 26 )
	datei:SetText( "FILE" )
	datei.Clicked = function()

	local datei_menu = DermaMenu() 
	datei_menu:AddOption( "New", function() NewTemplate( sheet ) end )
	datei_menu:AddOption( "Open", function()  end )
	datei_menu:AddOption( "Save", function()  end )
	datei_menu:AddOption( "Save as", function()  end )
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
	bearbeiten.Clicked = function()

	local datei_menu = DermaMenu()

		datei_menu:AddOption( "transform", function() 
			if( #EPanel.selected > 0 ) then 
				if( designer.layer[EPanel.selected[1]:GetID()].typ == "rect" or designer.layer[EPanel.selected[1]:GetID()].typ == "orect" ) then
					CreateTransform( designer.layer[EPanel.selected[1]:GetID()].typ, designer.layer[EPanel.selected[1]:GetID()].x, designer.layer[EPanel.selected[1]:GetID()].y, designer.layer[EPanel.selected[1]:GetID()].w, designer.layer[EPanel.selected[1]:GetID()].h, GetDDesigner(), { DDP_Designer.Projects, EPanel.current, EPanel.selected[1].form }  )
				elseif(  designer.layer[EPanel.selected[1]:GetID()].typ == "poly" or designer.layer[EPanel.selected[1]:GetID()].typ == "4poly" ) then
					CreateTransform( designer.layer[EPanel.selected[1]:GetID()].typ, nil, nil, nil, nil,  GetDDesigner(),{ DDP_Designer.Projects, EPanel.current, EPanel.selected[1].form }, designer.layer[EPanel.selected[1]:GetID()].poly  )
				elseif( designer.layer[EPanel.selected[1]:GetID()].typ == "circle" ) then
					CreateTransform( designer.layer[EPanel.selected[1]:GetID()].typ, designer.layer[EPanel.selected[1]:GetID()].x, designer.layer[EPanel.selected[1]:GetID()].y, designer.layer[EPanel.selected[1]:GetID()].w, designer.layer[EPanel.selected[1]:GetID()].h, GetDDesigner(), { DDP_Designer.Projects, EPanel.current, EPanel.selected[1].form }  )
				end 
			end
		end )

	local x,y = frame:LocalToScreen( datei.x, datei.y + datei:GetTall( ) )
	datei_menu:Open( x, y )
	

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
	Eframe:SetDraggable( false )
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
	EPanel.selected = {}
    EPanel.Tabs = {}
    EPanel.current = nil
    EPanel.Clear = function( self ) 

        for k,v in ipairs( self:GetChildren() ) do

            if( v:IsValid() ) then v:Remove() end
        end 
    end
	
--	local selected = { }
	local Button_Layer = { }
	local sheet_active = nil

--[[---------------------------------------------------------
Name: PANEL:Think( void )
-----------------------------------------------------------]]
function EPanel:Think( )

	if( GetDDesigner( ) == nil ) then return end
    designer = GetDDesigner( )
    if( self.current == nil ) then self.current = sheet:GetActive().Name end
    if( self.current != sheet:GetActive().Name ) then 
    self.Tabs[ self.current ] = { }
    for k,v in ipairs( Button_Layer ) do
    
        table.insert( self.Tabs[ self.current ], { preview = v.rrot, id = v:GetID() } )
    
    end 
   -- PrintTable( self.Tabs[ self.current ] )
    Button_Layer = { }
    self:Clear()
        if( self.Tabs[ sheet:GetActive().Name ] ) then
            for k,v in ipairs( self.Tabs[ sheet:GetActive().Name ] ) do
    --
        
                Button_Layer[ v.id ] = EPanel:Add( "DDLayer" )
                Button_Layer[ v.id ]:SetPreView( v.preview )
                Button_Layer[ v.id ]:SetID( v.id )
                Button_Layer[ v.id ]:SetSize( EPanel:GetWide(), 60 )

            end
        end
    self:Layout()
    self.current = sheet:GetActive().Name
    end

		if( #self:GetChildren() < #designer.layer ) then

			Button_Layer[ designer:GetLayer()[ #designer.layer ].id ] = EPanel:Add( "DDLayer" )
			Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetSize( EPanel:GetWide(), 60 )
			if( designer.layer[#designer.layer].typ == "4poly" or designer.layer[#designer.layer].typ == "poly" ) then
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = designer.layer[#designer.layer].poly, col = designer.layer[#designer.layer].col  } )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetID( #designer.layer )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ].form = designer.layer[#designer.layer].name
			elseif( designer.layer[#designer.layer].typ == "rect" or designer.layer[#designer.layer].typ == "orect"  ) then
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w, h = designer.layer[#designer.layer].h, col = designer.layer[#designer.layer].col } } )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetID( #designer.layer )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ].form = designer.layer[#designer.layer].name
			elseif( designer.layer[#designer.layer].typ == "circle" ) then
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w, col = designer.layer[#designer.layer].col} } )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ]:SetID( #designer.layer )
				Button_Layer[ designer:GetLayer()[ #designer.layer ].id ].form = designer.layer[#designer.layer].name
			end
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
				//	print( DDP_Designer.Projects[k].layer.id )
				end
			end
			sheet_active = sheet:GetActiveTab()
		end

		if( GetDDesigner( ):GetMoving() != nil ) then

			for k,v in ipairs( designer:GetLayer() ) do

				if( v.id == GetDDesigner( ):GetMoving() ) then

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
				if( table.HasValue( self.selected, v ) ) then
				else
					if( #self.selected > 0 ) then
						if( self.selected[1]:IsValid() ) then
							self.selected[1]:SetSelect( false )
						else

						end
						table.Empty( self.selected )
					end 
					table.insert( self.selected, v )
					designer:SetSelect( v:GetID() )
				end
			end
		end
	end
--[[---------------------------------------------------------
Name: PANEL:Paint( number, number ) 
-----------------------------------------------------------]]
function EPanel:Paint( w, h )
	 surface.SetDrawColor( 0, 0, 0, 255 )
	 surface.DrawOutlinedRect( 0, 0, w, h )
end

	local save = vgui.Create("DButton",Eframe )
	save:SetPos(2,33)
	save:SetSize( Eframe:GetWide()-4, 25 )
	save:SetText("save")
	save.DoClick = function()

	local pfile = { }
	
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
