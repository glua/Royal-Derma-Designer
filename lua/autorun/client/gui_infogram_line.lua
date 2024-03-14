local PANEL = { }

--AccessorFunc( PANEL, "m_tline", 			"Line" )

AccessorFunc( PANEL, "m_color", 			"Color" )
AccessorFunc( PANEL, "m_balign", 			"Align", FORCE_BOOL )
AccessorFunc( PANEL, "m_tvalue", 			"Value" )
--[[---------------------------------------------------------
   Name: Init( void )
-----------------------------------------------------------]]
function PANEL:Init()

self:SetColor( Color( 255,255,255,255 ) )
self:SetAlign( false )
self:SetValue( { name = "", x = "", y = "" } )

end

--[[---------------------------------------------------------
   Name: OnMouseWheeled( )
-----------------------------------------------------------]]

function PANEL:OnMouseWheeled( scrollDelta )

end

--[[---------------------------------------------------------
   Name: Paint( number, number )
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor( 60, 60, 60, 255 )

	if( self.m_balign ) then
		surface.SetTexture( -1 )
		surface.DrawPoly( { { x = w * .125, y = h *.25 },{ x = w * .125 , y = h * .75 },{ x = 0, y = h * .5} } )
		surface.DrawRect( w * .125,0, w, h )
	else
		surface.SetTexture( -1 )
		surface.DrawPoly( { { x = w * .87, y = h * .25}, {x = w, y = h * .5 }, { x = w * .87, y = h * .75 } } )
		surface.DrawRect( 0 ,0, w * .875, h )

	end

	draw.SimpleText( self.m_tvalue.name, "DermaDefault", w * .875 * .5, h * .25, Color(255,255,255,255), 1, 1 )
	draw.SimpleText(  "( " .. self.m_tvalue.x .. " | " .. self.m_tvalue.y .. " )", "DermaDefault", w * .875 * .5 , h * .75, Color(255,255,255,255), 1, 1 )

end

--[[---------------------------------------------------------
   Name: PaintOver( number, number )
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

end

--[[---------------------------------------------------------
   Name: Think( void )
-----------------------------------------------------------]]
function PANEL:Think( )

end

--[[---------------------------------------------------------
   Name: PerformLayout( number, number )
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

end

derma.DefineControl( "info_nodebox", "", PANEL, "DPanel" )

local PANEL = { }

--AccessorFunc( PANEL, "m_tline", 			"Line" )

AccessorFunc( PANEL, "m_color", 			"Color" )
AccessorFunc( PANEL, "m_tvalue", 			"Value" )
--[[---------------------------------------------------------
   Name: Init( void )
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetColor( Color( 255,255,255,255 ) )
	self:SetValue( { name = "", x = 0, y = 0 } )
	self.side = false

end

--[[---------------------------------------------------------
   Name: OnMouseWheeled( )
-----------------------------------------------------------]]

function PANEL:OnMouseWheeled( scrollDelta )

end

--[[---------------------------------------------------------
   Name: Paint( number, number )
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

			surface.SetDrawColor( self.m_color )
			surface.SetMaterial( Material("dd/gui/axis_out.png", "noclamp smooth") )
			surface.DrawTexturedRect( 0,0,w,h)

			surface.SetDrawColor( Color( 42,42,42,255 ) )
			surface.SetMaterial( Material("dd/gui/axis_inner.png", "noclamp smooth") )
			surface.DrawTexturedRect( 0,0,w,h)
end

--[[---------------------------------------------------------
   Name: PaintOver( number, number )
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

end

--[[---------------------------------------------------------
   Name: Think( void )
-----------------------------------------------------------]]
function PANEL:Think( )

end

--[[---------------------------------------------------------
   Name: PerformLayout( number, number )
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	self.x = self.x - w * .5
	self.y = self.y - h * .5

end

derma.DefineControl( "info_node", "", PANEL, "DPanel" )


local PANEL = { }

AccessorFunc( PANEL, "m_tline", 			"Line" )
AccessorFunc( PANEL, "m_imax", 			"MaxX" )
AccessorFunc( PANEL, "m_imay", 			"MaxY" )


function TestRect( x, y, x1, y1, w )

	for i = 1, w do

	surface.DrawLine( x - w*.5 + i, y, x1 - w*.5 + i, y1 )

	end

end

--[[---------------------------------------------------------
   Name: Init( void )
-----------------------------------------------------------]]
function PANEL:Init()

	self.test = { name = "peter", color = Color( 255,0,0,255 ), pos = { 4500, 5000 } }
	self:SetMaxX( 10 )
	self:SetMaxY( 30 )
	self:SetLine( {} )
	self.nodes = {}
	self.buttons = {}
	self.init = 0
	self.side = false
	
	self.leftboard = vgui.Create( "info_nodebox", self )
	self.leftboard:SetAlign( false )

	self.leftboard:SetVisible( false ) 
	self.leftboard:SetZPos( 10 )

end

--[[---------------------------------------------------------
   Name: AddLine( )
   { name, color, pos = { x, y } }
-----------------------------------------------------------]]
function PANEL:AddLine( name, t )

	if( !self.m_tline[name] ) then
		self.m_tline[name] = {}
		
		self.buttons[#self.buttons+1] = vgui.Create( "DButton", self )
		self.buttons[#self.buttons]:SetText( name )
		self.buttons[#self.buttons].Paint = function( self, w, h )

			surface.SetDrawColor( t.color )
			surface.DrawRect( 0, 0, w, h )

		end
	end
	if( !self.nodes[name] ) then
		self.nodes[name] = {}
	end
	table.insert( self.m_tline[name], t ) 
	if( #self.m_tline[name] > 0 ) then

		if( self.m_imax < t.pos[1] ) then
			self.m_imax = t.pos[1] + t.pos[1]  
		end
		if( self.m_imay < t.pos[2] ) then
			self.m_imay = t.pos[2] + t.pos[2] 
		end

	end

	self.nodes[name][#self.nodes[name]+1] = vgui.Create( "info_node", self )

end

--[[---------------------------------------------------------
   Name: OnMouseWheeled( )
-----------------------------------------------------------]]
function PANEL:OnMouseWheeled( scrollDelta )

end

--[[---------------------------------------------------------
   Name: Paint( number, number )
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	local w = w * .8
	local h = h * .75

	local x_part = ( ( self:GetMaxX( ) * .1 ) / self:GetMaxX( )  ) * w
	local y_part = ( ( self:GetMaxY( ) * .1 ) / self:GetMaxY( )  ) * h

	for x = 0,9 do
	--print( x .. " " .. x * x_part .. " " )
		surface.SetDrawColor( 200,200,200,255)
		surface.DrawLine( x * x_part, 0, x * x_part, h )
		draw.SimpleText( x * self:GetMaxX( ) * .1   , "DermaDefault",  x * x_part, h, Color(255,255,255,255), 0, 0 )
	end

	for y = 0,9 do

		surface.SetDrawColor( 200,200,200,255)
		surface.DrawLine( 0, y * y_part, w, y * y_part )
		draw.SimpleText( (10-y) * self:GetMaxY( ) * .1   , "DermaDefault", 0, y * y_part, Color(255,255,255,255), 0, 0 )
	end
	--self.m_tline[name]
	for a,b in ipairs( table.GetKeys( self.m_tline ) ) do
		for k,v in ipairs( self.m_tline[b] ) do

			surface.SetDrawColor( v.color )
			if( k > 1 ) then
				local x = self.m_tline[b][k-1].pos[1]
				local y = self.m_tline[b][k-1].pos[2]
				local x1 = self.m_tline[b][k].pos[1]
				local y1 = self.m_tline[b][k].pos[2]
			--	print( b .. ": " .. ( w / self.m_imax ) * x .. " " ..  h - ( ( h / self.m_imay ) * y ) .. " " .. ( w / self.m_imax ) * x1  .. " " .. h -( ( h / self.m_imay ) * y1 ) .. "")
				TestRect(  ( w / self.m_imax ) * x, h - ( ( h / self.m_imay ) * y ) , ( w / self.m_imax ) * x1,  h -( ( h / self.m_imay ) * y1 ) , 3)
			end

		end
	end
	surface.SetDrawColor( 0,200,200,255)
	surface.DrawOutlinedRect( 0,0,w,h )

end

--[[---------------------------------------------------------
   Name: PaintOver( number, number )
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )
local w = w * .8
local h = h * .75

local x,y = self:LocalCursorPos()
	--draw.SimpleText( "X: " .. x .. " Y: " .. math.Round(h - y) , "DermaDefault", x + 50, y, Color(255,255,255,255), 0, 0 )
end

--[[---------------------------------------------------------
   Name: Think( void )
-----------------------------------------------------------]]
function PANEL:Think( )

local w = self:GetWide() * .8
local h = self:GetTall() * .75

local f = false
for a,b in ipairs( table.GetKeys( self.m_tline ) ) do
	for k,v in ipairs( self.nodes[b] ) do

		if( v:IsHovered()  ) then
	
			local x,y = self:LocalCursorPos()

				f = true
				if(  v.x - self.leftboard:GetWide() < 0 ) then
					self.leftboard:SetAlign( true )
					self.leftboard:SetPos( v.x + v:GetWide(), v.y - self.leftboard:GetTall() * .5 + v:GetTall() * .5 ) 
				else
					self.leftboard:SetAlign( false )
					self.leftboard:SetPos( v.x - self.leftboard:GetWide(), v.y - self.leftboard:GetTall() * .5 + v:GetTall() * .5 ) 
				end
					self.leftboard:SetValue( v:GetValue() )
		end

end
	end

		if( f ) then
			self.leftboard:SetVisible( true )
		else
			self.leftboard:SetVisible( false )
		end


end

--[[---------------------------------------------------------
   Name: PerformLayout( number, number )
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	if( self.init < 1 ) then
		local w = w * .8
	local h = h * .75
	for key,name in ipairs( table.GetKeys( self.m_tline ) ) do
		for a,node in ipairs( self.m_tline[name] ) do

			for k,v in ipairs( self.nodes[name] ) do
			local x = self.m_tline[name][k].pos[1]
			local y = self.m_tline[name][k].pos[2]
			v:SetPos(  ( w / self.m_imax ) * x, h - ( ( h / self.m_imay ) * y ) )
			v:SetSize( 10,10 )
			v:SetColor( node.color )
			v:SetValue( { name = k, x = x, y = y } )
			end
		end
		self.init = self.init + 1
	end
	end
	
	for k,v in ipairs( self.buttons ) do

		v:SetPos(-100 + (k * 100) + 5, self:GetTall() *.8) 
		v:SetSize(100,25)


	end

	self.leftboard:SetSize( 100,40 )

end

derma.DefineControl( "Info_line", "", PANEL, "DPanel" )
