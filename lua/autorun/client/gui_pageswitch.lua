
PANEL = {}

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

    self.pages = {}
    self.buttons = {}
    self.index = 1
    self.next = vgui.Create("GButton", self)
    self.prev = vgui.Create("GButton", self)
    self.canvas = vgui.Create("DPanel", self)
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:AddPage( page )

    table.insert( self.pages, page )

    local _w = math.abs( ( self:GetWide()*.25 + 25 )  - self:GetWide() * .75  )
    local gap = math.floor( _w - ( #self.pages * 25 + 10 ) )

    button = vgui.Create("GButton", self)
    button:SetSize(25,25)
    local x,y = self.buttons[#self.buttons]:GetPos()
    Msg(x .. "\n")
    if( #self.buttons > 1 ) then button:SetPos( (self:GetWide() * 0.25 + 25) + gap + x , self:GetTall() * .9) else 
    button:SetPos( (self:GetWide() * 0.25 + 25) + gap , self:GetTall() * .9)
    end
    table.insert(self.buttons, button)
end


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )
local _w,_h = w,h
    if( #self.pages > 0 ) then
       for k,v in ipairs( self.pages ) do
        if( #self.buttons < 1 ) then return end
      self.buttons[k].Paint = function( self )
            surface.SetDrawColor( 255,0,0,255 )
            surface.DrawRect( 0,0,_w,_h)
          end

      end

    end

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

    for k,v in ipairs( self.pages) do
        v:SetParent(self.canvas)
    end

    self.prev:SetSize( 25,25 )
    self.prev:SetPos( w * .25, h *.9)
    self.prev:SetText( "<" )
    function self.prev:Clicked()
        if( main.index == 1 ) then return end
        main.index = main.index - 1
        for k,v in ipairs( main.pages ) do
            main.buttons[k].Clicked = function()
                main.index = k
            end
        end
       main:visible()
    end

    self.next:SetSize( 25,25 )
    self.next:SetPos( w * .75, h *.9)
    self.next:SetText( ">" )
    function self.next:Clicked()
        if( main.index == #main.pages ) then return end
        main.index = main.index + 1
        for k,v in ipairs( main.pages ) do
             main.buttons[k].Clicked = function()
                main.index = k
            end
        end
        main:visible()
    end


end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PaintOver( w, h )


end


derma.DefineControl( "DDPageSwitch", "", PANEL, "DPanel" )