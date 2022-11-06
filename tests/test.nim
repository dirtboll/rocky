import unittest, rocky

test "aabb-aabb intersects":
  let aabb1 = aabb(-2f, -2, -2, 4, 4, 4)
  let aabb2 = aabb(0f, 0, 0, 4, 4, 4)
  check aabb1.intersects(aabb2) == true

test "aabb-aabb not intersects":
  let aabb1 = aabb(-2f, -2, -2, 4, 4, 4)
  let aabb2 = aabb(2.0001f, 0, 0, 4, 4, 4)
  check aabb1.intersects(aabb2) == false

test "sphere-sphere intersects":
  let sphere1 = sphere(-2f, -2, -2, 4)
  let sphere2 = sphere(0f, 0, 0, 4)
  check sphere1.intersects(sphere2) == true

test "sphere-sphere not intersects":
  let sphere1 = sphere(-2f, 0, 0, 2)
  let sphere2 = sphere(2.0001f, 0, 0, 2)
  check sphere1.intersects(sphere2) == false

test "aabb-sphere intersects":
  let aabb1 = aabb(-2f, -2, -2, 4, 4, 4)
  let sphere1 = sphere(0f, 0, 0, 2)
  check aabb1.intersects(sphere1) == true