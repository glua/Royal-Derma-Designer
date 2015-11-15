--[[---------------------------------------------------------
  ## Name: FlatUI TabButtons ##
-----------------------------------------------------------]]

PANEL = {}

AccessorFunc( PANEL, "m_bBorder", 			"DrawBorder", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 		"Disabled", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_FontName", 			"Font" )
AccessorFunc( PANEL, "m_cFont", 			"FontColor" )
AccessorFunc( PANEL, "m_cbackground", 			"Background" )
AccessorFunc( PANEL, "m_bselect", 			"Select", FORCE_BOOL )
AccessorFunc( PANEL, "m_stext", 			"Text" )
AccessorFunc( PANEL, "m_nalign", 			"Align" )

--[[---------------------------------------------------------
NAME: Init( void )
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetDrawBorder( true )
	self:SetDrawBackground( true )

	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )

	self:SetCursor( "hand" )
	self:SetFont( "DermaDefault" )
	self:SetSelect( false )
	self:SetBackground( Color( 63, 88, 113, 255 ) )
	self:SetAlign( 1 )
	self:SetFontColor( Color( 255, 255, 255, 255 ) )

end

--[[---------------------------------------------------------
NAME: Clicked( void )
-----------------------------------------------------------]]
function PANEL:Clicked()

end

--[[---------------------------------------------------------
NAME: Paint( number, number )
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	if ( self.m_bselect )	then
		surface.SetDrawColor( self:GetBackground() )
		surface.DrawRect(0,0,w,h)
	end

	if( self:IsHovered( ) and !self.m_bselect ) then

		surface.SetDrawColor( self:GetBackground() )
		surface.DrawRect(0,0,w,h)

	end


end

function PANEL:PaintOver( w, h )


	if( self:GetAlign() == 1 ) then
		draw.SimpleText(   self.m_stext , self.m_FontName, w * .5, h * .5, self.m_cFont, 1, 1 )
	elseif( self:GetAlign() == 0 ) then
		draw.SimpleText(   self.m_stext , self.m_FontName, w * 0.2, h * .5, self.m_cFont, self:GetAlign(), 1 )

	end


end

--[[---------------------------------------------------------
NAME: OnMouseReleased( enum )
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )

	if( mousecode == MOUSE_LEFT ) then
		self:Clicked()
		self:SetSelect( true ) 	
	end
end

derma.DefineControl( "FlatButton", "A standard Button", PANEL, "DPanel" )