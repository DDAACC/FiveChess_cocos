  BLACK = 0
  WHITE = 1
  GRID_NUM = 15
  GRID_COUNT = 225
  NOSTONE= 0xFF    
  STWO    =  1   
  STHREE  =  2   
  SFOUR   =  3   
  TWO     =  4   
  THREE   =  5   
  FOUR    =  6   
  FIVE    =  7   
  DFOUR   =  8   
  FOURT   =  9  
  DTHREE  = 10   
  NOTYPE  = 11   
  ANALSISED =255  
  TOBEANALSIS =0  
  TRUE =1
  FALSE =0
  GRID_NUM =15
 
local  Eveluation=class("Eveluation")


function Eveluation:ctor()
	  self.PosValue={
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
        { 0,1,1,1,1,1,1,1,1,1,1,1,1,1,0 },
        { 0,1,2,2,2,2,2,2,2,2,2,2,2,1,0 },
        { 0,1,2,3,3,3,3,3,3,3,3,3,2,1,0 },
        { 0,1,2,3,4,4,4,4,4,4,4,3,2,1,0 },
        { 0,1,2,3,4,5,5,5,5,5,4,3,2,1,0 },
        { 0,1,2,3,4,5,6,6,6,5,4,3,2,1,0 },
        { 0,1,2,3,4,5,6,7,6,5,4,3,2,1,0 },
        { 0,1,2,3,4,5,6,6,6,5,4,3,2,1,0 },
        { 0,1,2,3,4,5,5,5,5,5,4,3,2,1,0 },
        { 0,1,2,3,4,4,4,4,4,4,4,3,2,1,0 },
        { 0,1,2,3,3,3,3,3,3,3,3,3,2,1,0 },
        { 0,1,2,2,2,2,2,2,2,2,2,2,2,1,0 },
        { 0,1,1,1,1,1,1,1,1,1,1,1,1,1,0 },
        { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
        }
    self.m_LineRecord={}
    self.TypeRecord={}
    self.TypeCount={}
    self.m_LineRecord={}
    self.TypeRecord={}
    self.TypeCount={}
end


function Eveluation:Eveluate(position,bIsBlackTurn)

         
     local i,j,k
     local nStoneType
     for i=0,14 do
         self.TypeRecord[i]={}
         for j=0,14 do
         	self.TypeRecord[i][j]={}
         	for k=0,3 do
         		self.TypeRecord[i][j][k]=TOBEANALSIS
         	end
         end
     end

     for i=0,1 do
     	self.TypeCount[i]={}
     	for j=0,19 do
     		self.TypeCount[i][j]=TOBEANALSIS
     	end
     end

     for i=0,14 do
     	for j=0,14 do
     		if position[i][j] ~= NOSTONE then
                if self.TypeRecord[i][j][0]==TOBEANALSIS then
                	self:AnalysisHorizon(position, i, j);
                end
                if self.TypeRecord[i][j][1]==TOBEANALSIS then
                	self:AnalysisVertical(position, i, j);
                end
                if self.TypeRecord[i][j][2]==TOBEANALSIS then
                	self:AnalysisLeft(position, i, j);
                end
                if self.TypeRecord[i][j][3]==TOBEANALSIS then
                	self:AnalysisRight(position, i, j);
                end
     		end
     	end
     end

     for i=0,14 do
     	for j=0,14 do
     		for k=0,3 do
     			nStoneType=position[i][j]
     			if nStoneType~=NOSTONE then
                   if self.TypeRecord[i][j][k]==FIVE then
                   	  self.TypeCount[nStoneType][FIVE]=self.TypeCount[nStoneType][FIVE]+1
                   end
                   if self.TypeRecord[i][j][k]==FOUR then
                   	  self.TypeCount[nStoneType][FOUR]=self.TypeCount[nStoneType][FOUR]+1
                   end
                   if self.TypeRecord[i][j][k]==SFOUR then
                   	  self.TypeCount[nStoneType][SFOUR]=self.TypeCount[nStoneType][SFOUR]+1
                   end
                   if self.TypeRecord[i][j][k]==THREE then
                   	  self.TypeCount[nStoneType][THREE]=self.TypeCount[nStoneType][THREE]+1
                   end
                   if self.TypeRecord[i][j][k]==STHREE then
                   	  self.TypeCount[nStoneType][STHREE]=self.TypeCount[nStoneType][STHREE]+1
                   end
                   if self.TypeRecord[i][j][k]==TWO then
                   	  self.TypeCount[nStoneType][TWO]=self.TypeCount[nStoneType][TWO]+1
                   end
                   if self.TypeRecord[i][j][k]==STWO then
                   	  self.TypeCount[nStoneType][STWO]=self.TypeCount[nStoneType][STWO]+1
                   end

     			end
     		end
     	end
     end

     if bIsBlackTurn==1 then
     	if self.TypeCount[BLACK][FIVE]==1 then
     		return -9999
     	end
     	if self.TypeCount[WHITE][FIVE]==1 then
     		return 9999
     	end
     else
     	if self.TypeCount[BLACK][FIVE]==1 then
     		return 9999
     	end
     	if self.TypeCount[WHITE][FIVE]==1 then
     		return -9999
     	end
     end

     if self.TypeCount[WHITE][SFOUR] >1 then
     	self.TypeCount[WHITE][FOUR]=self.TypeCount[WHITE][FOUR]+1
     end

     if self.TypeCount[BLACK][SFOUR] >1 then
     	self.TypeCount[BLACK][FOUR]=self.TypeCount[BLACK][FOUR]+1
     end

     local WValue=0
     local BValue=0
     
     if bIsBlackTurn==1 then
     	if self.TypeCount[WHITE][FOUR]==1 then
     		return 9990
     	end
     	if self.TypeCount[WHITE][SFOUR]==1 then
     		return 9980
     	end
     	if self.TypeCount[BLACK][FOUR]==1 then
     		return -9970
     	end 
     	if self.TypeCount[BLACK][SFOUR]==1 and self.TypeCount[BLACK][THREE]==1 then
     		return -9960
     	end
     	if self.TypeCount[WHITE][THREE]==1 and self.TypeCount[BLACK][SFOUR]==1 then
     		return 9950
     	end
     	if self.TypeCount[BLACK][THREE] >1 and 
     	   self.TypeCount[WHITE][SFOUR]==0 and
     	   self.TypeCount[WHITE][THREE]==0 and
     	   self.TypeCount[WHITE][STHREE]==0 then
     	   return -9940
     	end
     	if self.TypeCount[WHITE][THREE]>1 then
     		WValue=WValue+2000
     	else
     		if self.TypeCount[WHITE][THREE]==1 then
     			WValue=WValue+200
     		end
     	end
     	if self.TypeCount[BLACK][THREE]>1 then
     		BValue=BValue+500
     	else
     		if self.TypeCount[BLACK][THREE]==1 then
     			BValue=BValue+100
     		end
     	end

     	if self.TypeCount[WHITE][STHREE]==1 then
     		WValue=WValue+self.TypeCount[WHITE][STHREE]*10
     	end
     	if self.TypeCount[BLACK][STHREE]==1 then
     		BValue=BValue+self.TypeCount[BLACK][STHREE]*10
     	end
     	if self.TypeCount[WHITE][TWO]==1 then
     		WValue=WValue+self.TypeCount[WHITE][TWO]*4
     	end
     	if self.TypeCount[BLACK][TWO]==1 then
     		BValue=BValue+self.TypeCount[BLACK][SWO]*4
     	end
     	if self.TypeCount[WHITE][STWO]==1 then
     		WValue=WValue+self.TypeCount[WHITE][STWO]
     	end
     	if self.TypeCount[BLACK][STWO]==1 then
     		BValue=BValue+self.TypeCount[BLACK][STWO]
     	end
     else
     	if self.TypeCount[BLACK][FOUR]==1 then
     		return 9990
     	end
     	if self.TypeCount[BLACK][SFOUR]==1 then
     		return 9980
     	end
     	if self.TypeCount[WHITE][FOUR]==1 then
     		return -9970
     	end 
     	if self.TypeCount[WHITE][SFOUR]==1 and self.TypeCount[WHITE][THREE]==1 then
     		return -9960
     	end
     	if self.TypeCount[BLACK][THREE]==1 and self.TypeCount[WHITE][SFOUR]==1 then
     		return 9950
     	end
     	if self.TypeCount[WHITE][THREE] >1 and 
     	   self.TypeCount[BLACK][SFOUR]==0 and
     	   self.TypeCount[BLACK][THREE]==0 and
     	   self.TypeCount[BLACK][STHREE]==0 then
     	   return -9940
     	end
     	if self.TypeCount[BLACK][THREE]>1 then
     		WValue=WValue+2000
     	else
     		if self.TypeCount[BLACK][THREE]==1 then
     			WValue=WValue+200
     		end
     	end
     	if self.TypeCount[WHITE][THREE]>1 then
     		BValue=BValue+500
     	else
     		if self.TypeCount[WHITE][THREE]==1 then
     			BValue=BValue+100
     		end
     	end

     	if self.TypeCount[BLACK][STHREE]==1 then
     		WValue=WValue+self.TypeCount[BLACK][STHREE]*10
     	end
     	if self.TypeCount[WHITE][STHREE]==1 then
     		BValue=BValue+self.TypeCount[WHITE][STHREE]*10
     	end
     	if self.TypeCount[BLACK][TWO]==1 then
     		WValue=WValue+self.TypeCount[BLACK][TWO]*4
     	end
     	if self.TypeCount[WHITE][TWO]==1 then
     		BValue=BValue+self.TypeCount[WHITE][SWO]*4
     	end
     	if self.TypeCount[BLACK][STWO]==1 then
     		WValue=WValue+self.TypeCount[BLACK][STWO]
     	end
     	if self.TypeCount[WHITE][STWO]==1 then
     		BValue=BValue+self.TypeCount[WHITE][STWO]
     	end
     end
     
     for i=0,14 do
     	for j=0,14 do
     		nStoneType=position[i][j]
     		if nStoneType~=NOSTONE then
     			if nStoneType==BLACK then
     				BValue=BValue+self.PosValue[i+1][j+1]
     			else
     				WValue=WValue+self.PosValue[i+1][j+1]
     			end
     		end

     	end
     end

     if bIsBlackTurn==0 then
     	return BValue-WValue
     else
     	return WValue-BValue
     end

end

function Eveluation:AnalysisHorizon(position,i,j)
    self:AnalysisLine(position[i], 15, j)
    for s=0,14 do
    	if self.m_LineRecord[s]~=TOBEANALSIS then
    		self.TypeRecord[i][s][0]=self.m_LineRecord[s]
    	end
    end
    return self.TypeRecord[i][j][0]
end

function Eveluation:AnalysisVertical(position,i,j)
    local teamArray={}
    for k=0,14 do
    	teamArray[k]=position[k][j]
    end
    self:AnalysisLine(teamArray, 15, i)
    for s=0,14 do
    	if self.m_LineRecord[s]~=TOBEANALSIS then
    		self.TypeRecord[s][j][1]=self.m_LineRecord[s]
    	end
    end
    return self.TypeRecord[i][j][1]
end

function Eveluation:AnalysisLeft(position,i,j)
     local teamArray={}
     local x=0
     local y=0
     local z=0
     if i<j then
     	y=0
     	x=j-i
     else
     	x=0
     	y=i-j
     end

     for k=0,14 do
     	if x+k>14 or y+k>14 then
     		break
     	end
     	z=z+1
     	teamArray[k]=position[y+k][x+k]
     end
     

     self:AnalysisLine(teamArray, z, j-x)
     for s=0,z-1 do
     	if self.m_LineRecord[s]~=TOBEANALSIS then
     		self.TypeRecord[y+s][x+s][2]=self.m_LineRecord[s]
     	end
     end
     return self.TypeRecord[i][j][2]
end

function Eveluation:AnalysisRight(position,i,j)
     local teamArray={}
     local x,y,realnum
     local z=0
     if 14-i<j then
     	y=14
     	x=j-14+i
     	realnum=14-i
     else
     	x=0
     	y=i+j
     	realnum=j
     end
     for k=0,14 do
     	if x+k>14 or y-k<0 then
     		break
     	end
     	z=z+1
     	teamArray[k]=position[y-k][x+k]
     end
     self:AnalysisLine(teamArray, z, j-x)
     for s=0,z-1 do
     	if self.m_LineRecord[s]~=TOBEANALSIS then
     		self.TypeRecord[y-s][x+s][3]=self.m_LineRecord[s]
     	end
     end
     return self.TypeRecord[i][j][3]
end

function Eveluation:AnalysisLine(position,GridNum,StonePos)
    local StoneType
    local AnalyLine={}
    local nAnalyPos
    local LeftEdge
    local RightEdge
    local LeftRange
    local RightRange

    if GridNum < 5 then
       for i=0,GridNum-1 do
       	  self.m_LineRecord[i]=ANALSISED
       	  return 0
       end
    end

    nAnalyPos=StonePos
    for i=0,29 do
    	self.m_LineRecord[i]=TOBEANALSIS
    end
    for i=0,29 do
    	AnalyLine[i]=0x0F
    end
    for i=0,GridNum-1 do
    	AnalyLine[i]=position[i]
    end
    GridNum=GridNum-1
    StoneType=AnalyLine[nAnalyPos]
    LeftEdge=nAnalyPos
    RightEdge=nAnalyPos
  
    while LeftEdge >0 do
    	if AnalyLine[LeftEdge-1] ~= StoneType then
    		break
    	end
    	LeftEdge=LeftEdge-1
    end

    while RightEdge< GridNum do
    	if AnalyLine[RightEdge+1]~=StoneType then
    		break
    	end
    	RightEdge=RightEdge+1
    end

    LeftRange=LeftEdge
    RightRange=RightEdge

    while LeftRange >0 do
    	local temp
    	if StoneType==1 then
    		temp=0
    	else
    		temp=1
    	end
    	if AnalyLine[LeftRange-1] == temp then
    		break
    	end
    	LeftRange=LeftRange-1
    end

    while RightRange<GridNum do
    	local temp
    	if StoneType==1 then
    		temp=0
    	else
    		temp=1
    	end
    	if AnalyLine[RightRange+1]== temp then
    		break
    	end
    	RightRange=RightRange+1
    end
    
    if RightRange-LeftRange<4 then
    	for k=LeftRange,RightRange do
    		self.m_LineRecord[k]=ANALSISED
    	end
    	return FALSE
    end
    for k=LeftEdge,RightEdge do
    	self.m_LineRecord[k]=ANALSISED
    end
    if RightEdge-LeftEdge>3 then
    	self.m_LineRecord[nAnalyPos]=FIVE
    	return FIVE
    end
    if RightEdge-LeftEdge==3 then
    	local LeftFour= FALSE
    	if LeftEdge>0 then
    		if AnalyLine[LeftEdge-1]==NOSTONE then
    			LeftFour=TRUE
    		end
    	end
    	if RightEdge<GridNum then
    		if AnalyLine[RightEdge+1]==NOSTONE then
    			if LeftFour== TRUE then
    				self.m_LineRecord[nAnalyPos]=FOUR
    			else
    				self.m_LineRecord[nAnalyPos]=SFOUR
    			end
    		else
    			if LeftFour== TRUE then
    				self.m_LineRecord[nAnalyPos]=SFOUR
    			end
    		end
    	else
    		if LeftFour==TRUE then
    			self.m_LineRecord[nAnalyPos]=SFOUR
    		end
    	end

    	return self.m_LineRecord[nAnalyPos]

    end

    if RightEdge-LeftEdge ==2 then
    	local LeftThree=FALSE 
    	if LeftEdge > 0 then
    		if AnalyLine[LeftEdge-1]==NOSTONE then
    			if LeftEdge>1 and AnalyLine[LeftEdge-2]==AnalyLine[LeftEdge] then
    				self.m_LineRecord[LeftEdge]=SFOUR
    				self.m_LineRecord[LeftEdge-2]=ANALSISED
    			else
    				LeftThree=TRUE
    			end
    		else
    			if RightEdge==GridNum or AnalyLine[RightEdge+1] ~= NOSTONE then
    				return FALSE
    			end
    		end
    	end

    	if RightEdge <GridNum then
    		if AnalyLine[RightEdge+1]==NOSTONE then
    			if RightEdge<GridNum-1 and AnalyLine[RightEdge+2]==AnalyLine[RightEdge] then
    				self.m_LineRecord[RightEdge]=SFOUR
    				self.m_LineRecord[RightEdge+2]=ANALSISED
    			else
    				if LeftThree == TRUE then
    					self.m_LineRecord[RightEdge]=THREE
    				else
    					self.m_LineRecord[RightEdge]=STHREE
    				end
    			end
    		else
    			if self.m_LineRecord[LeftEdge]==SFOUR then
    				return self.m_LineRecord[LeftEdge]
    			end
    			if LeftThree ==TRUE then
    				self.m_LineRecord[nAnalyPos]=STHREE
    			end
    		end
    	else
    		if self.m_LineRecord[LeftEdge]==SFOUR then
    			return self.m_LineRecord[LeftEdge]
    		end
    		if LeftThree==TRUE then
    			self.m_LineRecord[nAnalyPos]=STHREE
    		end
    	end
    	return self.m_LineRecord[nAnalyPos]

    end


    if RightEdge-LeftEdge ==1 then
    	local Lefttwo=FALSE
    	local Leftthree=FALSE
    	if LeftEdge >2 then
    		if AnalyLine[LeftEdge-1]==NOSTONE then
    			if LeftEdge-1>1 and AnalyLine[LeftEdge-2]==AnalyLine[LeftEdge] then
    				if AnalyLine[LeftEdge-3]==AnalyLine[LeftEdge] then
    					self.m_LineRecord[LeftEdge-3]=ANALSISED
    					self.m_LineRecord[LeftEdge-2]=ANALSISED
    					self.m_LineRecord[LeftEdge]=SFOUR
    				else
    					if AnalyLine[LeftEdge-3]==NOSTONE then
    						self.m_LineRecord[LeftEdge-2]=ANALSISED
    						self.m_LineRecord[LeftEdge]=STHREE
    					end
    				end
    			else
    				Lefttwo=TRUE
    			end
    		end
    	end

    	if RightEdge<GridNum then
    		if AnalyLine[RightEdge+1]==NOSTONE then
    			if RightEdge+1 <GridNum-1 and AnalyLine[RightEdge+2]==AnalyLine[RightEdge] then
    				if AnalyLine[RightEdge+3]==AnalyLine[RightEdge] then
    					self.m_LineRecord[RightEdge+3]=ANALSISED
    					self.m_LineRecord[RightEdge+2]=ANALSISED
    					self.m_LineRecord[RightEdge]=SFOUR
    				else
    					if AnalyLine[RightEdge+3]==NOSTONE then
    						self.m_LineRecord[RightEdge+2]=ANALSISED
    						if Lefttwo ==TURE then
    							self.m_LineRecord[RightEdge]=THREE
    						else
    							self.m_LineRecord[RightEdge]=STHREE
    						end
    					end
    				end
    			else
    				if self.m_LineRecord[LeftEdge]==SFOUR then
    					return self.m_LineRecord[LeftEdge]
    				end
    				if self.m_LineRecord[LeftEdge]==STHREE then
    					self.m_LineRecord[LeftEdge]=THREE
    					return self.m_LineRecord[LeftEdge]
    				end
    				if Lefttwo ==TRUE then
    					self.m_LineRecord[nAnalyPos]=TWO
    				else
    					self.m_LineRecord[nAnalyPos]=STWO
    				end
    			end
    		else
    			if self.m_LineRecord[LeftEdge]==SFOUR then
    				return self.m_LineRecord[LeftEdge]
    			end
    			if Lefttwo ==TRUE then
    				self.m_LineRecord[nAnalyPos]=STWO
    			end
    		end
    	end

    end


    return self.m_LineRecord[nAnalyPos]

end

return Eveluation