
PANEL = {}

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

    self.pages = {}
    self.index = 1
    self.next = vgui.Create("GButton", self)
    self.prev = vgui.Create("GButton", self)
    self.canvas = vgui.Create("DPanel", self)
    self.label = vgui.Create("DLabel", self)
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:AddPage( page )

    table.insert( self.pages, page )
    page:SetSize( self:GetWide(),self:GetTall()*.9)
    page:SetParent(self.canvas)

end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:visible()

    for k,v in ipairs( self.pages ) do
        if( k == self.index ) then
            self.pages[k]:SetVisible(true)
            for i, c in ipairs( self.pages[k]:GetChildren() ) do
                c:SetVisible(true)
            end
        else
            if( self.pages[k]:IsVisible() ) then
            self.pages[k]:SetVisible(false)
                 for i, c in ipairs( self.pages[k]:GetChildren() ) do
                     c:SetVisible(true)
                 end
            end
        end
    end

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

local main = self

    self.canvas:SetSize(w,h*.9)
    self.canvas:SetPos(0,0)
    function self.canvas:Paint(w,h)
        surface.SetDrawColor(0,0,0,0)
        surface.DrawRect(0,0,w,h)
    end

    self.label:SetText(self.index)
    self.label:SetPos(w*.5 ,h*.9)
    self.label:SetSize(25,25)


    self.prev:SetSize( 25,25 )
    self.prev:SetPos( w * .25, h *.9)
    self.prev:SetText( "<" )
    function self.prev:Clicked()
        if( self:IsSelected() ) then 
            self:SetSelected(false)
        end
        if( main.index == 1 ) then return end
        main.index = main.index - 1
        main.label:SetText(main.index)
      main:visible()
    end

    self.next:SetSize( 25,25 )
    self.next:SetPos( w * .75, h *.9)
    self.next:SetText( ">" )
    function self.next:Clicked()
        if( self:IsSelected() ) then 
            self:SetSelected(false)
        end
        if( main.index == #main.pages ) then return end
        main.index = main.index + 1
        main.label:SetText(main.index)
        main:visible()
    end


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PaintOver( w, h )


end


derma.DefineControl( "DDPageSwitch", "", PANEL, "DPanel" )