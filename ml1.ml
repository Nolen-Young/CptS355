
(*------------------------FUNCTION DEFINITIONS-------------------------*)
(*1.a*)
fun exists (L, []) = false
|	exists (L, (x::rest)) = if x = L then true
		else exists (L, rest);

(*1.b This means that the values must be a type that supports equality testing.*)

(*2.a*)
fun listUnion [] [] = []
|	listUnion (x::rest) [] = 
		if exists(x, listUnion rest [])
		then listUnion rest []
		else x::listUnion rest []
|	listUnion [] (x::rest) = 
		if exists(x, listUnion [] rest) 
		then listUnion [] rest
		else x::listUnion [] rest
|	listUnion (x::L1) L2 = 
		if exists(x, listUnion L1 L2)
		then listUnion L1 L2
		else x::listUnion L1 L2;
	
	
(*3*)
fun replace n v [] = []
|	replace n v (x::rest) =	
		if n = 0
		then v::(replace (n-1) v rest)
		else x::(replace (n-1) v rest);
		
(*4.a*)		
fun prereqFor (l, term) =
	let
		fun first  (a, _) = a
		fun second (_, b) = b
		
		fun prereqForHelper ([], term) = []
		|	prereqForHelper ((x::rest), term) = 
				if exists (term, second x)
				then (first x)::prereqForHelper (rest, term)
				else prereqFor (rest, term);
	in
		prereqForHelper(l, term)
	end;
		
(*4.b Because the first member of the tuple in the list is not ever compared, just returned
so it just needs to be 'a and not ''a. Therefore the list produced by the function
is just an 'a list and not an ''a list as well.*)

(*5.*)
fun isPalindrome s = 
	let
		fun allToUpper L = map Char.toUpper L
		
		fun palindromeHelper [] [] = true
		|	palindromeHelper [] y = false
		|	palindromeHelper x [] = false
		|	palindromeHelper (x::restX) (y::restY) =
				if x = #" " then palindromeHelper (restX) (y::restY) else
				if y = #" " then palindromeHelper (x::restX) (restY) else
				if x <> y then false
				else palindromeHelper restX restY

	in
		palindromeHelper (allToUpper (String.explode s)) (allToUpper (rev (String.explode s)))
	end;
	
	isPalindrome "Doc note I dissent a fast never prevents a fatness I diet on cod"
(*6*)
fun groupSumtoN N L =
	let
		fun makeSublist N [] = []
		|	makeSublist N (x::rest) =
				if N-x < 0 then []
				else x::makeSublist (N-x) rest
				
		fun existsInReturn v [] = false
		|	existsInReturn v (x::rest) = 
				if exists (v, x)
				then true
				else existsInReturn v rest
				
		fun groupSumtoNHelper N [] return = return
		|	groupSumtoNHelper N (x::rest) return = 
			if existsInReturn x return
			then groupSumtoNHelper N rest return
			else groupSumtoNHelper N rest (makeSublist N (x::rest)::return)
			
		
	in
		groupSumtoNHelper N L []
	end;
	
(*------------------------TEST DEFINITIONS-------------------------*)
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

fun listUnionTest () =
	let
		val listUnionT1 = ((listUnion [1,3,4] [2,3,4,5]) = [1,2,3,4,5])
		val listUnionT2 = ((listUnion [1,1,2,3,3,3] [1,3,4,5]) = [2,1,3,4,5])
		val listUnionT3 = ((listUnion  ["a","b","c"] ["b","b","d"]) = ["a","c","b","d"])
		val listUnionT4 = ((listUnion [[1,2],[2,3]] [[1],[2,3],[2,3]]) = [[1,2],[1],[2,3]])
		val listUnionT5 = ((listUnion [true, true] [false, true]) = [false, true])
	in
		print ("\n----------------------\nexists:\n" ^
			"	test1: " ^ Bool.toString(listUnionT1) ^ "\n" ^
			"	test2: " ^ Bool.toString(listUnionT2) ^ "\n" ^
			"	test3: " ^ Bool.toString(listUnionT3) ^ "\n" ^
			"	test4: " ^ Bool.toString(listUnionT4) ^ "\n" ^
			"	test5: " ^ Bool.toString(listUnionT5) ^ "\n")
	end;
val _ = listUnionTest();
	
fun replaceTest () =
	let
		val replaceT1 = ((replace 3 40 [1, 2, 3, 4, 5, 6]) = [1,2,3,40,5,6])
		val replaceT2 = ((replace 0 "X" ["a", "b", "c", "d"]) = ["X","b","c","d"])
		val replaceT3 = ((replace  4 false [true, false, true, true, true]) = [true,false,true,true,false])
		val replaceT4 = ((replace 5 6 [1,2,3,4,5]) = [1,2,3,4,5])
		val replaceT5 = ((replace 6 7 [1,2,3,4,5]) = [[1,2,3,4,5])
	in
		print ("\n----------------------\nexists:\n" ^
			"	test1: " ^ Bool.toString(replaceT1) ^ "\n" ^
			"	test2: " ^ Bool.toString(replaceT2) ^ "\n" ^
			"	test3: " ^ Bool.toString(replaceT3) ^ "\n" ^
			"	test4: " ^ Bool.toString(replaceT4) ^ "\n" ^
			"	test5: " ^ Bool.toString(replaceT5) ^ "\n")
	end;
val _ = replaceTest();

fun prereqForTest () =
	let
		val prereqsList = [
			("Cpts122" , ["CptS121"]),
			("CptS132" , ["CptS131"]),
			("CptS223" , ["CptS122", "MATH216"]),
			("CptS233" , ["CptS132", "MATH216"]),
			("CptS260" , ["CptS223", "CptS233"]),
			("CptS315" , ["CptS223", "CptS233"]),
			("CptS317" , ["CptS122", "CptS132", "MATH216"]),
			("CptS321" , ["CptS223", "CptS233"]),
			("CptS322" , ["CptS223","CptS233"]),
			("CptS350" , ["CptS223","CptS233", "CptS317"]),
			("CptS355" , ["CptS223"]),
			("CptS360" , ["CptS223","CptS260"]),
			("CptS370" , ["CptS233","CptS260"]),
			("CptS427" , ["CptS223","CptS360", "CptS370", "MATH216", "EE234"])
			] 
		
		val prereqForT1 = ((prereqFor (prereqsList,"CptS260")) =["CptS360","CptS370"])
		val prereqForT2 = ((prereqFor (prereqsList,"CptS223")) = ["CptS260","CptS315","CptS321","CptS322","CptS350","CptS355","CptS360","CptS427"])
		val prereqForT3 = ((prereqFor  (prereqsList,"CptS355")) = [])
		val prereqForT4 = ((prereqFor (prereqsList,"MATH216")) = ["CptS223","CptS233","CptS317","CptS427"])
		val prereqForT5 = ((prereqFor (prereqsList,"CptS121")) = [["CptS122"])
	in
		print ("\n----------------------\nexists:\n" ^
			"	test1: " ^ Bool.toString(prereqForT1) ^ "\n" ^
			"	test2: " ^ Bool.toString(prereqForT2) ^ "\n" ^
			"	test3: " ^ Bool.toString(prereqForT3) ^ "\n" ^
			"	test4: " ^ Bool.toString(prereqForT4) ^ "\n" ^
			"	test5: " ^ Bool.toString(prereqForT5) ^ "\n")
	end;
val _ = prereqForTest();

fun isPalindromeTest () =
	let
		val isPalindromeT1 = ((isPalindrome "a01 02 2010A") = true)
		val isPalindromeT2 = ((isPalindrome "Doc note I dissent a fast never prevents a fatness I diet on cod") = true)
		val isPalindromeT3 = ((isPalindrome  "top cart pop tracPOT") = true)
		val isPalindromeT4 = ((isPalindrome "Yreka Bakery") = true)
		val isPalindromeT5 = ((isPalindrome "abc") = false)
	in
		print ("\n----------------------\nexists:\n" ^
			"	test1: " ^ Bool.toString(isPalindromeT1) ^ "\n" ^
			"	test2: " ^ Bool.toString(isPalindromeT2) ^ "\n" ^
			"	test3: " ^ Bool.toString(isPalindromeT3) ^ "\n" ^
			"	test4: " ^ Bool.toString(isPalindromeT4) ^ "\n" ^
			"	test5: " ^ Bool.toString(isPalindromeT5) ^ "\n")
	end;
val _ = isPalindromeTest();

fun groupSumtoNTest () =
	let
		val groupSumtoNT1 = ((groupSumtoN 15 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) = [[10],[9],[8],[6,7],[1,2,3,4,5]])
		val groupSumtoNT2 = ((groupSumtoN 11 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) = [[10],[9],[8],[7],[5,6],[1,2,3,4]])
		val groupSumtoNT3 = ((groupSumtoN 1 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) = [[],[],[],[],[],[],[],[],[],[1]])
		val groupSumtoNT4 = ((groupSumtoN 5 []) = [[]])
		val groupSumtoNT5 = ((groupSumtoN 2 [1,1,1,1,1,1,1,1,1]) = [1,1])
	in
		print ("\n----------------------\nexists:\n" ^
			"	test1: " ^ Bool.toString(groupSumtoNT1) ^ "\n" ^
			"	test2: " ^ Bool.toString(groupSumtoNT2) ^ "\n" ^
			"	test3: " ^ Bool.toString(groupSumtoNT3) ^ "\n" ^
			"	test4: " ^ Bool.toString(groupSumtoNT4) ^ "\n" ^
			"	test5: " ^ Bool.toString(groupSumtoNT5) ^ "\n")
	end;
val _ = groupSumtoNTest();