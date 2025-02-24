--credit 4P5 
local function getPartNbt(part)
    local guide = {}
    while part and part:getParent() do
        guide[#guide + 1] = part:getName()
        part = part:getParent()
    end
    
    local nbt = avatar:getNBT().models.chld
    for i = #guide, 1, -1 do
        for j = 1, #nbt do
            local child = nbt[j]
            if child.name == guide[i] then
                nbt = i == 1 and child or child.chld
                break
            end
        end
        if not nbt then return end
    end

    return nbt
end


--Fun.
local function whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(input)

    if math.sign(input) == -1 then
    
      return input%1024-input
    end
    return 0 
    end  
   
 
 
 
 function convertBBmodelToMesh(modelpart,meshTblIndex,textureName,facNums)
 --converting the values from NBT to vertices
 local texture = textures[textureName]
  local vertices = {}
  local partNBT = getPartNbt(modelpart)
  for i = 1, #partNBT.mesh_data.vtx , 3 do
    table.insert(vertices,vec(partNBT.mesh_data.vtx[i],partNBT.mesh_data.vtx[i+1],partNBT.mesh_data.vtx[i+2]))
  end

  --initializing tables
  local fac = partNBT.mesh_data.fac
  local curMesh = {}
  local num =1 
  local uv = partNBT.mesh_data.uvs
  --Building the triangles
  log(partNBT.mesh_data.tex,textureName.."  facNums. Put these values into their respective triangle and quad positions in the bbmodel meshes file or else the mesh wont load",partNBT.mesh_data.fac)
  for i , tex in pairs(partNBT.mesh_data.tex) do

    if tex == facNums.y then

      local tri = {}  
 
        tri[3] = vertices[fac[num]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num])]/16
        tri[8] = vec(uv[2*num-1],uv[2*num],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
   
        tri[1] = vertices[fac[num+1]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num+1])]/16
        tri[6] = vec(uv[2*num+1],uv[2*num+2],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
    
        tri[2] = vertices[fac[num+2]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num+2])]/16
        tri[7] = vec(uv[2*num+3],uv[2*num+4],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
        tri[9] = textureName

   
      table.insert(curMesh,tri)
      local tri = {}
      tri[1] = vertices[fac[num+3]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num+3])]/16
      tri[6] = vec(uv[2*num+5],uv[2*num+6],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      tri[2] = vertices[fac[num]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num])]/16
      tri[7] = vec(uv[2*num-1],uv[2*num],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      tri[3] = vertices[fac[num+2]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num+2])]/16
      tri[8] = vec(uv[2*num+3],uv[2*num+4],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      tri[9] = textureName
      table.insert(curMesh,tri)
      num = num +4
    end
    if tex == facNums.x then

      local tri = {}


      tri[3] = vertices[fac[num]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num])]/16
      tri[8] = vec(uv[2*num-1],uv[2*num],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
 
      tri[1] = vertices[fac[num+1]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num+1])]/16
      tri[6] = vec(uv[2*num+1],uv[2*num+2],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
  
      tri[2] = vertices[fac[num+2]+1+whichVertexWTFisBBsFormatHowTFdoIassignIndexesForVerticesWhenTheyAreNegativeeeeeee(fac[num+2])]/16
      tri[7] = vec(uv[2*num+3],uv[2*num+4],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      tri[9] = textureName
  
      table.insert(curMesh,tri)

      num = num +3
    end
  end


  mesh[meshTblIndex] = curMesh
end