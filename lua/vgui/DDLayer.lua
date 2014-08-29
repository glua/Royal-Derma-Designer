
PANEL = {}
AccessorFunc( PANEL, "m_stext", 			"Text" )
AccessorFunc( PANEL, "m_bselect", 		"Select", 		FORCE_BOOL )
--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetText("")
	self.draw = {}
	self:SetSelect(false)

	self.check = vgui.Create("DCheckBox",self)
end



--[[---------------------------------------------------------
   Name: tab = { typ = "", parent = p, data = {} }
-----------------------------------------------------------]]
function PANEL:SetPreView( tab )

local w,h = self:GetWide() * 0.3636, self:GetTall() - 4

	if( tab.typ == "poly" ) then
		local t = {}
		for k,v in ipairs( tab.data ) do
			
			local xr,yr = v.x  / tab.parent:GetWide(), v.y / tab.parent:GetTall()

			table.insert( t, { x = (xr * (w)) + self:GetWide() / 12   , y = yr * (self:GetTall()-4) } )
			end
		table.insert( self.draw, { typ = tab.typ, data = table.Copy(t) } )

	elseif( tab.typ == "rect" ) then

	elseif( tab.typ == "orect" ) then

	elseif( tab.typ == "circle" ) then

	elseif( tab.typ == "texture" ) then

	end


end


--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )

end


--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )
	if( !self.m_bselect ) then
		self:SetSelect( true ) 
	else
		self:SetSelect(false)
	end
end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Think()


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	self.check:SetPos(1,h*0.5 - h*0.125)
	self.check:SetSize(w/11 - 2,h*.25)
	self.check:SetChecked(true)

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(214,214,214,255)
	surface.DrawRect(0,0,w,h)

	if( self.m_bselect ) then
	surface.SetDrawColor(12,160,245,255)
	surface.DrawRect(w/11,0,w-w/11,h)
	end

	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(0,0,w,1)
	surface.DrawRect(0,h-1,w,1)
	surface.DrawRect(w/11,0,1,h)
	
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(w/11+2,2,w*0.37,h-4)

	if( self.draw[1].typ == "poly" ) then

	surface.SetDrawColor( 225,0,0,255 )
	surface.SetTexture(-1)
	surface.DrawPoly( self.draw[1].data )

	elseif( self.draw.typ == "rect" ) then

	elseif( self.draw.typ == "orect" ) then

	elseif( self.draw.typ == "circle" ) then

	elseif( self.draw.typ == "texture" ) then

	end

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PaintOver( w, h )



end


derma.DefineControl( "DDLayer", "A standard Button", PANEL, "DPanel" )