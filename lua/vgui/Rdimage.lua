--[[   _                                
	( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DImage

--]]

PANEL = {}

AccessorFunc( PANEL, "m_Material", 				"Material" )
AccessorFunc( PANEL, "m_Color", 				"ImageColor" )
AccessorFunc( PANEL, "m_bKeepAspect", 			"KeepAspect" )
AccessorFunc( PANEL, "m_strMatName", 			"MatName" )
AccessorFunc( PANEL, "m_strMatNameFailsafe", 	"FailsafeMatName" )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )
--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self:SetImageColor( Color( 255, 255, 255, 255 ) )
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( false )
	
	self:SetKeepAspect( false )
	
	self.ImageName = ""

	self.ActualWidth = 10
	self.ActualHeight = 10
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
	self:SetImage( "brick/brick_model" )
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

-----------------------------------------------------------]]
function PANEL:SetOnViewMaterial( MatName, MatNameBackup )

	self:SetMatName( MatName )
	self:SetFailsafeMatName( MatNameBackup )

end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Unloaded()
	return self.m_strMatName != nil
end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:LoadMaterial()

	if ( !self:Unloaded() ) then return end

	self:DoLoadMaterial()

	self:SetMatName( nil )

end

function PANEL:DoLoadMaterial()

	local mat = Material( self:GetMatName() )
	self:SetMaterial( mat )
		
	if ( self.m_Material:IsError() && self:GetFailsafeMatName()  ) then
		self:SetMaterial( Material( self:GetFailsafeMatName() ) )
	end
	
	self:FixVertexLitMaterial()

	//
	// This isn't ideal, but it will probably help you out of a jam
	// in cases where you position the image according to the texture
	// size and you want to load on view - instead of on load.
	//
	self:InvalidateParent()

end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:SetMaterial( Mat )

	-- Everybody makes mistakes, 
	-- that's why they put erasers on pencils.
	if ( type( Mat ) == "string" ) then
		self:SetImage( Mat )
	return end

	self.m_Material = Mat
	
	if (!self.m_Material) then return end
	
	local Texture = self.m_Material:GetTexture( "$basetexture" )
	if ( Texture ) then
		self.ActualWidth = Texture:Width()
		self.ActualHeight = Texture:Height()
	else
		self.ActualWidth = self.m_Material:Width()
		self.ActualHeight = self.m_Material:Height()
	end

end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:SetImage( strImage, strBackup )

	if ( strBackup && !file.Exists( "materials/"..strImage..".vmt", "GAME" ) ) then
		strImage = strBackup
	end

	self.ImageName = strImage

	local Mat = Material( strImage )
	self:SetMaterial( Mat )
	self:FixVertexLitMaterial()
	
end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:GetImage()

	return self.ImageName
	
end

function PANEL:FixVertexLitMaterial()
	
	--
	-- If it's a vertexlitgeneric material we need to change it to be
	-- UnlitGeneric so it doesn't go dark when we enter a dark room
	-- and flicker all about
	--
	
	local Mat = self:GetMaterial()
	local strImage = Mat:GetName()
	
	if ( string.find( Mat:GetShader(), "VertexLitGeneric" ) || string.find( Mat:GetShader(), "Cable" ) ) then
	
		local t = Mat:GetString( "$basetexture" )
		
		if ( t ) then
		
			local params = {}
			params[ "$basetexture" ] = t
			params[ "$vertexcolor" ] = 1
			params[ "$vertexalpha" ] = 1
			
			Mat = CreateMaterial( strImage .. "_DImage", "UnlitGeneric", params )
		
		end
		
	end
	
	self:SetMaterial( Mat )
	
end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:GetImage()

	return self.ImageName
	
end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:SizeToContents( strImage )

	self:SetSize( self.ActualWidth, self.ActualHeight )

end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Paint()

	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	else
	
	end
	self:PaintAt( 0, 0, self:GetWide(), self:GetTall() )
	

end

function PANEL:PaintAt( x, y, dw, dh )

	self:LoadMaterial()

	if ( !self.m_Material ) then return true end

	surface.SetMaterial( self.m_Material )
	surface.SetDrawColor( self.m_Color.r, self.m_Color.g, self.m_Color.b, self.m_Color.a )
	
	if ( self:GetKeepAspect() ) then
	
		local w = self.ActualWidth
		local h = self.ActualHeight
		
		-- Image is bigger than panel, shrink to suitable size
		if ( w > dw && h > dh ) then
		
			if ( w > dw ) then
			
				local diff = dw / w
				w = w * diff
				h = h * diff
			
			end
			
			if ( h > dh ) then
			
				local diff = dh / h
				w = w * diff
				h = h * diff
			
			end

		end
		
		if ( w < dw ) then
		
			local diff = dw / w
			w = w * diff
			h = h * diff
		
		end
		
		if ( h < dh ) then
		
			local diff = dh / h
			w = w * diff
			h = h * diff
		
		end
		
		local OffX = (dw - w) * 0.5
		local OffY = (dh - h) * 0.5
			
		surface.DrawTexturedRect( OffX+x, OffY+y, w, h )
	
		return true
	
	end
	
	
	surface.DrawTexturedRect( x, y, dw, dh )
	return true

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

	--self.select = false
	self.mouse = false
end
--	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )

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

derma.DefineControl( "RImage", "A simple image", PANEL, "Panel" )