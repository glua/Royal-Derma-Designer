--[[   _                                
	( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DButton
	
	Default Button

--]]

surface.CreateFont( "Button", {
	font = "DermaDefault",
	size = 20,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

PANEL = {}

AccessorFunc( PANEL, "m_bBorder", 			"DrawBorder", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 		"Disabled", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_FontName", 			"Font" )


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
	self.text = ""
	self.selected = false
	self.color = Color(255,190,0,255)

end


function PANEL:IsSelected()

	return self.selected

end

function PANEL:SetSelected(bool)

self.selected = bool

end

function PANEL:SetColor( color )

	self.color = color

end

--[[---------------------------------------------------------
	IsDown
-----------------------------------------------------------]]
function PANEL:IsDown()

	return self.Depressed

end

function PANEL:SetText( str )

	self.text = str

end

function PANEL:GetText()

	return self.text

end

function PANEL:Clicked()


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
		self.m_Image = vgui.Create( "DImage", self )
	end
	
	self.m_Image:SetImage( img )
	self.m_Image:SizeToContents()
	self:InvalidateLayout()

end

PANEL.SetIcon = PANEL.SetImage

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Paint( w, h )

if( self:IsHovered() ) then
	draw.SimpleText( self.text , "Button", 15, h/2, Color(85,170,255,255), 0, 1 )
else
	draw.SimpleText( self.text , "Button", 15, h/2, Color(0,122,204,255), 0, 1 )
	end
end


--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()
		


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

	

end

--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )

if( mousecode != MOUSE_LEFT ) then return end

		self.selected = true
	
	self:Clicked()
end


derma.DefineControl( "GMenuButton", "A standard Button", PANEL, "DPanel" )


