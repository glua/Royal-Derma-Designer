--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

--]]
local PANEL = {}

AccessorFunc( PANEL, "m_fAnimSpeed", 	"AnimSpeed" )
AccessorFunc( PANEL, "Entity", 			"Entity" )
AccessorFunc( PANEL, "vCamPos", 		"CamPos" )
AccessorFunc( PANEL, "fFOV", 			"FOV" )
AccessorFunc( PANEL, "vLookatPos", 		"LookAt" )
AccessorFunc( PANEL, "aLookAngle", 		"LookAng" )
AccessorFunc( PANEL, "colAmbientLight", "AmbientLight" )
AccessorFunc( PANEL, "colColor", 		"Color" )
AccessorFunc( PANEL, "bAnimated", 		"Animated" )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )


--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self.Entity = nil
	self.LastPaint = 0
	self.DirectionalLight = {}
	
	self:SetCamPos( Vector( 50, 50, 50 ) )
	self:SetLookAt( Vector( 0, 0, 40 ) )
	self:SetFOV( 70 )
	
	self:SetText( "" )
	self:SetAnimSpeed( 0.5 )
	self:SetAnimated( false )
	
	self:SetAmbientLight( Color( 50, 50, 50 ) )
	
	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	
	self:SetColor( Color( 255, 255, 255, 255 ) )
	self:SetModel("models/player/alyx.mdl")
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
	self.model = ""
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

	--self.select = false
	self.mouse = false
end
--	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )

end


--[[---------------------------------------------------------
   Name: SetDirectionalLight
-----------------------------------------------------------]]
function PANEL:SetDirectionalLight( iDirection, color )
	self.DirectionalLight[iDirection] = color
end

--[[---------------------------------------------------------
   Name: OnSelect
-----------------------------------------------------------]]
function PANEL:SetModel( strModelName )

	-- Note - there's no real need to delete the old 
	-- entity, it will get garbage collected, but this is nicer.
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil		
	end
	
	-- Note: Not in menu dll
	if ( !ClientsideModel ) then return end
	self.model = strModelName
	self.Entity = ClientsideModel( strModelName, RENDER_GROUP_OPAQUE_ENTITY )
	if ( !IsValid(self.Entity) ) then return end
	
	self.Entity:SetNoDraw( true )
	
	-- Try to find a nice sequence to play
	local iSeq = self.Entity:LookupSequence( "walk_all" );
	if (iSeq <= 0) then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if (iSeq <= 0) then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end
	
	if (iSeq > 0) then self.Entity:ResetSequence( iSeq ) end
	
	
end

function PANEL:GetModel( )

return self.model

end

--[[---------------------------------------------------------
   Name: OnMousePressed
-----------------------------------------------------------]]
function PANEL:Paint()
	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	end
	if ( !IsValid( self.Entity ) ) then return end
	
	local x, y = self:LocalToScreen( 0, 0 )
	
	self:LayoutEntity( self.Entity )
	
	local ang = self.aLookAngle
	if ( !ang ) then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end
	
	local w, h = self:GetSize()
	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, 4096 )
	cam.IgnoreZ( true )
	
	render.SuppressEngineLighting( true )
	render.SetLightingOrigin( self.Entity:GetPos() )
	render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
	render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
	render.SetBlend( self.colColor.a/255 )
	
	for i=0, 6 do
		local col = self.DirectionalLight[ i ]
		if ( col ) then
			render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
		end
	end
		
	self.Entity:DrawModel()
	
	render.SuppressEngineLighting( false )
	cam.IgnoreZ( false )
	cam.End3D()
	
	self.LastPaint = RealTime()

end

--[[---------------------------------------------------------
   Name: RunAnimation
-----------------------------------------------------------]]
function PANEL:RunAnimation()
	self.Entity:FrameAdvance( (RealTime()-self.LastPaint) * self.m_fAnimSpeed )	
end

--[[---------------------------------------------------------
   Name: RunAnimation
-----------------------------------------------------------]]
function PANEL:StartScene( name )
	
	if ( IsValid( self.Scene ) ) then
		self.Scene:Remove()
	end
	
	self.Scene = ClientsideScene( name, self.Entity )
	
end



--[[---------------------------------------------------------
   Name: LayoutEntity
-----------------------------------------------------------]]
function PANEL:LayoutEntity( Entity )

	--
	-- This function is to be overriden
	--

	if ( self.bAnimated ) then
		self:RunAnimation()
	end
	
	Entity:SetAngles( Angle( 0, RealTime()*10,  0) )

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetSize( 300, 300 )
		ctrl:SetModel( "models/error.mdl" )
		
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RModelPanel", "A panel containing a model", PANEL, "RButton" )