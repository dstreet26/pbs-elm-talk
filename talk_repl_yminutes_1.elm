1 + 1 

8 - 1 

10 * 2 

33 / 2 

33 // 2 

5 ^ 2 

not True 

not False 

1 == 1 

1 /= 1 

1 < 10 

"This is a string because it uses double quotes."

'a' 

"Hello " ++ "world!" 

["the", "quick", "brown", "fox"]

[1, 2, 3, 4, 5]

List.range 1 5

List.range 1 5 ++ List.range 6 10 == List.range 1 10 

0 :: List.range 1 5 

List.head (List.range 1 5) 

List.tail (List.range 1 5) 

List.head [] 

("elm", 42)

Tuple.first ("elm", 42) 

Tuple.second ("elm", 42) 

()

{ x = 3, y = 7 }


{ x = 3, y = 7 }.x 


.y { x = 3, y = 7 } 

person = { name = "dave"}

{ person |\
	name = "George" }

particle = {position = 100, velocity = 0, acceleration = 9.81}

{ particle |\
	position = particle.position + particle.velocity,\
	velocity = particle.velocity + particle.acceleration }

