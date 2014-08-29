
PANEL = {}

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

	self.buttons = {}

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:AddButton( icon, func )


	local button = vgui.Create( "DImageButton", self )
	button:SetImage( icon )
	button.DoClick = func
	button:SetPos(2,20+((self:GetWide()-4)*(#self.buttons+1))-self:GetWide()-4)
	button:SetSize(self:GetWide()-4,self:GetWide()-4)

	table.insert( self.buttons, button )

end
--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

surface.SetDrawColor( 214, 214, 214, 255 )
surface.DrawRect( 0, 0, w, h )
surface.SetDrawColor( 73, 73, 73, 255 )
surface.DrawOutlinedRect(0,0,w,h)
surface.SetDrawColor( 222, 222, 222, 255 )
surface.DrawOutlinedRect(1,h*0.02250803858520900321543408360129,w-1,h - h * 0.0209003215434083601286173633440)
surface.SetDrawColor( 73, 73, 73, 255 )
surface.DrawRect( 0, 0, w, h * 0.02090032154340836012861736334405 )

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Think()


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PaintOver( w, h )


end


derma.DefineControl( "DDSideBoard", "A standard Button", PANEL, "DPanel" )