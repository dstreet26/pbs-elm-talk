

fib n2 =\
	if n2 < 2 then\
		1\
	else\
		fib (n2 - 1) + fib (n2 - 2)

List.map fib (List.range 0 8) 

listLength bList =\
	case bList of\
		[] -> 0\
		x::xs -> 1 + listLength xs

cos (degrees 30) ^ 2 + sin (degrees 30) ^ 2 


