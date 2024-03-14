--[[   _                                

					|Royal|
--]]

PANEL = {}
AccessorFunc( PANEL, "m_bclose", 		"ShowClose", 		FORCE_BOOL )
--[[---------------------------------------------------------
NAME: Init()
desc: 
-----------------------------------------------------------]]
function PANEL:Init()


self:MakePopup()
	self.close = vgui.Create("DButton",self)
	self.close.Paint = function( panel, w, h ) surface.SetDrawColor(255,255,255,255) 	surface.SetMaterial( Material("dd/gui/cross5.png")) surface.DrawTexturedRect( 0,0, w, h) end
	self.close.DoClick = function( btn ) self:Close() end
	self.drag = nil
	self.title = ""
    self.xa = 0
	self.Draggable = true
	self:SetShowClose( true )
end



--// Panel based blur function by Chessnut from NutScript
local blur = Material( "pp/blurscreen" )
function PANEL:blur( layers, density, alpha )
	-- Its a scientifically proven fact that blur improves a script
	local x, y = self:LocalToScreen(0, 0)

	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
	end
end
--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )


	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0, 0,  w, h )

	surface.SetDrawColor(42,42,42,255)
	surface.DrawRect(0,0,w,33)

	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(0,30,w,1)
	surface.SetDrawColor(59,57,58,255)
	surface.DrawRect(0,30,w,1)
	surface.SetDrawColor(150,150,150,255)
	surface.DrawRect(0,30,w,h-30)
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect( 0, 0,  w, h )

    surface.SetFont("Button")
    
  local _w,_h = surface.GetTextSize(  self.title )
	self.xa = self.xa - 0.5
	if( self.xa <= 0 - _w) then
		self.xa = w +3
	end
    if( _w >= w - 15 ) then
	    draw.SimpleText(   self.title , "Button", self.xa,15, Color(255,190,0,255), 0, 1 )
    else
        draw.SimpleText(   self.title , "Button", w * .5 ,15, Color(255,190,0,255), 1, 1 )
    end
end


function PANEL:SetDraggable( bool )


	self.Draggable = bool


end

function PANEL:SetTitle( str )

	self.title = str

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )


end

--[[---------------------------------------------------------
NAME:OverWrite
desc: 
-----------------------------------------------------------]]
function PANEL:OverWrite()



end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

if( self.Draggable ) then

	if( self.Dragging and input.IsMouseDown( MOUSE_LEFT )) then
        local x1,y1 = self:LocalCursorPos()
    	local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
	    local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
    	local x = mousex - x1
		local y = mousey - y1
		self:SetPos( x,y )
	else
    self.Dragging = nil
		end
end

	if( self.close != nil ) then
		if( self.m_bclose ) then
			self.close:SetVisible( true )
		else
			self.close:SetVisible( false )
		end

	end

self:OverWrite()

end

function PANEL:OnMousePressed()


self.Dragging = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }




end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:OnMouseReleased()

self.Dragging = nil

end


--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

		self.close:SetPos(w-17,5)
		self.close:SetSize(12,12)
		self.close:SetText("")


end

--[[---------------------------------------------------------
NAME: Close()
desc: 
-----------------------------------------------------------]]
function PANEL:Close()

	self:Remove()

end

--[[---------------------------------------------------------
NAME: IsActive()
desc: 
-----------------------------------------------------------]]
function PANEL:IsActive()

	if ( self:HasFocus() ) then return true end
	if ( vgui.FocusedHasParent( self ) ) then return true end
	
	return false

end

derma.DefineControl( "GMenu", "A Menu App", PANEL, "EditablePanel" )


