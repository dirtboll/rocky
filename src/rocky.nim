import vmath

type
  AABB*[T] = object
    x*: T
    y*: T
    z*: T
    w*: T
    h*: T
    d*: T

  Sphere*[T] = object
    x*: T
    y*: T
    z*: T
    radius*: T
  
proc aabb*[T](x, y, z, h, w, d: T): AABB[T] =
  result.x = x
  result.y = y
  result.z = z
  result.h = h
  result.w = w
  result.d = d

proc aabb*[T](minPos, maxPos: GVec3[T]): AABB[T] {.inline.} =
  result.x = minPos.x
  result.y = minPos.y
  result.z = minPos.z
  result.h = maxPos.x - minPos.x
  result.w = maxPos.y - minPos.y
  result.d = maxPos.z - minPos.z

template minX*[T](a: AABB[T]): T = a.x
template minY*[T](a: AABB[T]): T = a.y
template minZ*[T](a: AABB[T]): T = a.z
template maxX*[T](a: AABB[T]): T = a.x + a.w
template maxY*[T](a: AABB[T]): T = a.y + a.h
template maxZ*[T](a: AABB[T]): T = a.z + a.d

proc sphere*[T](x, y, z, radius: T): Sphere[T] {.inline.} =
  result.x = x
  result.y = y
  result.z = z
  result.radius = radius

proc sphere*[T](pos: GVec3[T], radius: T): Sphere[T] {.inline.} = 
  result.x = pos.x
  result.y = pos.y
  result.z = pos.z
  result.radius = radius

template pos*[T](a: AABB[T] or Sphere[T]): GVec3[T] =
  gvec3(a.x, a.y, a.z)

proc intersects*[T](a, b: AABB[T]): bool {.inline.} =
  a.minX <= b.maxX and
  a.maxX >= b.minX and
  a.minY <= b.maxY and
  a.maxY >= b.minY and
  a.minZ <= b.maxZ and
  a.maxZ >= b.minZ

proc intersects*[T](a: AABB[T], b: GVec3[T]): bool {.inline.} =
  b.x <= a.maxX and
  b.x >= a.minX and
  b.y <= a.maxY and
  b.y >= a.minY and
  b.z <= a.maxZ and
  b.z >= a.minZ

proc intersects*[T](a, b: Sphere[T]): bool {.inline.} =
  let distance = sqrt(
    (a.x - b.x) * (a.x - b.x) +
    (a.y - b.y) * (a.y - b.y) +
    (a.z - b.z) * (a.z - b.z)
  )
  result = distance < a.radius + b.radius

proc intersects*[T](a: Sphere[T], b: GVec3[T]): bool {.inline.} =
  let distance = sqrt(
    (a.x - b.x) * (a.x - b.x) +
    (a.y - b.y) * (a.y - b.y) +
    (a.z - b.z) * (a.z - b.z)
  )
  result = distance < a.radius

proc intersects*[T](a: AABB[T], b: Sphere[T]): bool {.inline.} =
  let x = max(a.minX, min(b.x, a.maxX))
  let y = max(a.minY, min(b.y, a.maxY))
  let z = max(a.minZ, min(b.z, a.maxZ))

  b.intersects(gvec3(x,y,z))