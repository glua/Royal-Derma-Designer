
PANEL = {}
AccessorFunc( PANEL, "m_iColor", 			"Color" )
AccessorFunc( PANEL, "m_iDrawColor", 			"DrawColor" )
AccessorFunc( PANEL, "m_bhelp", 		"HelpLines", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_ihx", 			"HeightX" )
AccessorFunc( PANEL, "m_ihy", 			"HeightY" )
AccessorFunc( PANEL, "m_imod", 			"Modus" )
--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()


	self:SetColor(Color( 0, 0, 0, 0 ))
	self:SetHelpLines( false )
	self:SetModus("mouse")
	self:SetDrawColor(Color(255,0,0,255))
	self.layer = {}
	self.buff = {}
	self.out = 0
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

self.draw = {}
local size = 128
if( self.m_iColor.a > 0 ) then

else
	if( w > size or h > size ) then

		local x2,y2 = math.ceil( w / size ), math.ceil( h / size )

		for i=1,x2 do
			for a=1,y2 do
				local _x = ( size * i ) - size
				local _y = ( size * a ) - size
				table.insert( self.draw, { x=_x, y=_y, w = size, h = size} )

			end

		end


	else

		table.insert( self.draw, { x=0, y=0, w=w, h=h })
	end
end
	for k,v in ipairs( self.draw ) do

	
			surface.SetDrawColor( Color(255,255,255,255))
			surface.SetMaterial( Material("DD/gui/empty_space.png") )
			surface.DrawTexturedRect( v.x, v.y, v.w, v.h )
			if( self.m_bhelp ) then
			surface.SetDrawColor(42,42,42,150)
			surface.DrawOutlinedRect( v.x, v.y , v.w , v.h  )
			end
	end

		surface.SetDrawColor( self.m_iColor )
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor(255,255,0,255)
		surface.DrawOutlinedRect( 0, 0, w, h )

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Think()

	if( self.m_imod == "mouse" ) then
	self:SetCursor( "arrow" )
	elseif(self.m_imod == "rect" ) then
	self:SetCursor( "crosshair" )
	elseif(self.m_imod == "poly" ) then
	self:SetCursor( "crosshair" )
	elseif(self.m_imod == "" ) then

	elseif(self.m_imod == "" ) then

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
local my = gui.MouseY() - (self:GetParent().y + self.y)
local mx = gui.MouseX() - (self:GetParent().x + self.x)
	if( mousecode == MOUSE_LEFT ) then

		if(self.m_imod == "poly" ) then

			if( #self.buff < 3 ) then
				table.insert( self.buff, { x = mx, y = my } )
				LocalPlayer():ChatPrint( #self.buff )
				
			end
			if( #self.buff == 3 ) then
				table.insert( self.layer, { typ = "poly", poly = table.Copy(self.buff), col = self:GetDrawColor() } )
				table.Empty( self.buff )
			end

		elseif( self.m_imod == "rect") then

		end

	end

end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )


	for k,v in ipairs( self.layer ) do

		if( v.typ == "poly" ) then
			surface.SetDrawColor( v.col )
			 surface.SetTexture(-1)
			surface.DrawPoly( v.poly )
		end
	end

	for k,v in ipairs( self.buff ) do

		surface.SetDrawColor(42,42,42,255)
		surface.DrawRect( v.x, v.y, 5, 5 )

	end

	if( #self.buff > 0 ) then
	local x,y = self.buff[#self.buff].x, self.buff[#self.buff].y
	local my = gui.MouseY() - (self:GetParent().y + self.y)
	local mx = gui.MouseX() - (self:GetParent().x + self.x)
		surface.SetDrawColor(0,0,0,255)
		surface.DrawLine( x, y , mx, my )

	end
end


derma.DefineControl( "DDDesigner", "A standard Button", PANEL, "DPanel" )