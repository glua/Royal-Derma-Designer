
PANEL = {}
AccessorFunc( PANEL, "mb_type", 		"Type" )
AccessorFunc( PANEL, "mb_pressed", 		"Pressed",	FORCE_BOOL )
--GetAligin
--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetType( "hand" )
	self.Sizing = {}
	self.test1 = 0
	self.test2 = 0
	self.Dragging = {}
	self.test3 = 0
	self.test4 = 0
	self.test5 = 0
end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h )


end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )
	--LocalPlayer():ChatPrint("X: " .. self.test1 .. " Y: " .. self.test2 .. "" )
	self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
	self:SetPressed( true )
	self:SetCursor( tostring( self:GetType() ) )
	self.Sizing = { gui.MouseX() - self:GetParent():GetWide(), gui.MouseY() - self:GetParent():GetTall() }
end

--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )
	self.Dragging = nil
	self:SetPressed( false )
	self.Sizing = nil
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Think()
if( !input.IsMouseDown( MOUSE_LEFT ) ) then self:SetPressed( false ) end
	local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	local x1 = mousex - self:GetParent():GetParent().x

	if( self.Hovered ) then

		self:SetCursor( tostring( self:GetType() ) )

	else
		if( self:GetPressed()  and !input.IsMouseDown( MOUSE_LEFT) ) then
			self:SetPressed(false)
			
		else
			
		end
	end
	
	if( self:GetPressed() ) then
		local x = mousex - self.Sizing[1]
		local y = mousey - self.Sizing[2]
		if( y < self:GetParent():GetMinHeight() ) then  y = self:GetParent():GetMinHeight() end
		if( x < self:GetParent():GetMinWidth() ) then x = self:GetParent():GetMinWidth()  end
		if( self:GetType() == "sizens" or self:GetType() == "sizewe" ) then
				if( self:GetType() == "sizens" ) then -- |
					self:GetParent():SetTall( y )
				else  -- <=>
					self:GetParent():SetWide( x )
				end
		else
			self:GetParent():SetWide(x)
			self:GetParent():SetTall(y)			


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
function PaintOver( w, h )


end


derma.DefineControl( "DDSButton", "A standard Button", PANEL, "DPanel" )


