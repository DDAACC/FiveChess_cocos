Difficult=require("app.Logic.Difficult")
local Eveluation=require("app.Logic.Eveluation")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	print("Git test")
	print("MainSceneDiffcult:"..Difficult)
	local background=display.newSprite("image/background.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)
    local chessUi = cc.uiloader:load("FiveChessLogin_1.json"):addTo(self):pos(0,0) 
    -- cc.ui.UILabel.new({
    --         UILabelType = 2, text = "Hello, World", size = 64})
    --     :align(display.CENTER, display.cx, display.cy)
    --     :addTo(self)
    -- local test=Eveluation.new()

    local enterGame=cc.uiloader:seekNodeByName(chessUi, "Image_3")
    enterGame:setTouchEnabled(true)  					
	enterGame:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)		
	enterGame:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)   
		    if event.name == "began" then
		    	app:enterScene("GameScene",{Difficult},"crossFade",0.5)
		    elseif event.name == "moved" then
	       	
		    elseif event.name == "ended" then 
		    end	    
	    return true
	end)

	local quitGame=cc.uiloader:seekNodeByName(chessUi, "Image_4")
    quitGame:setTouchEnabled(true)  					
	quitGame:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)		
	quitGame:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)   
		    if event.name == "began" then
		    	os.exit()
		    elseif event.name == "moved" then
	       	
		    elseif event.name == "ended" then 
		    end	    
	    return true
	end)

	local DifficultPic=cc.uiloader:seekNodeByName(chessUi, "Label_10")


    local setDifficult=cc.uiloader:seekNodeByName(chessUi, "Image_6")
    setDifficult:setTouchEnabled(true)  					
	setDifficult:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)		
	setDifficult:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)   
		    if event.name == "began" then
		    	local cache=cc.Director:getInstance():getTextureCache():addImage("image/test2.png")
     		    setDifficult:setTexture(cache)
     		    if Difficult==4 then
     		    	Difficult=1 
     		    else
     		    	Difficult=Difficult+1
     		    end
     		    print("MainSceneDifficult"..Difficult)
     		    DifficultPic:setString(Difficult)
		    elseif event.name == "moved" then
	       	
		    elseif event.name == "ended" then 
		        local cache=cc.Director:getInstance():getTextureCache():addImage("image/test1.png")
     		    setDifficult:setTexture(cache)
		    end	    
	    return true
	end)    

end


function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
