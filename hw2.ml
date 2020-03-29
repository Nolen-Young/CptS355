(*Nolen Young, ML Homework 2*)
(*Really cant figure this out, looking for partial credit*)

(*1.a*)
fun numbersToSum sum [] = []
|	numbersToSum sum (x::rest) = if (sum - x) < 1 then []
		else x::numbersToSum (sum - x) rest;

(*b*)
fun numbersToSum sum [] = []
|	numbersToSum sum (x::rest) = if (sum - x) < 1 then []
		else x::numbersToSum (sum - x) rest;

(*2*)
fun partition F L = 
	let
		fun countInList [] n = 0
		|	countInList (x::rest) n = if n = x 
				then (countInList rest n) + 1
				else countInList rest n
		
		fun listDiff ([], L2) = []
		|	listDiff (x1::rest1, L2) = if countInList rest1 x1 < countInList L2 x1
				then listDiff (rest1, L2)
				else x1::listDiff (rest1, L2)
	in
		((List.filter F L), (listDiff(L, List.filter F L)))
	end;

(*3 NOT WORKING*)
fun areAllUnique L =
	let
		fun countInList [] n = 0
		|	countInList (x::rest) n = if n = x 
				then (countInList rest n) + 1
				else countInList rest n

	in
		 if (List.filter (fn => if x > 1 then false else true) (List.map (countInList L) L)) != [] then false
			else true
	end;
	
(*4.a*)
fun sum [] = []
|	sum L = foldl (fn (x,acc) => x + acc) 0 (List.map (List.foldl (fn (x,acc) => x + acc) 0) L);

(*5.a*)
datatype 'a Tree = LEAF of 'a | NODE of 'a * ('a Tree) * ('a Tree);

fun depthScan LEAF(v) = v::[]
|	depthScan NODE(v, t1, t2) = v::NODE(v, depthScan t1, depthScan t2);