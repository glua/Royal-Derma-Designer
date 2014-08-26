--[[   _                                
	( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DButton
	
	Default Button

--]]

PANEL = {}

AccessorFunc( PANEL, "m_bBorder", 			"DrawBorder", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 		"Disabled", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_FontName", 			"Font" )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self:SetContentAlignment( 5 )
	
	--
	-- These are Lua side commands
	-- Defined above using AccessorFunc
	--
	self:SetDrawBorder( true )
	self:SetDrawBackground( true )
	
	--
	self:SetTall( 22 )
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )

	self:SetCursor( "hand" )
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
	IsDown
-----------------------------------------------------------]]
function PANEL:IsDown()

	return self.Depressed

end
--[[---------------------------------------------------------
	Think
-----------------------------------------------------------]]
function PANEL:Think()

local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	
	if ( self.select and self.build and self.mouse ) then
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
	SetImage
-----------------------------------------------------------]]
function PANEL:SetImage( img )

	if ( !img ) then
	
		if ( IsValid( self.m_Image ) ) then
			self.m_Image:Remove()
		end
	
		return
	end

	if ( !IsValid( self.m_Image ) ) then
		self.m_Image = vgui.Create( "RImage", self )
	end
	
	self.m_Image:SetImage( img )
	self.m_Image:SizeToContents()
	self:InvalidateLayout()

end

PANEL.SetIcon = PANEL.SetImage

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	
	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)

	else
	derma.SkinHook( "Paint", "Button", self, w-1, h-1 )
	end
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(0,0,w,h)

	--
	-- Draw the button text
	--
	return false

end

--[[---------------------------------------------------------
	UpdateColours
-----------------------------------------------------------]]
function PANEL:UpdateColours( skin )

	if ( self:GetDisabled() )						then return self:SetTextStyleColor( skin.Colours.Button.Disabled ) end
	if ( self.Depressed || self.m_bSelected )		then return self:SetTextStyleColor( skin.Colours.Button.Down ) end
	if ( self.Hovered )								then return self:SetTextStyleColor( skin.Colours.Button.Hover ) end

	return self:SetTextStyleColor( skin.Colours.Button.Normal )

end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()
		
	--
	-- If we have an image we have to place the image on the left
	-- and make the text align to the left, then set the inset
	-- so the text will be to the right of the icon.
	--
	if ( IsValid( self.m_Image ) ) then
			
		self.m_Image:SetPos( 4, (self:GetTall() - self.m_Image:GetTall()) * 0.5 )
		
		self:SetTextInset( self.m_Image:GetWide() + 16, 0 )
		
	end

	if( self.select ) then

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

	DLabel.PerformLayout( self )

end

--[[---------------------------------------------------------
	SetDisabled
-----------------------------------------------------------]]
function PANEL:SetDisabled( bDisabled )

	self.m_bDisabled = bDisabled	
	self:InvalidateLayout()

end

--[[---------------------------------------------------------
   Name: SetConsoleCommand
-----------------------------------------------------------]]
function PANEL:SetConsoleCommand( strName, strArgs )

	self.DoClick = function( self, val ) 
						RunConsoleCommand( strName, strArgs ) 
				   end

end


--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetText( "Example Button" )
		ctrl:SetWide( 200 )
	
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )

self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }


if(!self.build ) then
	return DLabel.OnMousePressed( self, mousecode )
else
if( mousecode != MOUSE_LEFT ) then return end
	self.mouse = true
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
if(!self.build ) then
	return DLabel.OnMouseReleased( self, mousecode )
else

	--self.select = false
	self.mouse = false
end
--	self.Dragging = nil
if( mousecode != MOUSE_LEFT ) then return end
	self.Sizing = nil
	self:MouseCapture( false )


end


local PANEL = derma.DefineControl( "RButton", "A standard Button", PANEL, "Label" )

PANEL = table.Copy( PANEL )

-- No example here!
PANEL.GenerateExample = nil

--[[---------------------------------------------------------
   Name: SetActionFunction
-----------------------------------------------------------]]
function PANEL:SetActionFunction( func )

	self.DoClick = function( self, val ) func( self, "Command", 0, 0 ) end

end

derma.DefineControl( "RButton", "Backwards Compatibility", PANEL, "RLabel" )