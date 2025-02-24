function triangleRaycast(orig, dir, v0, v1, v2)
    local EPSILON = 1e-6

    -- Find edges of the triangle
    local edge1 = {v1[1] - v0[1], v1[2] - v0[2], v1[3] - v0[3]}
    local edge2 = {v2[1] - v0[1], v2[2] - v0[2], v2[3] - v0[3]}

    -- Compute determinant
    local h = {
        dir[2] * edge2[3] - dir[3] * edge2[2],
        dir[3] * edge2[1] - dir[1] * edge2[3],
        dir[1] * edge2[2] - dir[2] * edge2[1]
    }
    local a = edge1[1] * h[1] + edge1[2] * h[2] + edge1[3] * h[3]

    -- If determinant is near zero, ray is parallel to the triangle
    if math.abs(a) < EPSILON then return false end

    local f = 1 / a
    local s = {orig[1] - v0[1], orig[2] - v0[2], orig[3] - v0[3]}
    local u = f * (s[1] * h[1] + s[2] * h[2] + s[3] * h[3])

    -- Check if intersection is outside the triangle
    if u < 0 or u > 1 then return false end

    local q = {
        s[2] * edge1[3] - s[3] * edge1[2],
        s[3] * edge1[1] - s[1] * edge1[3],
        s[1] * edge1[2] - s[2] * edge1[1]
    }
    local v = f * (dir[1] * q[1] + dir[2] * q[2] + dir[3] * q[3])

    -- Check if intersection is outside the triangle
    if v < 0 or u + v > 1 then return false end

    -- Compute t to find intersection point
    local t = f * (edge2[1] * q[1] + edge2[2] * q[2] + edge2[3] * q[3])

    -- If t is positive, ray intersects triangle
    if t > EPSILON then
        -- Calculate intersection point in world coordinates
        local intersection = vec(
            orig[1] + t * dir[1],
            orig[2] + t * dir[2],
            orig[3] + t * dir[3]
    )
        return true, intersection, t
    else
        return false
    end
end