
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
	self.out = {}
	self.circle = {}
	self.orect = {}
	self.poly4 = {}
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
   Name: Think
-----------------------------------------------------------]]
function PANEL:Think()

	if( self.m_imod == "mouse" ) then
		self:SetCursor( "arrow" )
	elseif(self.m_imod == "rect" ) then
		self:SetCursor( "crosshair" )
	elseif(self.m_imod == "poly" ) then
		self:SetCursor( "arrow" )
	elseif(self.m_imod == "4poly" ) then
		self:SetCursor( "arrow" )
	elseif(self.m_imod == "orect" ) then
		self:SetCursor( "crosshair" )
	elseif(self.m_imod == "circle" ) then
		self:SetCursor( "crosshair" )
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

		if( #self.out < 2 ) then

				table.insert( self.out, { x = mx, y = my } )
			if( #self.out == 2 ) then
				if( self.out[2].x < self.out[1].x ) then

				local w = self.out[2].x - self.out[1].x
				local h = self.out[1].y - self.out[2].y
				table.insert( self.layer, { typ = "rect", x=self.out[2].x, y = self.out[1].y, w = w, h = h, col = self:GetDrawColor() } )
				elseif( self.out[2].y < self.out[1].y ) then
				local h = self.out[2].y - self.out[1].y
				local w = self.out[1].x - self.out[2].x
				table.insert( self.layer, {typ = "rect", x=self.out[1].x, y = self.out[2].y, w = w, h = h, col = self:GetDrawColor() } )
				else
				local w = self.out[2].x - self.out[1].x
				local h = self.out[2].y - self.out[1].y
				table.insert( self.layer, { typ = "rect", x=self.out[1].x, y = self.out[1].y, w = w, h = h, col = self:GetDrawColor() } ) 
				end
				PrintTable( self.layer )
				table.Empty( self.out )
			end
		end
		elseif( self.m_imod == "orect" ) then

			if( #self.orect < 2 ) then

				table.insert( self.orect, { x = mx, y = my } )

			end

			if( #self.orect == 2 ) then

				local w = self.orect[2].x - self.orect[1].x
				local h = self.orect[2].y - self.orect[1].y
				table.insert( self.layer, { typ = "orect", x=self.orect[1].x, y = self.orect[1].y, w = w, h = h, col = self:GetDrawColor() } ) 
				table.Empty( self.orect )
			end

		elseif( self.m_imod == "circle" ) then
			if( #self.circle < 2 ) then

				table.insert( self.circle, { x = mx, y = my } )

			end

			if( #self.circle == 2 ) then

				local radius = math.Distance( self.circle[1].x, self.circle[1].y, self.circle[2].x, self.circle[2].y )
				table.insert( self.layer, { typ = "circle", x=self.circle[1].x, y = self.circle[1].y, w = radius, col = self:GetDrawColor() } ) 
				table.Empty( self.circle )
			end

		elseif( self.m_imod == "4poly" ) then

			if( #self.poly4 < 4 ) then

				table.insert( self.poly4, { x = mx, y = my } )

			end

			if( #self.poly4 == 4 ) then

				table.insert( self.layer, { typ = "4poly", poly = table.Copy(self.poly4), col = self:GetDrawColor() } )
				table.Empty( self.poly4 )

			end


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
local my = gui.MouseY() - (self:GetParent().y + self.y)
local mx = gui.MouseX() - (self:GetParent().x + self.x)
local mx1,my1 = self:ScreenToLocal( gui.MouseX(), gui.MouseY() )
	for k,v in ipairs( self.layer ) do

		if( v.typ == "poly" ) then
			surface.SetDrawColor( v.col )
			surface.SetTexture(-1)
			surface.DrawPoly( v.poly )
		elseif( v.typ == "rect" ) then
			surface.SetDrawColor( v.col) -- changeable after drawn must be changed add it to table
			surface.DrawRect(v.x,v.y,v.w,v.h)
		elseif( v.typ == "orect" ) then
			surface.SetDrawColor( v.col) -- changeable after drawn must be changed add it to table
			surface.DrawOutlinedRect(v.x,v.y,v.w,v.h)
		elseif( v.typ == "circle" ) then
			surface.DrawCircle( v.x, v.y, v.w, v.col )
		elseif( v.typ == "4poly" ) then
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
		surface.SetDrawColor(0,0,0,255)
		surface.DrawLine( x, y , mx, my )
	end

	for k,v in ipairs( self.poly4 ) do

		surface.SetDrawColor(42,42,42,255)
		surface.DrawRect( v.x, v.y, 5, 5 )

	end

	if( #self.poly4 > 0 ) then
		local x,y = self.poly4[#self.poly4].x, self.poly4[#self.poly4].y
		surface.SetDrawColor(0,0,0,255)
		surface.DrawLine( x, y , mx, my )
	end

	if( #self.orect == 1 ) then
		surface.SetDrawColor( Color( 200, 200, 200, 255 ) ) -- changeable after drawn must be changed add it to table
		surface.DrawOutlinedRect(self.orect[1].x,self.orect[1].y,mx1-self.orect[1].x,my1-self.orect[1].y)
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(self.orect[1].x,self.orect[1].y,2,2)
	end

	if( #self.circle == 1 ) then
		local rad = math.Distance( self.circle[1].x, self.circle[1].y, mx, my )
		surface.DrawCircle( self.circle[1].x, self.circle[1].y, rad, Color( 200, 200, 200, 255 ) )
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(self.circle[1].x,self.circle[1].y,2,2)
	end

	if( #self.out == 1 ) then
		surface.SetDrawColor( Color( 200, 200, 200, 255 ) ) -- changeable after drawn must be changed add it to table
		surface.DrawRect(self.out[1].x,self.out[1].y,mx1-self.out[1].x,my1-self.out[1].y)
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(self.out[1].x,self.out[1].y,2,2)
	end
end


derma.DefineControl( "DDDesigner", "A standard Button", PANEL, "DPanel" )