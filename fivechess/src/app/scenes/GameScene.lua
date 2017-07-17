Eveluation=require("app.Logic.Eveluation")
Difficult=require("app.Logic.Difficult")
Step=require("app.Logic.Step")
eve=Eveluation.new()
p={}
local Chess=require("app.objects.Chess")
local GameScene=class("GameScene",function()
	return display.newScene()
end)

function GameScene:ctor()
	chessBoard={}
    local background=display.newSprite("image/background.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)
    local chessBoardBackground = cc.uiloader:load("ChessBoard_1.json"):addTo(self):pos(0,160)  
    for i=0,14 do
    	chessBoard[i]={}
    	for j=0,14 do
    		chessBoard[i][j]=Chess.new(-1)
    		chessBoard[i][j]:pos(2*(i+1)+608/15*i+608/30,2*(j+1)+608/15*j+608/30):addTo(chessBoardBackground)
    		chessBoard[i][j]:setTouchEnabled(true)
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
     end,2,false)   
end 

function GameScene:beginGame()

end


function GameScene:ComputerPlay()
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
    print("get"..eve:Eveluate(p,0))
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
    chessBoard[RES[1]][RES[2]]:setChess(0)
    Step=2
end

function GameScene:PlayerPlay()
    print("jjj")
    for i=0,14 do
        for j=0,14 do
            chessBoard[i][j]:setTouchEnabled(true)
        end
    end
    Step=0
end

return GameScene