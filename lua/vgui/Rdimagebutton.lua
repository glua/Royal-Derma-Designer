--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DImageButton

--]]

PANEL = {}
AccessorFunc( PANEL, "m_bStretchToFit", 			"StretchToFit" )
AccessorFunc( PANEL, "m_bSizable", 				"Sizable", 			FORCE_BOOL )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self:SetDrawBackground( false )
	self:SetDrawBorder( false )
	self:SetStretchToFit( true )

	self:SetCursor( "hand" )
	self.m_Image = vgui.Create( "RImage", self )
	self.m_Image:SetMouseInputEnabled( true )

	self:SetText( "" )
	
	self:SetColor( Color( 255, 255, 255, 255 ) )
				// add
	// add

	self.m_Image.Parent = self								// set DTextChange parent and modify it
	self.m_Image.OnMousePressed = function(self, mousecode ) self.Parent:OnMousePressed( mousecode ) end
	self.m_Image.OnMouseReleased = function(self, mousecode ) self.Parent:OnMouseReleased( mousecode ) end
	self:SetDraggable( true )
	self:SetMouseInputEnabled( true )
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

--
-- SetImageVisible
-- Hide the button's image
--
function PANEL:SetImageVisible( bBool )

	self.m_Image:SetVisible( bBool )

end


--[[---------------------------------------------------------
	SetImage
-----------------------------------------------------------]]
function PANEL:SetImage( strImage, strBackup )

	self.m_Image:SetImage( strImage, strBackup )

end

PANEL.SetIcon = PANEL.SetImage

--[[---------------------------------------------------------
	SetColor
-----------------------------------------------------------]]
function PANEL:SetColor( col )

	self.m_Image:SetImageColor( col )
	self.ImageColor = col

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
	GetImage
-----------------------------------------------------------]]
function PANEL:GetImage()

	return self.m_Image:GetImage()

end

--[[---------------------------------------------------------
	SetKeepAspect
-----------------------------------------------------------]]
function PANEL:SetKeepAspect( bKeep )

	self.m_Image:SetKeepAspect( bKeep )

end

-- This makes it compatible with the older ImageButton
PANEL.SetMaterial = PANEL.SetImage


--[[---------------------------------------------------------
	SizeToContents
-----------------------------------------------------------]]
function PANEL:SizeToContents( )

	self.m_Image:SizeToContents()
	self:SetSize( self.m_Image:GetWide(), self.m_Image:GetTall() )

end

--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )

if( mousecode != MOUSE_LEFT ) then return end
self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
--if( mousecode != MOUSE_LEFT ) then return end

	self.mouse = true
if(!self.build ) then
		--DButton.OnMousePressed( self, mousecode )

	
	if ( self.m_bStretchToFit ) then
			
		self.m_Image:SetPos( 2, 2 )
		self.m_Image:SetSize( self:GetWide() - 4, self:GetTall() - 4 )
		
	else
	
		self.m_Image:SizeToContents()
		self.m_Image:SetSize( self.m_Image:GetWide() * 0.8, self.m_Image:GetTall() * 0.8 )
		self.m_Image:Center()
		
	end
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

if(!self.build ) then

		DButton.OnMouseReleased( self, mousecode )

	if ( self.m_bStretchToFit ) then
			
		self.m_Image:SetPos( 0, 0 )
		self.m_Image:SetSize( self:GetSize() )
		
	else
	
		self.m_Image:SizeToContents()
		self.m_Image:Center()
		
	end
else



end

	self.mouse = false
	self.Sizing = nil
	self:MouseCapture( false )


end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:PerformLayout()

	if ( self.m_bStretchToFit ) then
			
		self.m_Image:SetPos( 0, 0 )
		self.m_Image:SetSize( self:GetSize() )
		
	else
	
		self.m_Image:SizeToContents()
		self.m_Image:Center()
		
	end

end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:SetDisabled( bDisabled )

	DButton.SetDisabled( self, bDisabled )

	if ( bDisabled ) then
		self.m_Image:SetAlpha( self.ImageColor.a * 0.4 ) 
	else
		self.m_Image:SetAlpha( self.ImageColor.a ) 
	end

end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:SetOnViewMaterial( MatName, Backup )

	self.m_Image:SetOnViewMaterial( MatName, Backup )

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetImage( "brick/brick_model" )
		ctrl:SetSize( 200, 200 )
		
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RImageButton", "A button which uses an image instead of text", PANEL, "DButton" )