powerLevel = 10

if powerLevel > 9000 then\
	"WHOA!"\
else\
	"meh"

n = 7

if n < 0 then\
	"n is negative"\
else if n > 0 then\
	"n is positive"\
else\
	"n is zero"

aList = [1,2,3,4,5]

case aList of\
	[] -> "matches the empty list"\
	[x]-> "matches a list of exactly one item, " ++ String.fromInt x\
	x::xs -> "matches a list of at least one item whose head is " ++ String.fromInt x

case List.head aList of\
	Just x -> "The head is " ++ String.fromInt x\
	Nothing -> "The list was empty."

multiply a b =\
	a * b

multiply 7 6 

double =\
	multiply 2

answer =\
	42

List.map double (List.range 1 4) 

List.map (\a -> a * 2) (List.range 1 4) 

area (width, height) =\
	width * height

area (6, 7) 

volume {width, height, depth} =\
    (area (width, height)) * depth

volume { width = 3, height = 2, depth = 7 } 
