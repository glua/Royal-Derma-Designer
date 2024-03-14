
PANEL = {}

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

	self.image = Material("dd/icons/default.png")
	self.text = ""
	self.colorn = Color( 62, 62, 64 , 255 )
	self.colorh = Color( 51, 153, 255, 255 )
	self.selected = false
	self.tooltip = false
	self.tooltiptext = ""

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetSelected( bool )

	self.selected = bool

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:GetSelected()

	return self.selected	

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetTooltip( bool )

	self.tooltip = bool

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetTooltipText( str )

	self.tooltiptext = str

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetSelectedColor( col )

	self.colorn = col

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetHoveredColor( col )

	self.colorh = col

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetText( txt )

	self.text = txt

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:GetText()

	return self.text

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:SetImage( img )

	self.image = Material( img )

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:GetImage()

	return self.image

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:DoClick()


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

// draw image here
			surface.SetDrawColor(255,255,255,255)

	if( !self:IsHovered() ) then
		surface.SetDrawColor(self.colorn)
		surface.DrawRect(0,0,w,h)
	elseif( self:IsHovered() ) then
		surface.SetDrawColor(Color(100,100,100,255))
		surface.DrawRect(0,0,w,h)
	end
	if( self.selected ) then
		surface.SetDrawColor(self.colorh)
		surface.DrawRect(0,0,w,h)
	end

	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial( self.image ) 
	surface.DrawTexturedRect(10,3,16,16)
	draw.SimpleText(  self.text .. " " , "DermaDefault", w/2, h/2, self.color, 1, 1 )
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(0,0,w,h)
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mcode )

self:DoClick()


		self:SetSelected( true )




end

--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )

self:SetSelected( false )

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


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PaintOver( w, h )


end


derma.DefineControl( "DDListButtom", "A standard Button", PANEL, "DPanel" )