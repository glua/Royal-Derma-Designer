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
	self.close.Paint = function( panel, w, h ) surface.SetDrawColor(255,255,255,255) 	surface.SetMaterial( Material("clan/cross5.png")) surface.DrawTexturedRect( 0,0, w, h) end
	self.drag = nil
	self.title = ""
	self.Dragable = true
	self:SetShowClose( true )
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
	draw.SimpleText(   self.title , "Button", w/2,15, Color(255,190,0,255), 1, 1 )
end


function PANEL:SetDragable( bool )


	self.Dragable = bool


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

if( self.Dragable ) then
	local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	if( self.drag ) then
		self:SetPos( mousex,mousey)
		
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

self.drag = true



end


--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:OnMouseReleased()

self.drag = nil

end


--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

		self.close:SetPos(w-17,5)
		self.close:SetSize(12,12)
		self.close:SetText("")
		self.close.DoClick = function( btn ) 
			 self:Close()
		 end

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


