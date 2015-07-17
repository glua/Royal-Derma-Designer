
--[[---------------------------------------------------------
Name: CodeView( string, string )
Desc: 
-----------------------------------------------------------]] 
function CodeView( text, name )

local frame = vgui.Create("GMenu")
frame:SetPos( 0.125 * ScrW(), 0.125 * ScrH() )
frame:SetSize( 0.5 * ScrW(), 0.5 * ScrH() ) 
frame:SetDragable( false )
frame:SetTitle(name)
frame:MakePopup()

local panellist = vgui.Create("DPanelList", frame )
panellist:SetPos(0.009375 * frame:GetWide(), 0.05 * frame:GetTall() )
panellist:SetSize( 0.98541666666667 * frame:GetWide(),  0.945 * frame:GetTall())
panellist:EnableVerticalScrollbar()

 local etext = vgui.Create( "DTextEntry" )
 etext:SetPos( 0,0 )
 etext:SetSize( 0.98541666666667 * frame:GetWide(), #string.Explode( "\n",text ) * 15  )
 etext:SetFont( "DermaDefault" )
 etext:SetMultiline( true )
 etext:SetValue( text)
 etext:SetMouseInputEnabled( false )

 panellist:AddItem( etext )
						
end

