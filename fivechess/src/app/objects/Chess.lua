Step=require("app.Logic.Step")
Selected=require("app.Logic.Selected")
local Chess=class("Chess",function()
	return display.newSprite()
end)

function Chess:ctor(color)
    self.location={}
	self.value=0xFF
	self.chess=nil
	self.background=nil
    self.background=display.newSprite("image/chessbackground.png"):addTo(self)
    if color==0 then
    	self.chess=display.newSprite("image/black.png"):pos(20,20):addTo(self.background):setTag(0)
    	self.value=0
    end
    if color==1 then
    	self.value=1
    	self.chess=display.newSprite("image/white.png"):pos(20,20):addTo(self.background):setTag(0)
    end

    self:setTouchEnabled(false)  					
	self:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)		
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)   
		    if event.name == "began" then
		    	
		    	if self.chess==nil then
                    Step=1
		    		self:setChess(1)
		    	end
                Selected[3]=self:getPositionValue()[1]
                Selected[4]=self:getPositionValue()[2]

		    elseif event.name == "moved" then
	       	
		    elseif event.name == "ended" then 
		    end	    
	    return true
	end)
end

function Chess:ResetValue()
    self.value=0xFF
end

function Chess:setPositionValue(dx,dy)
    self.location[1]=dx 
    self.location[2]=dy
end

function Chess:getPositionValue()
    return self.location 
end

function Chess:setChess(tcolor)
     if self.chess ~= nil then
     	if tcolor== -1 then
     		self.value=0xFF
     		self.background:removeChildByTag(0)
     		self.chess=nil
     	end
     	if tcolor==1 then
     		self.value=1
     		local cache=cc.Director:getInstance():getTextureCache():addImage("image/white.png")
     		self.chess:setTexture(cache)
        end
        if tcolor==0 then
        	self.value=0
        	local cache=cc.Director:getInstance():getTextureCache():addImage("image/black.png")
     		self.chess:setTexture(cache)
        end
     else
     	if tcolor==1 then
     		self.value=1
     		self.chess=display.newSprite("image/white.png"):pos(20,20):addTo(self.background):setTag(0)
     	end
     	if tcolor==0 then
     		self.value=0
     		self.chess=display.newSprite("image/black.png"):pos(20,20):addTo(self.background):setTag(0)
     	end
     end
end

function Chess:setBackground(color)
     
     if color==1 then
        local cache=cc.Director:getInstance():getTextureCache():addImage("image/selected.png")
        self.background:setTexture(cache)
     end

     if color==0 then
        local cache=cc.Director:getInstance():getTextureCache():addImage("image/chessBackground.png")
        self.background:setTexture(cache)
    end

end

function Chess:getValue()
	return self.value
end

return Chess