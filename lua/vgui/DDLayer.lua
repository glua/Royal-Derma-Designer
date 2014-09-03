
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
		local t = {}
			local xr,yr = tab.data.x / tab.parent:GetWide(), tab.data.y / tab.parent:GetTall()
			table.insert( t, { x = (xr * (w)) + self:GetWide() / 12   , y = yr * (self:GetTall()-4) } )
			local width, height = tab.data.w / tab.parent:GetWide() * w, tab.data.h / tab.parent:GetTall() * h
			table.insert( self.draw, { typ = tab.typ, x = t[1].x, y = t[1].y, w = width, h = height } )

	elseif( tab.typ == "orect" ) then
		local t = {}
	
			local xr,yr = tab.data.x / tab.parent:GetWide(), tab.data.y / tab.parent:GetTall()
			table.insert( t, { x = (xr * (w)) + self:GetWide() / 12   , y = yr * (self:GetTall()-4) } )
			local width, height = tab.data.w / tab.parent:GetWide() * w, tab.data.h / tab.parent:GetTall() * h
			table.insert( self.draw, { typ = tab.typ, x = t[1].x, y = t[1].y, w = width, h = height } )
	elseif( tab.typ == "circle" ) then
		local t = {}
		
			local xr,yr = tab.data.x  / tab.parent:GetWide(), tab.data.y / tab.parent:GetTall()
			local rad = (tab.data.w / tab.parent:GetWide() ) * w
			table.insert( t, { x = (xr * (w)) + self:GetWide() / 12   , y = yr * (self:GetTall()-4) } )
		
		table.insert( self.draw, { typ = tab.typ, x = t[1].x, y = t[1].y, w = rad } )

	elseif( tab.typ == "4poly" ) then
		local t = {}
		for k,v in ipairs( tab.data ) do
			local xr,yr = v.x  / tab.parent:GetWide(), v.y / tab.parent:GetTall()
			table.insert( t, { x = (xr * (w)) + self:GetWide() / 12   , y = yr * (self:GetTall()-4) } )

		end
		table.insert( self.draw, { typ = tab.typ, data = table.Copy(t) } )

	elseif( tab.typ == "texture" ) then
		local t = {}
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

	for k,v in ipairs( self.draw ) do

	if( v.typ == "poly" ) then

		surface.SetDrawColor( 225,0,0,255 )
		surface.SetTexture(-1)
		surface.DrawPoly( v.data )
	elseif(v.typ == "rect" ) then
		surface.SetDrawColor( Color( 255, 0, 0, 255 )  ) -- changeable after drawn must be changed add it to table
		surface.DrawRect(v.x,v.y,v.w,v.h)
	elseif( v.typ == "orect" ) then
		surface.SetDrawColor( Color( 255, 0, 0, 255 )  ) -- changeable after drawn must be changed add it to table
		surface.DrawOutlinedRect(v.x,v.y,v.w,v.h)
	elseif( v.typ == "circle" ) then
		surface.DrawCircle( v.x, v.y, v.w, Color( 255, 0, 0, 255 ) )
	elseif( v.typ == "4poly" ) then
		surface.SetDrawColor( 225,0,0,255 )
		surface.SetTexture(-1)
		surface.DrawPoly( v.data )
	elseif( v.typ == "texture" ) then

	end

	end

	// overlay to make sure correct the bounds
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PaintOver( w, h )



end


derma.DefineControl( "DDLayer", "A standard Button", PANEL, "DPanel" )