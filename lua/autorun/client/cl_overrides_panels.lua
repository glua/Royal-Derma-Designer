hook.Add("InitPostEntity", "rdd.panels", function()
	hook.Remove("InitPostEntity", "rdd.panels")

	timer.Simple(1, function()
		local PANEL = vgui.GetControlTable("DShape")

		function PANEL:Init()
			self.m_Type = "Rect"
			self:SetColor( color_white )

			self:SetMouseInputEnabled( false )
			self:SetKeyboardInputEnabled( false )
		end
	end)
end)