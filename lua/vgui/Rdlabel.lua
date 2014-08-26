--[[   _                                
	( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DLabel
--]]

PANEL = {}

AccessorFunc( PANEL, "m_bIsMenuComponent", 		"IsMenu", 			FORCE_BOOL )

AccessorFunc( PANEL, "m_colText", 				"TextColor" )
AccessorFunc( PANEL, "m_colTextStyle", 			"TextStyleColor" )
AccessorFunc( PANEL, "m_FontName", 				"Font" )
AccessorFunc( PANEL, "m_bAutoStretchVertical", 	"AutoStretchVertical", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 			"Disabled", 				FORCE_BOOL )
AccessorFunc( PANEL, "m_bDoubleClicking", 		"DoubleClickingEnabled", 	FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground", 			"PaintBackground",			FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground", 			"DrawBackground", 			FORCE_BOOL )
AccessorFunc( PANEL, "m_bIsToggle", 			"IsToggle", 				FORCE_BOOL )
AccessorFunc( PANEL, "m_bToggle", 				"Toggle", 					FORCE_BOOL )
AccessorFunc( PANEL, "m_bBright", 				"Bright", 					FORCE_BOOL )
AccessorFunc( PANEL, "m_bDark", 				"Dark", 					FORCE_BOOL )
AccessorFunc( PANEL, "m_bHighlight", 			"Highlight", 				FORCE_BOOL )

AccessorFunc( PANEL, "m_bSizable", 				"Sizable", 			FORCE_BOOL )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )


--[[---------------------------------------------------------
	Init
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetIsToggle( false )
	self:SetToggle( false )
	self:SetDisabled( false );
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( false )
	self:SetDoubleClickingEnabled( true )

	-- Nicer default height
	self:SetTall( 20 )
	
	-- This turns off the engine drawing
	self:SetPaintBackgroundEnabled( false )
	self:SetPaintBorderEnabled( false )
	
	self:SetFont( "DermaDefault" )	

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


function PANEL:Paint( w, h )

	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	else

	end

end



function PANEL:SetFont( strFont )

	self.m_FontName = strFont
	self:SetFontInternal( self.m_FontName )	
	self:ApplySchemeSettings()

end

function PANEL:ApplySchemeSettings()

	self:SetFontInternal( self.m_FontName )
	self:UpdateColours( self:GetSkin() );
	
	local col = self.m_colTextStyle
	if ( self.m_colText ) then col = self.m_colText end
	
	self:SetFGColor( col.r, col.g, col.b, col.a )

end

function PANEL:PerformLayout()

	self:ApplySchemeSettings()
	
	if ( self.m_bAutoStretchVertical ) then
		self:SizeToContentsY()
	end

end


PANEL.SetColor = PANEL.SetTextColor

--[[---------------------------------------------------------
	SetColor
-----------------------------------------------------------]]
function PANEL:GetColor()

	return self.m_colTextStyle

end


--[[---------------------------------------------------------
	Exited
-----------------------------------------------------------]]
function PANEL:OnCursorEntered()

	self:InvalidateLayout( true )
	
end

--[[---------------------------------------------------------
	Entered
-----------------------------------------------------------]]
function PANEL:OnCursorExited()

	self:InvalidateLayout( true )
	
end



function PANEL:OnDepressed()

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


	self:MouseCapture( false )
	
	if ( self:GetDisabled() ) then return end
	if ( !self.Depressed ) then return end
	
	self.Depressed = nil
	self:OnReleased();
	self:InvalidateLayout();
	--
	-- If we were being dragged then don't do the default behaviour!
	--
	if ( self:DragMouseRelease( mousecode ) ) then
		return
	end
	
	if ( self:IsSelectable() && mousecode == MOUSE_LEFT ) then
			
		local canvas = self:GetSelectionCanvas()
		if ( canvas ) then
			canvas:UnselectAll()
		end
		
	end
	
	if ( !self.Hovered ) then return end

	--
	-- For the purposes of these callbacks we want to 
	-- keep depressed true. This helps us out in controls
	-- like the checkbox in the properties dialog. Because
	-- the properties dialog will only manualloy change the value
	-- if IsEditing() is true - and the only way to work out if
	-- a label/button based control is editing is when it's depressed.
	--
	self.Depressed = true

	if ( mousecode == MOUSE_RIGHT ) then
		self:DoRightClick()
	end
	
	if ( mousecode == MOUSE_LEFT ) then	
		self:DoClickInternal()
		self:DoClick()
	end

	if ( mousecode == MOUSE_MIDDLE ) then
		self:DoMiddleClick()
	end

	self.Depressed = nil

end

function PANEL:OnReleased()

end

--[[---------------------------------------------------------
	DoRightClick
-----------------------------------------------------------]]
function PANEL:DoRightClick()

end

--[[---------------------------------------------------------
	DoMiddleClick
-----------------------------------------------------------]]
function PANEL:DoMiddleClick()

end

--[[---------------------------------------------------------
	DoClick
-----------------------------------------------------------]]
function PANEL:DoClick()

	self:Toggle()

end

function PANEL:Toggle()

	if ( !self:GetIsToggle() ) then return end
	
	self.m_bToggle = !self.m_bToggle
	self:OnToggled( self.m_bToggle )

end

function PANEL:OnToggled( bool )

end


--[[---------------------------------------------------------
	DoClickInternal
-----------------------------------------------------------]]
function PANEL:DoClickInternal()

end

--[[---------------------------------------------------------
	DoDoubleClick
-----------------------------------------------------------]]
function PANEL:DoDoubleClick()

end

--[[---------------------------------------------------------
	DoDoubleClickInternal
-----------------------------------------------------------]]
function PANEL:DoDoubleClickInternal()
	
end

--[[---------------------------------------------------------
	UpdateColours
-----------------------------------------------------------]]
function PANEL:UpdateColours( skin )

	if ( self.m_bBright )		then return self:SetTextStyleColor( skin.Colours.Label.Bright ) end
	if ( self.m_bDark )			then return self:SetTextStyleColor( skin.Colours.Label.Dark ) end
	if ( self.m_bHighlight )	then return self:SetTextStyleColor( skin.Colours.Label.Highlight ) end

	return self:SetTextStyleColor( skin.Colours.Label.Default )

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetText( "This is a label example." )
		ctrl:SizeToContents()
		
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end


derma.DefineControl( "RLabel", "A Label", PANEL, "Label" )


--[[---------------------------------------------------------
   Name: Convenience Function
-----------------------------------------------------------]]
function Label( strText, parent )

	local lbl = vgui.Create( "RLabel", parent )
	lbl:SetText( strText )
	
	return lbl

end
