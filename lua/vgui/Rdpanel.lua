--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DPanel

--]]
local PANEL = {}

AccessorFunc( PANEL, "m_bBackground", 			"PaintBackground",	FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground", 			"DrawBackground", 	FORCE_BOOL )
AccessorFunc( PANEL, "m_bIsMenuComponent", 		"IsMenu", 			FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisableTabbing", 		"TabbingDisabled", 	FORCE_BOOL )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )


AccessorFunc( PANEL, "m_bDisabled", 			"Disabled" )
AccessorFunc( PANEL, "m_bgColor", 		"BackgroundColor" )

Derma_Hook( PANEL, "Paint", "Paint", "Panel" )
Derma_Hook( PANEL, "ApplySchemeSettings", "Scheme", "Panel" )


--[[---------------------------------------------------------
	
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetPaintBackground( true )
	
	-- This turns off the engine drawing
	self:SetPaintBackgroundEnabled( false )
	self:SetPaintBorderEnabled( false )

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
	Paint
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	elseif( self.build and !self.select ) then
		surface.SetDrawColor(160,160,160,255)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	else

	end

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
	
-----------------------------------------------------------]]
function PANEL:SetDisabled( bDisabled )

	self.m_bDisabled = bDisabled
	
	if ( bDisabled ) then
		self:SetAlpha( 75 )
		self:SetMouseInputEnabled( false )
	else
		self:SetAlpha( 255 )
		self:SetMouseInputEnabled( true )
	end

end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()


	
if( self.select ) then

else

end

	--LocalPlayer():ChatPrint(tostring(self.select))

	

			
end

--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )

self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
if( mousecode != MOUSE_LEFT ) then return end
	self.mouse = true
if(!self.build ) then
	return DLabel.OnMousePressed( self, mousecode )
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
	return DLabel.OnMouseReleased( self, mousecode )
else

	--self.select = false
	self.mouse = false
end
--	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )

end

--[[---------------------------------------------------------
	UpdateColours
-----------------------------------------------------------]]
function PANEL:UpdateColours()

end


derma.DefineControl( "RPanel", "", PANEL, "Panel" )