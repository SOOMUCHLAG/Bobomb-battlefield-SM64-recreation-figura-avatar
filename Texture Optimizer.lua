OptimizedTextures = {}
counter = 0
function optimizeTextures()
for i , bbmodelMesh in pairs(BBmodelToMesh) do
  if not OptimizedTextures[BBmodelToMesh.textureName] then
  OptimizedTextures[bbmodelMesh.textureName] = {}
  for x = 0, textures[bbmodelMesh.textureName]:getDimensions().x-1 do
    OptimizedTextures[bbmodelMesh.textureName][x] = OptimizedTextures[bbmodelMesh.textureName][x] or {}
    local bbmodopttexx =     OptimizedTextures[bbmodelMesh.textureName][x]
    for y = 0, textures[bbmodelMesh.textureName]:getDimensions().y-1 do

      bbmodopttexx[y] = textures[bbmodelMesh.textureName]:getPixel(x,y).xyz
    end
  end
  OptimizedTextures[bbmodelMesh.textureName].dimx2 = textures[bbmodelMesh.textureName]:getDimensions().x-3
  OptimizedTextures[bbmodelMesh.textureName].dimy2 = textures[bbmodelMesh.textureName]:getDimensions().x-3
end
end
end
