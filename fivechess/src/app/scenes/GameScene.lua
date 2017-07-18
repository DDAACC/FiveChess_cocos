Eveluation=require("app.Logic.Eveluation")
Difficult=require("app.Logic.Difficult")
Step=require("app.Logic.Step")
Selected=require("app.Logic.Selected")
eve=Eveluation.new()
status=nil
p={}
local Chess=require("app.objects.Chess")
local GameScene=class("GameScene",function()
	return display.newScene()
end)

function Judge()
    local res=-1
    function JudgeLine(line,length)
        local rres=-1
        local i=0
        local j=0
        while i<length do
            while line[i]== 0xFF and i<length do
                i=i+1
            end
            j=i
            while j+1<length and line[i]==line[j+1]  do
                j=j+1
            end
            if j-i>3 then
                return line[j]
            end
            i=j+1
        end
        return rres
    end
    local boardValue={}

    for i=0,14 do
        boardValue[i]={}
        for j=0,14 do
            boardValue[i][j]=chessBoard[i][j]:getValue()
        end
    end
    local temp={}

    for i=0,14 do
        for j=0,14 do
            temp[j]=boardValue[i][j]
        end
        res=JudgeLine(temp,15)
        if res ~= -1 then
            return res
        end
    end

    for j=0,14 do
        for i=0,14 do
            temp[i]=boardValue[i][j]
        end
        res=JudgeLine(temp,15)
        if res ~= -1 then
            return res
        end
    end

    local iii=-14
    while iii<=0 do 
        local num=0
        for x=0,14 do
            local y=x+iii
            if y>=0 and y<=14 then
                temp[num]=boardValue[x][y]
                num=num+1
            end
        end
        res=JudgeLine(temp,num)
        if res ~= -1 then
            return res
        end
        iii=iii+1
    end
    for i=1,14 do
        local num=0
        for y=0,14 do          
            local x=y-i
            if x>=0 and x<=14 then
                temp[num]=boardValue[x][y]
                num=num+1
            end
             
        end
        res=JudgeLine(temp,num)
        if res ~= -1 then
            return res
        end
    end

    for i=0,14 do
        local num=0
        for x=0,14 do
            
            local y=i-x
            if y>=0 and y<=14 then
                temp[num]=boardValue[x][y]
                num=num+1
            end
            
        end
        res=JudgeLine(temp,num)
        if res ~= -1 then
            return res
        end
    end

    for i=15,28 do
        local num=0
        for y=0,14 do
            local x=i-y
            if x>=0 and x<=14 then
                temp[num]=boardValue[x][y]
                num=num+1
            end
        end
        res=JudgeLine(temp,num)
        if res ~= -1 then
            return res
        end
    end
    return res
end




function GameScene:ctor(args)
    
    Difficult=args
	chessBoard={}
    local background=display.newSprite("image/background.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)
    local chessBoardBackground = cc.uiloader:load("ChessBoard_1.json"):addTo(self):pos(0,160)  
    local chessBoardUi = cc.uiloader:load("FiveChessGameUi_1.json"):addTo(self):pos(0,0) 
    local ComInfo=cc.uiloader:seekNodeByName(chessBoardUi, "Label_1"):setAnchorPoint(1,1):pos(640,960)
    if Difficult ==1 then
        ComInfo:setString("电脑:简单的")
    end
    if Difficult ==2 then
        ComInfo:setString("电脑:中等的")
    end
    if Difficult ==3 then
        ComInfo:setString("电脑:困难的")
    end
    if Difficult== 4 then
        ComInfo:setString("电脑:变态的")
    end

    status=cc.uiloader:seekNodeByName(chessBoardUi, "Label_2")

    endText=cc.uiloader:seekNodeByName(chessBoardUi, "Label_8"):setVisible(false)

    local retrunMain=cc.uiloader:seekNodeByName(chessBoardUi, "Image_4")
    retrunMain:setTouchEnabled(true)                      
    retrunMain:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)     
    retrunMain:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)   
            if event.name == "began" then
                Difficult=1
                app:enterScene("MainScene",nil,"crossFade",0.5)
            elseif event.name == "moved" then
            
            elseif event.name == "ended" then 
            end     
        return true
    end)


    local restartGame=cc.uiloader:seekNodeByName(chessBoardUi, "Image_3")
    restartGame:setTouchEnabled(true)                      
    restartGame:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)     
    restartGame:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)   
            if event.name == "began" then
                endText:setVisible(false)
                Step=0
                for i=0,14 do
                  for j=0,14 do
                        chessBoard[i][j]:setTouchEnabled(true):setChess(-1)
                        chessBoard[i][j]:setBackground(0)
                    end
                end
            elseif event.name == "moved" then
            
            elseif event.name == "ended" then 
            end     
        return true
    end)


    for i=0,14 do
    	chessBoard[i]={}
    	for j=0,14 do
    		chessBoard[i][j]=Chess.new(-1)
    		chessBoard[i][j]:pos(2*(i+1)+608/15*i+608/30,2*(j+1)+608/15*j+608/30):addTo(chessBoardBackground)
    		chessBoard[i][j]:setTouchEnabled(true):setPositionValue(i, j)
    	end
    end

    local scheduler = cc.Director:getInstance():getScheduler()
    local schedulerID = nil
    schedulerID = scheduler:scheduleScriptFunc(function()
    	if Step==1 then
	        for i=0,14 do
	        	for j=0,14 do
	        		chessBoard[i][j]:setTouchEnabled(false)
	        	end
	        end
	        self.ComputerPlay()
	   end
        if Step==2 then
            self.PlayerPlay()
	    end
        if Step==3 then
            local temp
            if Judge()==0 then
                endText:setString("你失败了,电脑胜利!")
            else
                endText:setString("恭喜你战胜了电脑")
            end
            endText:setVisible(true)
        end
     end,0.2,false)   
end 

function GameScene:beginGame()

end


function GameScene:ComputerPlay()
    print(Judge())
    
    if Judge()==1 then
        Step=3
    end   
    chessBoard[Selected[1]][Selected[2]]:setBackground(0)
    chessBoard[Selected[3]][Selected[4]]:setBackground(1)

    
    Selected[1]=Selected[3]
    Selected[2]=Selected[4]



    for i=0,14 do
        for j=0,14 do
            chessBoard[i][j]:setTouchEnabled(false)
        end
    end
    local RES={}
    RES[1]=0
    RES[2]=0
	for i=0,14 do
		p[i]={}
		for j=0,14 do
			p[i][j]=chessBoard[i][j]:getValue()
		end
	end
	function AlphaBeta(depth,alpha,beta,turn)
        if depth==0 then
        	if Difficult==1 or Difficult==3 then
        		return eve:Eveluate(p,1) 
            else
                return eve:Eveluate(p,0)
            end
        end

        local best=-9999999
        local Moves={}
        local maxX=0 
        local maxY=0 
        local minX=14
        local minY=14
        for i=0,14 do
        	for j=0,14 do
        		if p[i][j]~=255 then
        			if i>=maxX then
        				maxX=i
        			end
        			if i<=minX then
        				minX=i
        			end
        			if j>=maxY then
        				maxY=j
        			end
        			if j<=minY then
        				minY=j
        			end
        		end
        	end
        end
        local Li=minX-1
        local Ri=maxX+1
        local Bj=maxY+1
        local Tj=minY-1
        if Li<0 then
        	Li=0
        end
        if Ri>14 then
        	Ri=14
        end
        if Tj<0 then
        	Tj=0
        end
        if Bj>14 then
        	Bj=14
        end

        local times=0
        for i=Li,Ri do
        	for j=Tj,Bj do
        		if p[i][j]==255 then
        			Moves[times]={}
        			Moves[times][1]=i
        			Moves[times][2]=j
                    times=times+1
        		end
        	end
        end
        times=times-1
        while times>=0 do
        	local mx=Moves[times][1]
        	local my=Moves[times][2]
        	times=times-1
        	p[mx][my]=turn
        	local temp
        	if turn == 0 then
        		temp=1
        	end
        	if turn == 1 then
        		temp=0
        	end
        	local val=-AlphaBeta(depth-1,-beta,-alpha,temp)
        	if depth==Difficult and val>best then
        		best=val
        		RES[1]=mx
        		RES[2]=my
        	end
        	p[mx][my]=255
        	if val>= beta then
        		return beta 
        	end
        	if val>alpha then
        		alpha=val
        	end
        end
        return alpha
	end
	AlphaBeta(Difficult,-9999999,9999999,0)

    -- function min(depth,alpha,beta) 
    --     print("min".. alpha..beta)
    --     if depth==0 then
    --         return eve:Eveluate(p,0)
    --     end
    --     local best=99999
    --     local Moves={}
    --     local maxX=0 
    --     local maxY=0 
    --     local minX=14
    --     local minY=14
    --     for i=0,14 do
    --      for j=0,14 do
    --          if p[i][j]~=255 then
    --              if i>=maxX then
    --                  maxX=i
    --              end
    --              if i<=minX then
    --                  minX=i
    --              end
    --              if j>=maxY then
    --                  maxY=j
    --              end
    --              if j<=minY then
    --                  minY=j
    --              end
    --          end
    --      end
    --     end
    --     local Li=minX-1
    --     local Ri=maxX+1
    --     local Bj=maxY+1
    --     local Tj=minY-1
    --     if Li<0 then
    --      Li=0
    --     end
    --     if Ri>14 then
    --      Ri=14
    --     end
    --     if Tj<0 then
    --      Tj=0
    --     end
    --     if Bj>14 then
    --      Bj=14
    --     end

    --     local times=0
    --     for i=Li,Ri do
    --      for j=Tj,Bj do
    --          if p[i][j]==255 then
    --              Moves[times]={}
    --              Moves[times][1]=i
    --              Moves[times][2]=j
    --                 times=times+1
    --          end
    --      end
    --     end
    --     times=times-1
    --     while times>=0 do
    --         local mx=Moves[times][1]
    --         local my=Moves[times][2]
    --         p[mx][my]=1
    --         local temp=0
    --         if best <= alpha then
    --             temp=best 
    --         else
    --             temp=alpha
    --         end
    --         local v=max(depth-1,temp,beta)
    --         p[mx][my]=0xFF
    --         if v<best then
    --             best=v 
    --         end
    --         if v<beta then
    --             break
    --         end
    --     end
    --     return best 
    -- end

    -- function max(depth,alpha,beta)
    --     if depth==0 then
    --         return eve:Eveluate(p,0)
    --     end
    --     local BEST=-99999
    --     local best=-999999
    --     local Moves={}
    --     local maxX=0 
    --     local maxY=0 
    --     local minX=14
    --     local minY=14
    --     for i=0,14 do
    --      for j=0,14 do
    --          if p[i][j]~=255 then
    --              if i>=maxX then
    --                  maxX=i
    --              end
    --              if i<=minX then
    --                  minX=i
    --              end
    --              if j>=maxY then
    --                  maxY=j
    --              end
    --              if j<=minY then
    --                  minY=j
    --              end
    --          end
    --      end
    --     end
    --     local Li=minX-1
    --     local Ri=maxX+1
    --     local Bj=maxY+1
    --     local Tj=minY-1
    --     if Li<0 then
    --      Li=0
    --     end
    --     if Ri>14 then
    --      Ri=14
    --     end
    --     if Tj<0 then
    --      Tj=0
    --     end
    --     if Bj>14 then
    --      Bj=14
    --     end

    --     local times=0
    --     for i=Li,Ri do
    --      for j=Tj,Bj do
    --          if p[i][j]==255 then
    --              Moves[times]={}
    --              Moves[times][1]=i
    --              Moves[times][2]=j
    --                 times=times+1
    --          end
    --      end
    --     end
    --     times=times-1
    --     while times>=0 do
    --         local mx=Moves[times][1]
    --         local my=Moves[times][2]
    --         p[mx][my]=0
    --         local temp=0
    --         if best> beta then
    --             temp=best
    --         else
    --             temp=beta
    --         end
    --         print("max"..alpha)
    --         local v=min(depth-1,alpha,temp)
    --         if depth==Difficult and v>=BEST then
    --             BEST=v
    --             RES[1]=mx
    --             RES[2]=my
    --         end
    --         if v>best then
    --             best=v
    --         end
    --         if v>alpha then
    --             break
    --         end
    --     end
    --     return best
    -- end



    -- max(Difficult,-99999999,99999999)
    chessBoard[RES[1]][RES[2]]:setChess(0)

    Selected[3]=RES[1]
    Selected[4]=RES[2]

    chessBoard[Selected[1]][Selected[2]]:setBackground(0)
    chessBoard[Selected[3]][Selected[4]]:setBackground(1)

    
    Selected[1]=Selected[3]
    Selected[2]=Selected[4]

    status:setString("电脑落子("..RES[1]..","..RES[2]..")".. " 你的回合"):setAnchorPoint(0,1):pos(0,960)

    if Judge()==0 then
        Step=3
    else
        Step=2
    end
    
end

function GameScene:PlayerPlay()
    for i=0,14 do
        for j=0,14 do
            chessBoard[i][j]:setTouchEnabled(true)
        end
    end
    Step=0
end



return GameScene