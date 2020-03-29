(*Nolen Young, 11517296, CptS 355, HW2*)
	
	
(*-----------------------------SOLUTIONS-----------------------------*)
(*1.a*)
fun merge2 [] [] = []
|	merge2 L [] = L
|	merge2 [] L = L
|	merge2 (x::restX) (y::restY) =
		if (x > y) then y::(merge2 (x::restX) restY)
			else x::(merge2 restX (y::restY));

(*1.b*)			
fun merge2Tail L1 L2 = 
	let
		fun merge2TailHelper [] [] R = rev(R)
		|	merge2TailHelper (x::rest) [] R = merge2TailHelper rest [] (x::R)
		|	merge2TailHelper [] (x::rest) R = merge2TailHelper [] rest (x::R)
		|	merge2TailHelper (x::restX) (y::restY) R = 
				if x < y then merge2TailHelper restX (y::restY) (x::R)
				else merge2TailHelper (x::restX) restY (y::R)
	in
		merge2TailHelper L1 L2 []
	end;
		
(*1.c*)
fun mergeN L = 
	let
		fun fold f base [] = base
		|	fold f base (x::rest) = f x (fold f base rest)
	in
		fold merge2 [] L
	end;
	
(*2.a*)
fun getInRange low high L = 
	let
		fun filter pred [] = []
		|	filter pred (x::rest) = if (pred x) then x::(filter pred rest)
			else (filter pred rest)
		
	in
		filter (fn x => x > low andalso x < high) L
	end;
	
(*2.b*)
fun countInRange low high L = 
	let		
		fun map f [] = []
		|	map f (x::rest) = (f x)::(map f rest)
		
	in
		foldl (fn (e, a) => length(e) + a) 0 (map (getInRange low high) L)
	end;
	
	
(*3.a*)
datatype lengthUnit = INCH of int | FOOT of int | YARD of int;

fun addLengths (INCH X) (INCH Y) = INCH (X + Y)
|	addLengths (INCH X) (FOOT Y) = INCH (X + 12 * Y)
|	addLengths (INCH X) (YARD Y) = INCH (X + 36 * Y)
|	addLengths (FOOT X) (INCH Y) = INCH (12 * X + Y)
|	addLengths (FOOT X) (FOOT Y) = INCH (12 * X + 12 * Y)
|	addLengths (FOOT X) (YARD Y) = INCH (12 * X + 36 * Y)
|	addLengths (YARD X) (INCH Y) = INCH (36 * X + Y)
|	addLengths (YARD X) (FOOT Y) = INCH (36 * X + 12 * Y)
|	addLengths (YARD X) (YARD Y) = INCH (36 * X + 36 * Y);

(*3.b*)
fun addAllLengths L = 
	let
		fun map f [] = []
		|	map f (x::rest) = (f x)::(map f rest)
		
		fun fold f base [] = base
		|	fold f base (x::rest) = f x (fold f base rest)
	in
		fold addLengths (INCH 0) (map (fold addLengths (INCH 0)) L)
	end;
	
(*4.a*)
datatype 'a Tree = LEAF of 'a | NODE of 'a * ('a Tree) * ('a Tree);

fun sumTree x = 
	let
		fun first (x,_,_) = x
		fun second (_,x,_) = x
		fun third (_,_,x) = x
		
		fun sumTreeHelper (LEAF x) = x
		|	sumTreeHelper (NODE x) = sumTreeHelper (second x) + sumTreeHelper (third x)
	in
		sumTreeHelper x
	end;

(*4.b*)
fun createSumTree x = 
	let
		fun first (x,_,_) = x
		fun second (_,x,_) = x
		fun third (_,_,x) = x
		
		fun sumTreeHelper (LEAF x) = (LEAF x)
		|	sumTreeHelper (NODE x)= NODE (((sumTree (second x)) + (sumTree (third x))), sumTreeHelper (second x), sumTreeHelper(third x))
	in
		sumTreeHelper x
	end;
	
(*5*)
datatype 'a listTree = listLEAF of ('a list) | listNODE of ('a listTree list);

fun foldListTree f base (listLEAF []) = base
|	foldListTree f base (listLEAF ((x::rest))) = f x (foldListTree f base (listLEAF rest))
|	foldListTree f base (listNODE []) = base
|	foldListTree f base (listNODE (x::rest)) =  f (foldListTree f base x) (foldListTree f base (listNODE rest));

(*-----------------------------TESTS-----------------------------*)

fun merge2Test() =
	let
		val test1 = merge2 [2,5,6,8,9] [1,3,4,5,7,8,10] = [1,2,3,4,5,5,6,7,8,8,9,10]
		val test2 = merge2 [1,2] [0,10,12] = [0,1,2,10,12]
		val test3 = merge2 [1,3,3,5,5] [~1,2,4] = [~1,1,2,3,3,4,5,5]
		val test4 = merge2 [1,2,3] [] = [1,2,3]
		val test5 = merge2 [] [3,4,5] = [3,4,5]

	in
		print("test1: " ^ Bool.toString(test1) ^ "\n" ^
			  "test2: " ^ Bool.toString(test2) ^ "\n" ^
			  "test3: " ^ Bool.toString(test3) ^ "\n" ^
			  "test4: " ^ Bool.toString(test4) ^ "\n" ^
			  "test5: " ^ Bool.toString(test5) ^ "\n")
	end;
	
val _ = merge2Test();

fun merge2TailTest() =
	let
		val test1 = merge2Tail [2,5,6,8,9] [1,3,4,5,7,8,10] = [1,2,3,4,5,5,6,7,8,8,9,10]
		val test2 = merge2Tail [1,2] [0,10,12] = [0,1,2,10,12]
		val test3 = merge2Tail [1,3,3,5,5] [~1,2,4] = [~1,1,2,3,3,4,5,5]
		val test4 = merge2Tail [1,2,3] [] = [1,2,3]
		val test5 = merge2Tail [] [3,4,5] = [3,4,5]

	in
		print("test1: " ^ Bool.toString(test1) ^ "\n" ^
			  "test2: " ^ Bool.toString(test2) ^ "\n" ^
			  "test3: " ^ Bool.toString(test3) ^ "\n" ^
			  "test4: " ^ Bool.toString(test4) ^ "\n" ^
			  "test5: " ^ Bool.toString(test5) ^ "\n")
	end;
	
val _ = merge2TailTest();

fun mergeNTest() =
	let
		val test1 = mergeN [[1,2],[10,12],[2,5,6,8,9]] = [1,2,2,5,6,8,9,10,12]
		val test2 = mergeN [[3,4],[~3,~2,~1],[1,2,5,8,9]] = [~3,~2,~1,1,2,3,4,5,8,9]
		val test3 = mergeN [[], [1,2], []] = [1,2]
		val test4 = mergeN [[1,2],[3,4]] = [1,2,3,4]
		val test5 = mergeN [[],[],[]] = []

	in
		print("test1: " ^ Bool.toString(test1) ^ "\n" ^
			  "test2: " ^ Bool.toString(test2) ^ "\n" ^
			  "test3: " ^ Bool.toString(test3) ^ "\n" ^
			  "test4: " ^ Bool.toString(test4) ^ "\n" ^
			  "test5: " ^ Bool.toString(test5) ^ "\n")
	end;
	
val _ = mergeNTest();

fun getInRangeTest() =
	let
		val test1 = getInRange 3 10 [1,2,3,4,5,6,7,8,9,10,11] = [4,5,6,7,8,9]
		val test2 = getInRange  ~5 5 [~10,~5,0,5,10] = [0]
		val test3 = getInRange ~1 1 [~2,2,3,4,5] = []
		val test4 = getInRange 3 5 [1,2,3,4] = [4]
		val test5 = getInRange 5 6 [] = []

	in
		print("test1: " ^ Bool.toString(test1) ^ "\n" ^
			  "test2: " ^ Bool.toString(test2) ^ "\n" ^
			  "test3: " ^ Bool.toString(test3) ^ "\n" ^
			  "test4: " ^ Bool.toString(test4) ^ "\n" ^
			  "test5: " ^ Bool.toString(test5) ^ "\n")
	end;
	
val _ = getInRangeTest();

fun countInRangeTest() =
	let
		val test1 = countInRange  3 10 [[1,2,3,4],[5,6,7,8,9],[10,11]] = 6
		val test2 = countInRange  ~5 5 [[~10,~5,~4],[0,4,5],[],[10]] = 3
		val test3 = countInRange 1 5 [[1,5],[1],[5],[]] = 0
		val test4 = countInRange 3 5 [[1,2,3,4,5], []] = 1
		val test5 = countInRange 4 6 [[5], []] = 1
		
	in
		print("test1: " ^ Bool.toString(test1) ^ "\n" ^
			  "test2: " ^ Bool.toString(test2) ^ "\n" ^
			  "test3: " ^ Bool.toString(test3) ^ "\n" ^
			  "test4: " ^ Bool.toString(test4) ^ "\n" ^
			  "test5: " ^ Bool.toString(test5) ^ "\n")
	end;
	
val _ = countInRangeTest();

fun addAllLengthsTest() =
	let
		val test1 = addAllLengths [[YARD 2, FOOT 1], [YARD 1, FOOT 2, INCH 10],[YARD 3]] = INCH 262
		val test2 = addAllLengths  [[FOOT 2], [FOOT 2, INCH 2],[]] = INCH 50
		val test3 = addAllLengths [] = INCH 0
		val test4 = addAllLengths [[INCH 2], [INCH 3]] = INCH 5
		val test5 = addAllLengths [[FOOT 3, FOOT 2], []] = INCH 60
		
	in
		print("test1: " ^ Bool.toString(test1) ^ "\n" ^
			  "test2: " ^ Bool.toString(test2) ^ "\n" ^
			  "test3: " ^ Bool.toString(test3) ^ "\n" ^
			  "test4: " ^ Bool.toString(test4) ^ "\n" ^
			  "test5: " ^ Bool.toString(test5) ^ "\n")
	end;
	
val _ = addAllLengthsTest();

val tree = NODE (5, NODE(3, LEAF 2, NODE (8,LEAF 6, LEAF 4)), NODE(2, NODE(0,LEAF 12, NODE (3, LEAF 8, LEAF 3)), LEAF 5));
val testListTree = listNODE([ listNODE ([ listLEAF [3,4,5],listLEAF [5,6],listNODE([listLEAF [8], listLEAF [1]]) ]),listNODE([]),listLEAF [10,9],listNODE([listLEAF [], listLEAF []]) ]);

val _ = sumTree tree;
val _ = createSumTree tree;
fun add x y = x+y;
val _ = foldListTree add 0 testListTree;





