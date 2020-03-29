(*"D:\\Nolen\\Documents\\Computer Science\\cpts_355\\mlp1.ml"*)

(*For some reason all of these functions work as intended when copy pasted into*)
(*the sml shell. I have no idea as to why it brings up errors when using the use command*)

(*------------------------FUNCTION DEFINITIONS-------------------------*)
(*1.a*)
fun exists (L, []) = false
|	exists (L, (x::rest)) = if x = L then true
		else exists (L, rest);
(*1.b This means that the values must be a type that supports equality testing.*)
(*1.c*)
fun countInList [] n = 0
|	countInList (x::rest) n = if n = x 
		then (countInList rest n) + 1
		else countInList rest n;
	
(*2*)
fun listDiff ([], L2) = []
|	listDiff (x1::rest1, L2) = if countInList rest1 x1 < countInList L2 x1
		then listDiff (rest1, L2)
		else x1::listDiff (rest1, L2);
	
(*3*)
fun firstN L 0 = []
|	firstN [] n = []
|	firstN (x::rest) n = x::firstN rest (n-1);

(*4.a*)
fun busFinder stop L = 
	let
		fun exists (L, []) = false
		|	exists (L, (x::rest)) = if x = L 
			then true
			else exists (L, rest)
			
		fun first (x, _) = x
		
		fun second (_, y) = y
		
		fun busHelper stop [] = []
		|	busHelper stop (x::rest) = 
			if exists(stop, second x) 
			then first x::busHelper stop rest
			else busHelper stop rest
		
	in
		busHelper stop L
	end;
(*4.b Because the types of the 'a and b' variables can be any type, they do not have to be the same type*)

(*5. The denom function recursively adds all the values up after theve been raised to the -1.*)
(*After that the denom return is also raised to the -1 to give use our final answer*)
fun parallelResistors L = 
	let
		fun underOne y = 1.0 / y
		fun denom [] = 0.0
		|	denom (x::rest) =
				underOne x + denom rest	
	in 
		underOne (denom L)
	end;

(*6*)
fun pairNright (n, L) =	
let
	fun pairHelper n buff [] = [rev(buff)]
	|	pairHelper n buff (x::rest) = if length(buff) = n
		then rev(buff)::(pairHelper n [] (x::rest))
		else (pairHelper n (x::buff) rest)
in
	pairHelper n [] L
end;

fun pairNleft (n, L) =	
let
	fun pairHelper n buff [] = [rev(buff)]
	|	pairHelper n buff (x::rest) = if length(buff) = n
		then buff::(pairHelper n [] (x::rest))
		else (pairHelper n (x::buff) rest)
in
	rev(pairHelper n [] (rev(L)))
end;







(*------------------------FUNCTION TEST DEFINITIONS-------------------------*)

(*Exists test*)
fun existsTest () =
let
	val existsT1 = (exists (1, []) = false)
	val existsT2 = (exists(1, [1,2,3]) = true)
	val existsT3 = (exists([1],[[1]]) = true)
	val existsT4 = (exists([1], [[3], [5]]) = false)
	val existsT5 = (exists("c", ["b", "c", "z"]) = true)
in
	print ("\n----------------------\nexists:\n" ^
		"	test1: " ^ Bool.toString(existsT1) ^ "\n" ^
		"	test2: " ^ Bool.toString(existsT2) ^ "\n" ^
		"	test3: " ^ Bool.toString(existsT3) ^ "\n" ^
		"	test4: " ^ Bool.toString(existsT4) ^ "\n" ^
		"	test5: " ^ Bool.toString(existsT5) ^ "\n")
end;
val _ = existsTest ();

(*countInList test*)
fun countInListTest () = 
let
	val countInListT1 = (countInList ["3","5","5","-","4","5","1"] "5" = 3)
	val countInListT2 = (countInList [] "5" = 0)
	val countInListT3 = (countInList [true, false, false, false, true, true, true] true = 4)
	val countInListT4 = (countInList [[],[1,2],[3,2],[5,6,7],[8],[]] [] = 2)
in
	print ("\n----------------------\ncountInList:\n" ^
		"	test1: " ^ Bool.toString(countInListT1) ^ "\n" ^
		"	test2: " ^ Bool.toString(countInListT2) ^ "\n" ^
		"	test3: " ^ Bool.toString(countInListT3) ^ "\n" ^
		"	test4: " ^ Bool.toString(countInListT4) ^ "\n")
end;
val _ = countInListTest ();

(*ListDiff test*)
fun listDiffTest () =
let
	val listDiffT1 = (listDiff (["a","b","c"], ["b"]) = ["a", "c"])
	val listDiffT2 = (listDiff ([1,2,3], [1,1,2]) = [3])
	val listDiffT3 = (listDiff ([1,2,2,3,3,3], [1,1,2,3]) = [2, 3, 3])
	val listDiffT4 = (listDiff ([1,2,3], []) = [1, 2, 3])
in
	print ("\n----------------------\nlistDiff:\n" ^
		"	test1: " ^ Bool.toString(listDiffT1) ^ "\n" ^
		"	test2: " ^ Bool.toString(listDiffT2) ^ "\n" ^
		"	test3: " ^ Bool.toString(listDiffT3) ^ "\n" ^
		"	test4: " ^ Bool.toString(listDiffT4) ^ "\n")
end;
val _ = listDiffTest ();

(*firstN test*)
fun firstNTest () =
let 
	val firstNT1 = ((firstN ["a", "b", "c", "x", "y"] 3) = ["a", "b", "c"])
	val firstNT2 = ((firstN [1,2,3,4,5,6,7] 4) = [1,2,3,4])
	val firstNT3 = ((firstN [1,2,3,4,5,6,7] 10) = [1,2,3,4,5,6,7])
	val firstNT4 = ((firstN [[1,2,3],[4,5],[6],[],[7,8],[]] 4) = [[1,2,3],[4,5],[6],[]]
)
in
	print ("\n----------------------\nfirstN:\n" ^
		"	test1: " ^ Bool.toString(firstNT1) ^ "\n" ^
		"	test2: " ^ Bool.toString(firstNT2) ^ "\n" ^
		"	test3: " ^ Bool.toString(firstNT3) ^ "\n" ^
		"	test4: " ^ Bool.toString(firstNT4) ^ "\n")
end;
val _ = firstNTest ();

(*busFinder test*)
fun busFinderTest () =
let    
  val buses = 
	[("Lentil",["Chinook", "Orchard", "Valley", "Emerald","Providence", "Stadium", "Main", "Arbor", "Sunnyside", "Fountain", "Crestview", "Wheatland", "Walmart", "Bishop", "Derby", "Dilke"]), 
	("Wheat",["Chinook", "Orchard", "Valley", "Maple","Aspen", "TerreView", "Clay", "Dismores", "Martin", "Bishop", "Walmart", "PorchLight", "Campus"]), 
	("Silver",["TransferStation", "PorchLight", "Stadium", "Bishop","Walmart", "Shopco", "RockeyWay"]),
	("Blue",["TransferStation", "State", "Larry", "TerreView","Grand", "TacoBell", "Chinook", "Library"]),
	("Gray",["TransferStation", "Wawawai", "Main", "Sunnyside","Crestview", "CityHall", "Stadium", "Colorado"])]
     
  val busFinderT1 = ((busFinder "Walmart" buses) = ["Lentil","Wheat","Silver"])
  val busFinderT2 = ((busFinder "Shopco" buses) = ["Silver"])
  val busFinderT3 = ((busFinder "Main" buses) = ["Lentil","Gray"])

 in 
     print ("\n----------------------\nbusFinder:\n"   ^ 
            "   test1: " ^ Bool.toString(busFinderT1) ^ "\n" ^ 
            "   test2: " ^ Bool.toString(busFinderT2) ^ "\n" ^  
            "   test4: " ^ Bool.toString(busFinderT3) ^ "\n")		
end;
val _ = busFinderTest ();

(*parallelResistors test*)
fun parallelResistorsTest () =
let
	val parallelResistorsT1 = Real.==((parallelResistors [10.0, 10.0, 10.0, 10.0]), 2.5)
	val parallelResistorsT2 = Real.==((parallelResistors [8.0, 16.0, 4.0, 16.0]), 2.0)
	val parallelResistorsT3 = Real.==((parallelResistors [5.0, 10.0, 2.0]), 1.25)
in
	print ("\n----------------------\nparallelResistors:\n" ^
		"	test1: " ^ Bool.toString(parallelResistorsT1) ^ "\n" ^
		"	test2: " ^ Bool.toString(parallelResistorsT2) ^ "\n" ^
		"	test3: " ^ Bool.toString(parallelResistorsT3) ^ "\n" )
end;
val _ = parallelResistorsTest ();

(*pairNright and pairNleft tests*)
fun pairNtest () =
let
	val pairNT1 = (pairNleft (2,[1, 2, 3, 4, 5]) = [[1], [2, 3], [4, 5]])
	val pairNT2 = (pairNright (2,[1, 2, 3, 4, 5]) = [[1, 2], [3, 4], [5]])
	val pairNT3 = (pairNleft (3,[1, 2, 3, 4, 5]) = [[2, 1], [3, 4, 5]])
	val pairNT4 = (pairNright (3,[1, 2, 3, 4, 5]) = [[1, 2, 3], [4, 5]])
in
	print ("\n----------------------\npairN:\n" ^
		"	test1: " ^ Bool.toString(pairNT1) ^ "\n" ^
		"	test2: " ^ Bool.toString(pairNT2) ^ "\n" ^
		"	test3: " ^ Bool.toString(pairNT3) ^ "\n" ^
		"	test4: " ^ Bool.toString(pairNT4) ^ "\n" )
end;
val _ = pairNtest ();