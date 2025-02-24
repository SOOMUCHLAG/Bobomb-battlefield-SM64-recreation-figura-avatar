mesh = {
}
colTris = {}



--width + height of the screen
width =70
height =70
--initializing the depth buffer
depthBuffer = {}
--setting the camera pos(as the y lowers the camera height increases)
cameraPos = vec(0,-2,0)
lookDir = vec(0,0,1)

--seting the camera direction
yaw = 0
pitch = 0

--Custom matrix multiplication function
local function multMatrix(vec3d,mat)
  return (mat * vec(vec3d.x,vec3d.y,vec3d.z,1)).xyz
end


--"point at" matrix function used for camera stuff
local function pointAtMatrix(pos,target,up)
local newForward = (target - pos):normalize()
local newUp = (up-(newForward * up:dot(newForward))):normalize()
local newRight = newUp:crossed(newForward)
local tranMat = matrices.mat4(
vec(newRight.x,newRight.y,newRight.z,0),
vec(newUp.x,newUp.y,newUp.z,0),
vec(newForward.x,newForward.y,newForward.z,0),
vec(pos.x,pos.y,pos.z,1))
return tranMat
end  
local function QuickInverse(mat)
local traslation = -mat[4].xyz

local newMat = matrices.mat4( vec(mat[1].x,mat[2].x,mat[3].x,0),
 vec(mat[1].y,mat[2].y,mat[3].y,0),
 vec(mat[1].z,mat[2].z,mat[3].z,0),
vec(traslation:dot(mat[1].xyz),traslation:dot(mat[2].xyz),traslation:dot(mat[3].xyz),1))

return newMat
end


--distance function used for clipping 
local function dist(planeNormal, planePoint, p)
  return (planeNormal:dot(p) - planeNormal:dot(planePoint))
end

--vector to plane intersection written by chatgpt cause I was lazy. function used for clipping
local function Vector_IntersectPlane(planePoint, planeNormal, lineStart, lineEnd)
  -- Plane equation

  local ad = lineStart:dot(planeNormal)
  local t = (planeNormal:dot(planePoint) - ad) / ((lineEnd:dot(planeNormal)) - ad)


  if t < 0 or t > 1 then return nil, t end



  return (lineStart + (lineEnd - lineStart) * t), t
end

--Triangle clipping function
local function triClipAgainstPlane(planePoint, planeNormal, triangle)


  local insidePoints, outsidePoints = {}, {}
  local insideTexes, outsideTexes = {}, {}
local tri1hewee = triangle[1]
local tri2hewee = triangle[2]
local tri3hewee = triangle[3]
  local d0 = planeNormal:dot(tri1hewee) - planeNormal:dot(planePoint)
  local d1 = planeNormal:dot(tri2hewee) - planeNormal:dot(planePoint)
  local d2 = planeNormal:dot(tri3hewee) - planeNormal:dot(planePoint)

  if d0 >= 0 then
                insidePoints[#insidePoints+1] =  tri1hewee
                insideTexes[#insideTexes+1] = triangle[6]
  else
                outsidePoints[#outsidePoints+1] = tri1hewee
                outsideTexes[#outsideTexes+1] = triangle[6]
  end

  if d1 >= 0 then
    insidePoints[#insidePoints+1] =  triangle[2]
    insideTexes[#insideTexes+1] = triangle[7]
  else
    outsidePoints[#outsidePoints+1] = triangle[2]
    outsideTexes[#outsideTexes+1] = triangle[7]
  end

  if d2 >= 0 then
    insidePoints[#insidePoints+1] =  triangle[3]
    insideTexes[#insideTexes+1] = triangle[8]
  else
    outsidePoints[#outsidePoints+1] = triangle[3]
    outsideTexes[#outsideTexes+1] = triangle[8]
  end


  if #insidePoints == 0 then
    return 
  end
  
  if #insidePoints == 3 then
    return 1, triangle  
  end

  if #insidePoints == 1 and #outsidePoints == 2 then
    local outTriangle = {}

    outTriangle[1] = insidePoints[1]
    outTriangle[6] = insideTexes[1]


    outTriangle[5] = triangle[5]
    local t
    outTriangle[2], t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[1], outsidePoints[1])
    outTriangle[7] = t*(outsideTexes[1]-insideTexes[1])+insideTexes[1]
    

    outTriangle[3], t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[1], outsidePoints[2])
    outTriangle[8] = t*(outsideTexes[2]-insideTexes[1])+insideTexes[1]

    return 1, outTriangle
  end

  if #insidePoints == 2 and #outsidePoints == 1 then
    local outTriangle1, outTriangle2 = {}, {}
    local t


    outTriangle1[5] = triangle[5]

    outTriangle1[1] = insidePoints[1]
    outTriangle1[6] = insideTexes[1]
    outTriangle1[2] = insidePoints[2]
    outTriangle1[7] = insideTexes[2]
    outTriangle1[3], t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[2], outsidePoints[1])
    outTriangle1[8] = t*(outsideTexes[1]-insideTexes[2])+insideTexes[2]


    outTriangle2[5] = triangle[5]
 
    outTriangle2[1] = insidePoints[1]
    outTriangle2[6] = insideTexes[1]
    outTriangle2[2] = outTriangle1[3]
    outTriangle2[7] = outTriangle1[8]
    outTriangle2[3], t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[1], outsidePoints[1])
    outTriangle2[8] = t*(outsideTexes[1]-insideTexes[1])+insideTexes[1]

    return 2, outTriangle1, outTriangle2
  end
end




local screenPlanes = {
  {planePoint = vec(0, 1, 0), planeNormal = vec(0, 1, 0)}, --top
  {planePoint = vec(1, 0, 0), planeNormal = vec(1, 0, 0)}, --left
  {planePoint = vec(0, height-2, 0), planeNormal = vec(0, -1, 0)}, --bottom
  {planePoint = vec(width-2, 0, 0), planeNormal = vec(-1, 0, 0)}, --right
}


--clipping the triangles with screen edges DELETING THIS WILL CAUSE SEVERE LAG CLOSE TO THE TRIANGLES
local function clipTriangleAgainstAllPlanes(triangles)



  local queue = table.pack(table.unpack(triangles))


  for i, plane in ipairs(screenPlanes) do
    local newTriangles = {}
    local planepoint = plane.planePoint
    local planenormal = plane.planeNormal
      while #queue > 0 do


          local numClipped, clippedTri1, clippedTri2 = triClipAgainstPlane(planepoint, planenormal,table.remove(queue))

          if numClipped == 1  then
              newTriangles[#newTriangles+1] =  clippedTri1
          elseif numClipped == 2 then
            
            newTriangles[#newTriangles+1] =  clippedTri1
        
            newTriangles[#newTriangles+1] =  clippedTri2
     
          end
      end

      queue = newTriangles
  end

  return queue
end










function events.entity_init()
  --creating a screen
  createScreen(player:getPos(),nil,width,height)

  --initializing values in the depth buffer
  for i = 1, width do
    depthBuffer[i] = {}
    for j = 1, height do
      depthBuffer[i][j] = 0
    end
  end


  for i, meshData in pairs(BBmodelToMesh) do
    convertBBmodelToMesh(meshData.modelpart,i,meshData.textureName,meshData.facNums)
  end

end
--Fov = field of view
local fov = 90
local fovRad = 1/math.tan(math.rad(fov)*0.5)
--aspect ratio
local aspectRatio = width/height
--Near = near clipping plane
local near = 0.1
--Far = far clipping plane
local far = 1000
--Projection Matrix

--[[
aspectRatio*fovRad 0 0 0
0 fovRad 0 0
0 0 far/(far-near) 1
0 0 (-far*near)/(far-near) 0
]]
projectionMatrix = matrices.mat4()
projectionMatrix[1] = vec(aspectRatio*fovRad,0,0,0)
projectionMatrix[2] = vec(0,fovRad,0,0)
projectionMatrix[3] = vec(0,0,far/(far-near),1)
projectionMatrix[4] = vec(0,0,(-far*near)/(far-near),0)


local zeropoint3vec = vec(0, 0, 0.3)
local onevec = vec(0, 0, 1)
local lightDirection = vec(-1,-2,-3):normalize()

local target
local up = vec(0,1,0)
cameraPosWithOffset = vec(0,0,0)
local halfwidthheightvec = vec(width,height,1)/2

--rendering code
function events.tick()
halfwidthheightvec = vec(width,height,1)*0.5

cameraPosWithOffset = cameraPos+cameraoffset
colTris = {}
  updateCameraOrientation(yaw, pitch)
  target = cameraPosWithOffset+lookDir
  camMat = pointAtMatrix(cameraPosWithOffset,target,up)
  viewMat = QuickInverse(camMat)


--clearing the screen
clearScreen()


--Drawing every mesh
for i, tbl in pairs(mesh) do
  local triToRaster = {}
  local RotMat = matrices.rotation3(vec(180+BBmodelToMesh[i].rotation.x,0+BBmodelToMesh[i].rotation.y,0+BBmodelToMesh[i].rotation.z))
  local translation = BBmodelToMesh[i].translation
  local scale = BBmodelToMesh[i].scale
  local pivot = BBmodelToMesh[i].pivot:copy()
  local colthreshold = 62/scale.x
  local renderthreshold = 110/scale.x
  local tranminuspivot= translation-pivot
  local textureName = BBmodelToMesh[i].textureName
  local cameraPositionInMeshSpace = ((cameraPosWithOffset-pivot)*RotMat:inverted()-tranminuspivot)/scale
  for j, triangle in pairs(tbl) do
    local averagedist
    if i~="player" then
      averagedist = (((triangle[1]+triangle[2]+triangle[3])*0.33333333)-cameraPositionInMeshSpace):length()
      end
      local isLevelOrSeesaw = (i == 1 or i == "seesaw")
      if not isLevelOrSeesaw or averagedist<renderthreshold then
  local triTranslated = {}
  local triViewed1 = {}
--translation
local trimult1 = (triangle[1]*scale)+tranminuspivot
local trimult2 = (triangle[2]*scale)+tranminuspivot
local trimult3 = (triangle[3]*scale)+tranminuspivot
triTranslated[1] = (RotMat * trimult1)+pivot
triTranslated[2] = (RotMat * trimult2)+pivot
triTranslated[3] = (RotMat * trimult3)+pivot
local triga = triTranslated[1]






  if isLevelOrSeesaw and  averagedist<colthreshold then
    colTris[#colTris+1] = triTranslated
    end

  --face normals

  local normal = (triTranslated[2] - triga):crossed(triTranslated[3] - triga):normalize()
--illumination


  
  --updating the camera pos and generally camera stuff


triViewed1=table.pack(table.unpack(triangle))
triViewed1[5] =  normal:dot(lightDirection)

trimult2 = triTranslated[2]
trimult3 = triTranslated[3]
  triViewed1[1] = (viewMat * vec(triga.x,triga.y,triga.z,1)).xyz
  triViewed1[2] = (viewMat * vec(trimult2.x,trimult2.y,trimult2.z,1)).xyz
  triViewed1[3] = (viewMat * vec(trimult3.x,trimult3.y,trimult3.z,1)).xyz



--near clipping plane
if normal:dot(triga-cameraPosWithOffset) < 0 then
  local numClipped
  local clippedTriangles = {}

numClipped, clippedTriangles[1] , clippedTriangles[2] = triClipAgainstPlane(zeropoint3vec, onevec, triViewed1)

--Projecting the triangles

for k, tri in pairs(clippedTriangles) do
  local triProjected = {}
  

  --taking viewspace z values
  local w1,w2,w3 = tri[1].z,tri[2].z,tri[3].z
  trimult1 = tri[1]
  trimult2 = tri[2]
  trimult3 = tri[3]
  --Projecting the triangles into normalized screenspace
  
  triProjected[1] = ((((projectionMatrix * vec(trimult1.x,trimult1.y,trimult1.z,1)).xyz)/w1)+1)*halfwidthheightvec
  triProjected[2] = ((((projectionMatrix * vec(trimult2.x,trimult2.y,trimult2.z,1)).xyz)/w2)+1)*halfwidthheightvec
  triProjected[3] = ((((projectionMatrix * vec(trimult3.x,trimult3.y,trimult3.z,1)).xyz)/w3)+1)*halfwidthheightvec
  triProjected[5]= tri[5]
  triProjected[6] = tri[6]/w1
  triProjected[7] = tri[7]/w2
  triProjected[8] = tri[8]/w3





  --adding triangles to the rasterization queue
triToRaster[#triToRaster+1] = triProjected

end
end
end
end

--ordering the triangles NOT USED ANYMORE. Possibly useful for transparency
--[[
table.sort(triToRasterSortz)
for i=0,#triToRasterSortz-1 do
  for j, zvalue2 in pairs(triToRasterz) do
  
    if triToRasterSortz[#triToRasterSortz-i] == zvalue2 then
      table.insert(triToRaster,triProjectedtbl[j])
      
    end
  end
end
]]


--clipping projected triangles against screen edges
local triToRasterDraw

triToRasterDraw = clipTriangleAgainstAllPlanes(triToRaster)

--drawing triangles
for k, triProjectedDraw in pairs(triToRasterDraw) do

--Function for drawing textured triangles
--First 3 args triangle vertices, args 4-6 uvs, 7 texture, 8 illumination(adding some other numbers to the 0 in this vector might cause discoloration or something)

drawTexturedTriangle(triProjectedDraw[1].xy:ceil(),triProjectedDraw[2].xy:ceil(),triProjectedDraw[3].xy:ceil(),triProjectedDraw[6],triProjectedDraw[7],triProjectedDraw[8],textureName,triProjectedDraw[5]*2)

--Wireframe NO DEPTH BUFFER
--[[
drawLine(triProjectedDraw[1],triProjectedDraw[2],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
drawLine(triProjectedDraw[3],triProjectedDraw[2],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
drawLine(triProjectedDraw[1],triProjectedDraw[3],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
]]


--Draws a pixel at every vertex
--[[
drawPix(triProjectedDraw[1],vec(0,0,1))
drawPix(triProjectedDraw[2],vec(0,0,1))
drawPix(triProjectedDraw[3],vec(0,0,1))
]]

end
end
--DEPTH BUFFER VISUALIZATION
--[[
for i = 1, width do
  for j = 1, height do
    Screens[1].screenText:setPixel(i-1,j-1,vectors.hsvToRGB(0,0,1-depthBuffer[i][j]/1.5))
    end
  end]]
--Updating the screen
Screens[1].screenText:update()  

--Resetting the depth buffer for the next frame
for i = 1, width do
  for j = 1, height do
    depthBuffer[i][j] = 0
  end
end
end





--