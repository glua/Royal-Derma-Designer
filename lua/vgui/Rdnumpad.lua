--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DNumPad
	
	A loverly multi-use numpad.

--]]

local KP_ENTER = 11
local KP_PERIOD = 10
local KP_PLUS = 12
local KP_MINUS = 13
local KP_STAR = 14
local KP_DIV = 15

local PANEL = {}

AccessorFunc( PANEL, "m_SelectedButton", 		"Selected" )
AccessorFunc( PANEL, "m_iSelectedNumber", 		"SelectedNumber" )
AccessorFunc( PANEL, "m_iPadding", 				"Padding" )
AccessorFunc( PANEL, "m_bButtonSize", 			"ButtonSize" )
AccessorFunc( PANEL, "m_bStickyKeys", 			"StickyKeys" )	-- Should keys stay selected when pressed? (like the spawn menu)
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )
Derma_Install_Convar_Functions( PANEL )

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self.Buttons = {}
	
	for i=0, 15 do
		self.Buttons[ i ] = vgui.Create( "RButton", self )
		self.Buttons[ i ]:SetText( i )
		self.Buttons[ i ].DoClick = function( btn ) self:ButtonPressed( btn, i ) end
	end

	self.Buttons[KP_ENTER]:SetText( "" )
	self.Buttons[KP_PERIOD]:SetText( "." )
	self.Buttons[KP_PLUS]:SetText( "+" )
	self.Buttons[KP_MINUS]:SetText( "-" )
	self.Buttons[KP_STAR]:SetText( "*" )
	self.Buttons[KP_DIV]:SetText( "/" )
		
	self.Buttons[0]:SetContentAlignment( 4 )
	self.Buttons[0]:SetTextInset( 6, 0 )
	
	self:SetStickyKeys( true )
	self:SetButtonSize( 17 )
	self:SetPadding( 4 )
	
	self:SetSelectedNumber( -1 )
	
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
   Name: ButtonPressed
-----------------------------------------------------------]]
function PANEL:ButtonPressed( btn, iNum ) 

	-- Toggle off
	if ( self.m_bStickyKeys && 
		 self.m_SelectedButton &&
		 self.m_SelectedButton == btn ) then
	
		self.m_SelectedButton:SetSelected( false )
		self:SetSelected( -1 )
		
	return end
	
	self:SetSelected( iNum )
	self:OnButtonPressed( iNum, btn )

end

--[[---------------------------------------------------------
   Name: SetSelected
-----------------------------------------------------------]]
function PANEL:SetSelected( iNum )

	local btn = self.Buttons[ iNum ]

	self:SetSelectedNumber( iNum )
	
	self:ConVarChanged( iNum )
	
	if ( self.m_SelectedButton ) then 
		self.m_SelectedButton:SetSelected( false )
	end
	
	self.m_SelectedButton = btn
	
	if ( btn && self.m_bStickyKeys ) then
		
		btn:SetSelected( true )
		
	end

end

--[[---------------------------------------------------------
   Name: OnButtonPressed
-----------------------------------------------------------]]
function PANEL:OnButtonPressed( iButtonNumber, pButton ) 

	-- Override this.

end


--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	local ButtonSize = self:GetButtonSize()
	local Padding = self:GetPadding()

	self:SetSize( ButtonSize * 4 + Padding * 2, ButtonSize * 5 + Padding * 2 )

	self.Buttons[ 0 ]:SetSize( ButtonSize * 2, ButtonSize )
	self.Buttons[ 0 ]:AlignBottom( Padding )
	self.Buttons[ 0 ]:AlignLeft( Padding )
		self.Buttons[KP_PERIOD]:CopyBounds( self.Buttons[0] )
		self.Buttons[KP_PERIOD]:SetSize( ButtonSize, ButtonSize )
		self.Buttons[KP_PERIOD]:MoveRightOf( self.Buttons[0] )
	
	self.Buttons[1]:SetSize( ButtonSize, ButtonSize )	
	self.Buttons[1]:AlignLeft( Padding )
	self.Buttons[1]:MoveAbove( self.Buttons[ 0 ] )
		self.Buttons[2]:CopyBounds( self.Buttons[1] )
		self.Buttons[2]:MoveRightOf( self.Buttons[1] )
			self.Buttons[3]:CopyBounds( self.Buttons[2] )
			self.Buttons[3]:MoveRightOf( self.Buttons[2] )
			
	self.Buttons[KP_ENTER]:SetSize( ButtonSize, ButtonSize*2 )
	self.Buttons[KP_ENTER]:AlignBottom( Padding )
	self.Buttons[KP_ENTER]:AlignRight( Padding )

	self.Buttons[KP_PLUS]:CopyBounds( self.Buttons[KP_ENTER] )
	self.Buttons[KP_PLUS]:MoveAbove( self.Buttons[KP_ENTER] )
	
	self.Buttons[KP_MINUS]:CopyBounds( self.Buttons[KP_PLUS] )
	self.Buttons[KP_MINUS]:SetSize( ButtonSize, ButtonSize )
	self.Buttons[KP_MINUS]:MoveAbove( self.Buttons[KP_PLUS] )
	
	self.Buttons[KP_STAR]:CopyBounds( self.Buttons[KP_MINUS] )
	self.Buttons[KP_STAR]:MoveLeftOf( self.Buttons[KP_MINUS] )
	
	self.Buttons[KP_DIV]:CopyBounds( self.Buttons[KP_STAR] )
	self.Buttons[KP_DIV]:MoveLeftOf( self.Buttons[KP_STAR] )
	
	
	self.Buttons[4]:CopyBounds( self.Buttons[1] )
	self.Buttons[4]:MoveAbove( self.Buttons[1] )
		self.Buttons[5]:CopyBounds( self.Buttons[4] )
		self.Buttons[5]:MoveRightOf( self.Buttons[4] )
			self.Buttons[6]:CopyBounds( self.Buttons[5] )
			self.Buttons[6]:MoveRightOf( self.Buttons[5] )
			
	self.Buttons[7]:CopyBounds( self.Buttons[4] )
	self.Buttons[7]:MoveAbove( self.Buttons[4] )
		self.Buttons[8]:CopyBounds( self.Buttons[7] )
		self.Buttons[8]:MoveRightOf( self.Buttons[7] )
			self.Buttons[9]:CopyBounds( self.Buttons[8] )
			self.Buttons[9]:MoveRightOf( self.Buttons[8] )

end

--[[---------------------------------------------------------
	Think
-----------------------------------------------------------]]
function PANEL:Think()

local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	
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
	self:ConVarNumberThink()

end

--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )

self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }


if(!self.build ) then

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

else


	self.mouse = false
end


if( mousecode != MOUSE_LEFT ) then return end
	self.Sizing = nil
	self:MouseCapture( false )


end

--[[---------------------------------------------------------
   Name: SetValue (For ConVar)
-----------------------------------------------------------]]
function PANEL:SetValue( iNumValue )

	self:SetSelected( iNumValue )

end

--[[---------------------------------------------------------
   Name: GetValue
-----------------------------------------------------------]]
function PANEL:GetValue()

	return self:GetSelectedNumber()

end

derma.DefineControl( "RNumPad", "", PANEL, "RPanel" )