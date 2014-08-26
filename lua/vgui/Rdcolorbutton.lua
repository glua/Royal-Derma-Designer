--[[
	 _
	( )
   _| |   __   _ __   ___ ___     _ _
 /´_` | /´__`\( '__)/´ _ ` _ `\ /´_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_)

	DColorButton
--]]

local matGrid = Material( "gui/bg-lines.png", "nocull" )

local PANEL = {}

AccessorFunc( PANEL, "m_bBorder", "DrawBorder", FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", "Disabled", FORCE_BOOL )
AccessorFunc( PANEL, "m_bSelected", "Selected", FORCE_BOOL )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )

AccessorFunc( PANEL, "m_Color", "Color" )
AccessorFunc( PANEL, "m_PanelID", "ID" )

--[[---------------------------------------------------------
	Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetSize( 10, 10 )
	self:SetMouseInputEnabled( true )
	self:SetText( "" )
	self:SetCursor( "hand" )
	self:SetZPos( 0 )

	self:SetColor( Color( 255, 0, 255 ) )
	self.PosX, self.PosY, self.SizeX, self.SizeY = self:GetBounds()

		// add
	self:SetDraggable( true )
	self.select = false
	self.build = false
	self.Dragging = {}
	self.mouse = false
	self.ToleranceHorizontal = false
	self.ToleranceVertical = false
	self.mpos = {x=0,y=0}
	self.sizebutton = {}
	self:SetMinWidth(25)
	self:SetMinHeight(25)

	for i=1,3 do
		self.sizebutton[i] = vgui.Create("DDSButton",self)
	    self.sizebutton[i]:SetVisible(false)
		
	end

end


--[[---------------------------------------------------------
	Buildmode
-----------------------------------------------------------]]
function PANEL:Buildmode( b )

	self.build = b

end

--[[---------------------------------------------------------
	select
-----------------------------------------------------------]]
function PANEL:Select( b )

	self.select = b


end
--[[---------------------------------------------------------
	IsSelected
-----------------------------------------------------------]]
function PANEL:IsSelected()

	return self.select

end

--[[---------------------------------------------------------
	SetTolerance
-----------------------------------------------------------]]
function PANEL:SetHorizontalTolerance( bool )

self.ToleranceHorizontal = bool

end

function PANEL:SetVerticalTolerance( bool ) 

self.ToleranceVertical = bool


end

--[[---------------------------------------------------------
	Think 
-----------------------------------------------------------]]
function PANEL:Think()

	local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	if( self.select and self.build ) then
		for i=1,3 do
				
			self.sizebutton[i]:SetSize(5,5)
			
		    if( i == 1 ) then
			self.sizebutton[i]:SetPos(self:GetWide()-5,self:GetTall() * 0.5 - 2.5)
			self.sizebutton[i]:SetType("sizewe") -- <=> sizewe sizeall


			elseif( i == 2 ) then
			self.sizebutton[i]:SetPos(self:GetWide() * 0.5 - 2.5,self:GetTall()-5)
			self.sizebutton[i]:SetType("sizens") -- |

			elseif( i == 3 ) then
			self.sizebutton[i]:SetPos(self:GetWide()-5,self:GetTall()-5)
			self.sizebutton[i]:SetType("sizenwse") -- \

			end
			
			self.sizebutton[i]:SetVisible(true)
	
		end
	else
		for i=1,3 do
		self.sizebutton[i]:SetVisible(false)
		end
	end
	if ( self.select and self.build  and self.mouse ) then

		self:SetCursor("sizeall")
		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]
		if( self.ToleranceVertical ) then
			if( self.mpos.x < mousex - self.Dragging[1] and mousex -  self.Dragging[1] < self.mpos.x + 30 ) then -- nach rechts
				self.y = y
				return
			elseif( self.mpos.x > mousex - self.Dragging[1] and mousex -  self.Dragging[1] > self.mpos.x - 30 ) then -- nach links
				self.y = y
				return
			end
		end

		if( self.ToleranceHorizontal ) then
			if( self.mpos.y < mousey - self.Dragging[2] and mousey - self.Dragging[2] < self.mpos.y + self:GetTall() * 0.5 ) then
				self.x = x
				return
			elseif( self.mpos.y > mousey - self.Dragging[2] and mousey - self.Dragging[2] > self.mpos.y - self:GetTall() * 0.5) then
				self.x = x
				return
			end
		end
			self:SetPos( x, y )

	else

	self:SetCursor( "arrow" )
	end

end

--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )
self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
if( mousecode != MOUSE_LEFT ) then return end
	self.mouse = true
if(!self.build ) then

else
self.select = true
self.mpos.x = self.x
self.mpos.y = self.y
	if ( self.m_bSizable and self.select ) then
	
		if ( gui.MouseX() > (self.x + self:GetWide() - 5) &&
			gui.MouseY() > (self.y + self:GetTall() - 5) ) then			
	
			self.Sizing = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }
			self:MouseCapture( true )
			return
		end
		
	end
end

end

--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )
if( mousecode != MOUSE_LEFT ) then return end
if(!self.build ) then

else

	self.mouse = false
end
	self.Sizing = nil
	self:MouseCapture( false )

end

--[[---------------------------------------------------------
	Name: IsDown
-----------------------------------------------------------]]
function PANEL:IsDown()

	return self.Depressed

end

--[[---------------------------------------------------------
	Name: SetColor
-----------------------------------------------------------]]
function PANEL:SetColor( color )

	local colorStr = "R: "..color.r.."\nG: "..color.g.."\nB: "..color.b.."\nA: "..color.a

	self:SetToolTip( colorStr )
	self.m_Color = color

end

--[[---------------------------------------------------------
	Name: Paint
-----------------------------------------------------------]]
function PANEL:Paint( w, h )
	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	else
	if ( self.m_Color.a < 255 ) then -- Grid for Alpha

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( matGrid )

		local size = math.max( 128, math.max( w, h ) )
		local x, y = w / 2 - size / 2, h / 2 - size / 2 
		surface.DrawTexturedRect( x, y , size, size )

	end

	surface.SetDrawColor( self.m_Color )
	self:DrawFilledRect()

	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawRect( 0, 0, w, 1 )
	surface.DrawRect( 0, 0, 1, h )

	return false
	end
end

--[[---------------------------------------------------------
	Name: SetDisabled
-----------------------------------------------------------]]
function PANEL:SetDisabled( bDisabled )

	self.m_bDisabled = bDisabled	
	self:InvalidateLayout()

end

--[[---------------------------------------------------------
	Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetSize( 64, 64 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RColorButton", "A Color Button", PANEL, "RLabel" )