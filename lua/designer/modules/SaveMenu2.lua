 function RunWindowD()
local frame = vgui.Create("DFrame")
frame:SetPos(354,571)
frame:SetSize(435,341) 
frame:SetDraggable( true )
frame:SetSizable( true )
 frame:MakePopup()

 local e = vgui.Create("DTextEntry",frame)
						 e:SetPos(0.0091954022988506*frame:GetWide() ,0.91202346041056*frame:GetTall())
						 e:SetSize(0.64597701149425*frame:GetWide(),0.073313782991202*frame:GetTall())
				
 local e = vgui.Create("DDSideBoard",frame)
						 e:SetPos(2 ,20)
						 e:SetSize(24,frame:GetTall()-50)
				
 local e = vgui.Create("DDDesigner",frame)
						 e:SetPos(50 ,0.087976539589443*frame:GetTall())
						 e:SetSize(0.9816091954023*frame:GetWide(),0.80645161290323*frame:GetTall())
						 function e:Think()

						 e:SetSize(0.9816091954023*frame:GetWide(),0.80645161290323*frame:GetTall())
						 end
				
 end
