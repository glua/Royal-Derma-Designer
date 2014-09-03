--[[---------------------------------------------------------
Name: Skincreator
-----------------------------------------------------------]]

 nlayer = {}

 function PaintFrame( w, h )

	local frame = vgui.Create("GMenu")
	frame:SetTitle( "Royal Derma Designer [Skincreator]")
	frame:SetPos(ScrW() * 0.11315789473684210526315789473684,ScrH() * 0.24)
	frame:SetDragable( false )
	frame:SetSize(ScrW() * 0.50526315789473684210526315789474,ScrH() * 0.5) 
	frame:MakePopup()

    local designer = vgui.Create("DDDesigner",frame)
    designer:SetPos(frame:GetWide() * 0.5 - w * 0.5 ,frame:GetTall() * 0.5 - h * 0.5 )
	designer:SetSize( w - (0.003125*frame:GetWide()) , h )
		// needs a max w and h 
	local e = vgui.Create("DDSideBoard",frame)
	e:SetPos(0.003125*frame:GetWide() ,0.045*frame:GetTall()+3)
	e:SetSize(0.041666666666667*frame:GetWide(),0.94833333333333*frame:GetTall())
	e:AddButton("DD/icons/Button.png",function() designer:SetModus("mouse") end )
	e:AddButton("DD/gui/frect.png",function() designer:SetModus("rect") end )
	e:AddButton("DD/gui/poly.png",function() designer:SetModus("poly") end )
	e:AddButton("DD/gui/poly.png",function() designer:SetModus("4poly") end )
	e:AddButton("DD/gui/orect.png",function() designer:SetModus("orect") end )
	e:AddButton("DD/gui/circle.png",function() designer:SetModus("circle") end )

	local Eframe = vgui.Create("GMenu",frame)
	Eframe:SetTitle( "Editor")
	Eframe:SetDragable( false )
	Eframe:SetPos(frame:GetWide() + frame.x + 10 ,ScrH() * 0.24)
	Eframe:SetSize(ScrW()*0.10526315789473684210526315789474,ScrH() * 0.5) 
	
	
	local EColor = vgui.Create("DColorMixer",Eframe)
	EColor:SetPos(2,33)
	EColor:SetSize(	Eframe:GetWide()-4,Eframe:GetTall() * 0.5 - 35)
	function EColor:ValueChanged(col)

	designer:SetDrawColor(col)
	
	end

	local EPanel = vgui.Create("DPanelList",Eframe)
	EPanel:SetPos(2,Eframe:GetTall()*0.5)
	EPanel:SetSize(	Eframe:GetWide()-4,Eframe:GetTall() * 0.5 - 2)
	EPanel:EnableVerticalScrollbar()
	local selected = {}
	
	function EPanel:Think()

		if( #self.Items < #designer.layer ) then

			Button = vgui.Create( "DDLayer" )
			Button:SetSize( EPanel:GetWide(), 60 )
			if( designer.layer[#designer.layer].typ == "4poly" or designer.layer[#designer.layer].typ == "poly" ) then
			Button:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = designer.layer[#designer.layer].poly } )
			elseif( designer.layer[#designer.layer].typ == "rect" ) then
			Button:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w, h = designer.layer[#designer.layer].h } } )
			elseif( designer.layer[#designer.layer].typ == "orect" ) then
			Button:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w, h = designer.layer[#designer.layer].h } } )
			elseif( designer.layer[#designer.layer].typ == "circle" ) then
			Button:SetPreView( { typ = designer.layer[#designer.layer].typ , parent = designer, data = { x = designer.layer[#designer.layer].x, y = designer.layer[#designer.layer].y, w = designer.layer[#designer.layer].w} } )
			end
			table.insert(nlayer, Button)
			EPanel:AddItem(Button)

		end

		for k,v in ipairs( self.Items ) do
	
			if( v:GetSelect() ) then
				if( table.HasValue( selected, v ) ) then
				else
					if( #selected > 0 ) then
						selected[1]:SetSelect( false )
						table.Empty( selected )
					end 
					table.insert( selected, v )
				end
			end
		end
	end
	function EPanel:Paint( w, h )
	surface.SetDrawColor( 255, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )
	end

 end
