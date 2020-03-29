#Nolen Young, 11517296
#Not fully working but very close
#------------------------- 10% -------------------------------------
# The operand stack: define the operand stack and its operations
opstack = []

# now define functions to push and pop values to the top of to/from the top of the stack (end of the list). Recall that `pass` in Python is a space holder: replace it with your code.

def opPop():
	return opstack.pop()

def opPush(value):
	opstack.append(value)

# Remember that there is a Postscript operator called "pop" so we choose different names for these functions.

#-------------------------- 20% -------------------------------------
# The dictionary stack: define the dictionary stack and its operations

dictstack = []

# now define functions to push and pop dictionaries on the dictstack, to define name, and to lookup a name

def dictPop():
	return dictstack.pop()
# dictPop pops the top dictionary from the dictionary stack.

def dictPush(): 
	dictstack.append(opPop())

def dictPush(d):
	dictstack.append(d)
#dictPush pushes a new dictionary to the dictstack. Note that, your interpreter will call dictPush only when Postscript “begin” operator is called. “begin” should pop the empty dictionary 
#from the opstack and push it onto the dictstack by calling dictPush. You may either pass this dictionary (which you popped from opstack) to dictPush as a parameter or just simply push a new empty dictionary in dictPush.

def define(name, value):
	temp = dictstack[len(dictstack)-1]
	temp[name] = value
#add name:value to the top dictionary in the dictionary stack. (Keep the ‘/’ in name when you add it to the top dictionary) Your psDef function should pop the name and value from operand stack and call the “define” function.

def lookup(name,style):
	if style == 'dynamic':
		end = len(dictstack)-1
	elif style =='static':
		dic = dictstack[-1]
		if name in dic.keys():
			return (dic[name],len(dictstack)-1)
		end = currentmap
	for i in range(end+1):
		dic = dictstack[end-i]
		if name in dic.keys():
			return (dic[name],end-i)
	return ('cannot find the name',0)
# return the value associated with name.
# What is your design decision about what to do when there is no definition for
# name? If “name” is not defined, your program should not break, but should
# give an appropriate error message.

#--------------------------- 15% -------------------------------------
# Arithmetic and comparison operators: define all the arithmetic and comparison operators here -- add, sub, mul, div, eq, lt, gt
#Make sure to check the operand stack has the correct number of parameters and types of the parameters are correct. 
def add ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, int) and isinstance(var2, int):
			var1 = opPop()
			var2 = opPop()
			opPush(var1+var2)
			return var1+var2
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
			
def sub ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, int) and isinstance(var2, int):
			var1 = opPop()
			var2 = opPop()
			opPush(var2-var1)
			return var2-var1
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
			
def mul ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, int) and isinstance(var2, int):
			var1 = opPop()
			var2 = opPop()
			opPush(var2*var1)
			return var2*var1
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
			
def div ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, int) and isinstance(var2, int):
			var1 = opPop()
			var2 = opPop()
			opPush(var2/var1)
			return var2/var1
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
	
def mod ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, int) and isinstance(var2, int):
			var1 = opPop()
			var2 = opPop()
			opPush(var2%var1)
			return var2%var1
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
	
def eq ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if type(var1) == type(var2):
			opPush(var1 == var2)
			return var1==var2
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
	
def lt ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if type(var1) == type(var2):
			opPush(var1 > var2)
			return var1 > var2
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
	
def gt ():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if type(var1) == type(var2):
			opPush(var1 < var2)
			return var1 < var2
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
#--------------------------- 15% -------------------------------------
# Array operators: define the array operators length, get
def length():
	if len(opstack >= 1):
		var1 = opstack[len(opstack)-1]
		if isinstance(var1, list):
			temp = len(opPop())
			opPush(temp)
			return temp
		else:
			print("Error: operand is not an array")
	else:
		print("Error: not enough operands on stack")
	return None

def get():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, int) and isinstance(var2, list):
			var1 = opPop()
			var2 = opPop()
			opPush(var2[var1])
			return var2[var1]
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
#--------------------------- 15% -------------------------------------
# Boolean operators: define the boolean operators psAnd, psOr, psNot Remember that these take boolean operands only. Anything else is an error
def psAnd():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, bool) and isinstance(var2, bool):
			var1 = opPop()
			var2 = opPop()
			opPush(var1 and var2)
			return var1 and var2
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
	
def psOr():
	if len(opstack) >= 2:
		var1 = opstack[len(opstack)-1]
		var2 = opstack[len(opstack)-2]
		if isinstance(var1, bool) and isinstance(var2, bool):
			var1 = opPop()
			var2 = opPop()
			opPush(var1 or var2)
			return var1 or var2
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None
	
def psNot():
	if len(opstack) >= 1:
		var1 = opstack[len(opstack)-1]
		if isinstance(var1, bool):
			var1 = opPop()
			opPush(not var1)
			return not var1
		else:
			print("Error: incompatable types")
	else:
		print("Error: not enough operands on stack")
	return None

#--------------------------- 25% -------------------------------------
# Define the stack manipulation and print operators: dup, exch, pop, copy, clear, stack
def dup():
	if len(opstack) >= 1:
		var1 = opstack[len(opstack)-1]
		opPush(var1)
	else:
		print("Error: not enough operands on stack")
	return None
	
def exch():
	if len(opstack) >= 2:
		var1 = opPop()
		var2 = opPop()
		opPush(var1)
		opPush(var2)
	else:
		print("Error: not enough operands on stack")
	return None
		
def pop():
	if len(opstack) >= 1:
		opPop()
	else:
		print("Error: not enough operands on stack")
	return None

def roll():
	op2 = opPop()
	op1 = opPop()
	if ((type(op2) is not int) or (type(op1) is not int)):
		print('Error in roll: parameter should be int')
		opPush(op1)
		opPush(op2)
		return
	if (op1 > len(opstack)) or (op1<0):
		print('Error in roll: out of bound')
		opPush(op1)
		opPush(op2)
		return
	pos = op1-op2
	objs = opstack[-op2:]
	opstack[-op2:] = []
	for ele in objs:
		opstack.insert(-pos,ele)
	pass
		
def copy():
	if len(opstack) >= 2:
		n = opPop();
		if isinstance(n, int):
			temp = []
			for i in range(n):
				temp.append(opPop())
			for i in range(n):
				opPush(temp.pop())
		else:
			print("Error: incompatable operands")
	else:
		print("Error: not enough operands on stack")
	return None

def clear():
	opstack.clear()
	return None
	
def stack():
	for i in range(len(opstack)):
		print(opstack[i])
	return None

#--------------------------- 20% -------------------------------------
# Define the dictionary manipulation operators: psDict, begin, end, psDef
# name the function for the def operator psDef because def is reserved in Python.
# Note: The psDef operator will pop the value and name from the opstack and call your own "define" operator (pass those values as parameters). Note that psDef()won't have any parameters.

def psDict():
	if len(opstack) >= 1:
		opPop()
		dictstack.append({})
	else:
		print("Error: not enough operands on stack")
	return None

def begin():
	if len(opstack) >= 1:
		var1 = opstack[len(opstack)-1]
		if isinstance(var1, dict):
			dictPush(opPop())
	else:
		print("Error: not enough operands on stack")
	return None
	
def end():
	dictPop()
	
def psDef():
	if len(opstack) >= 2:
		value = opPop()
		key = opPop()
		define(key, value)
	else:
		print("Error: not enough operands on stack")
	return None

#--------------------------- TEST FUNCTIONS -----------------------------------
# Include your test functions here
def testAdd():
	opPush(1)
	opPush(2)
	add()
	return (opPop() == 3)
	
def testSub():
	opPush(2)
	opPush(1)
	sub()
	return (opPop() == 1)
	
def testMul():
	opPush(4)
	opPush(3)
	mul()
	return(opPop() == 12)
	
def testDiv():
	opPush(12)
	opPush(3)
	div()
	return(opPop() == 4)
	
def testEq():
	opPush(4)
	opPush(4)
	eq()
	return (opPop() == True)
	
def testLt():
	opPush(2)
	opPush(4)
	lt()
	return (opPop() == True)
	
def testGt():
	opPush(4)
	opPush(2)
	gt()
	return (opPop() == True)
	
def testLength():
	opPush([1,2,3,4])
	length()
	return (opPop() == 4)
	
def testPsAnd():
	opPush(True)
	opPush(True)
	psAnd()
	return (opPop())
	
def testPsOr():
	opPush(True)
	opPush(False)
	psOr()
	return(opPop())
	
def testPsNot():
	opPush(False)
	psNot()
	return(opPop())
	
def testpsDef():
	opPush("\n1")
	opPush(3)
	psDef()
	return (lookup("n1", "static") == 3)
	


##----------------------------------------Part 2----------------------------------------##
	
import re
def tokenize(s):
	return re.findall("/?[a-zA-Z][a-zA-Z0-9_]*|[[][a-zA-Z0-9_\s!][a-zA-Z0-9_\s!]*[]]|[-]?[0-9]+|[}{]+|%.*|[^ \t\n]", s)

def groupMatching(it): 
	res = [] 
	for c in it: 
		if c=='}': 
			#res.append(')') 
			return res 
		elif c=='{': 
			res.append(groupMatching(it)) 
		else:
			res.append(c)
	return res

def check(tokens):
	count = 0
	for c in tokens:
		if c=='{':
			count +=1
		elif c=='}':
			count =count-1
			if count <0:
				return False
	return True


def parse(tokens):
	if check(tokens):
		return groupMatching(iter(tokens))
	return False



functions = {'add':add,'sub':sub,'mul':mul,'div':div,'mod':mod,'exch':exch,'def':psDef,'roll':roll,'stack':stack,'clear':clear}

def str2float(c):
	try:
		a = float(c)
		return a
	except:
		return c

def interpret(code,style):
	for c in code:
		print(c)
		if isinstance(c,list):
			opPush(c)
		elif c == 'if':
			op2 = pop()
			op1 = pop()
			if isinstance(op2,list) and op1:
				interpret(op2,style)
			else:
				opPush(op1)
				opPush(op2)
		elif c == 'ifelse':
			op3 = pop()
			op2 = pop()
			op1 = pop()
			if isinstance(op3,list) and isinstance(op2,list):
				if op1:
					interpret(op2,style)
				else:
					interpret(op3,style)
			else:
				opPush(op1)
				opPush(op2)
				opPush(op3)
		elif c in functions.keys():
			func = functions[c]
			func()
		else:
			(b,num) = lookup(c, style)
			if b == 'cannot find the name':
				opPush(str2float(c))
			elif isinstance(b,list):
				currentmap = num
				funpush =(num)
				interpret(b,style)
				funpop()
			else:
				opPush(b)
				
				
def interpreter(s,style):
	interpret(parse(tokenize(s)),style)

##-------------------------------Test--------------------------------------##

if __name__ == '__main__':
	input1 = """
	 /square {
	 dup mul
	 } def
	 (square)
	 4 square
	 dup 16 eq
	 {(pass)} {(fail)} ifelse
	 stack
	"""
	tokenize(input1)
	parse(tokenize(input1))

	input2 ="""
	(facto) dup length /n exch def
	/fact {
	 0 dict begin
	 /n exch def
	 n 2 lt
	 { 1}
	 {n 1 sub fact n mul }
	 ifelse
	 end
	} def
	n fact stack
	"""
	tokenize(input2)
	parse(tokenize(input2))

	input3 = """
	 /fact{
	 0 dict
	 begin
	 /n exch def
	1
	n -1 1 {mul} for
	 end
	 } def
	 6
	 fact
	 stack
	"""
	tokenize(input3)
	parse(tokenize(input3))

	input4 = """
	/lt6 { 6 lt } def
	1 2 3 4 5 6 4 -3 roll
	dup dup lt6 {mul mul mul} if
	stack
	clear
	"""
	tokenize(input4)
	parse(tokenize(input4))
	input5 = """
	 (CptS355_HW5) 4 3 getinterval
	 (355) eq
	 {(You_are_in_CptS355)} if
	 stack
	 """
	tokenize(input5)
	parse(tokenize(input5))

	input6 = """
	 /pow2 {/n exch def
	 (pow2_of_n_is) dup 8 n 48 add put
	 1 n -1 1 {pop 2 mul} for
	 } def
	 (Calculating_pow2_of_9) dup 20 get 48 sub pow2
	 stack
	 """
	tokenize(input6)
	parse(tokenize(input6))

	print(interpreter(input1, "static"))
	
# if __name__ == '__main__':
	# # add you test functions to this list along with suitable names
	# testCases = [('add', testAdd()), ('sub', testSub()), ('mul', testMul()), ('div', testDiv()), ('eq', testEq()), ('lt', testLt()), ('gt', testGt()), ('length', testLength()), ('psAnd', testPsAnd()), 
	# ('testPsOr', testPsOr()), ('psNot', testPsNot()), ('psDef', testpsDef())]
	
	# failedTests = [testName for (testName, testProc) in testCases if not testProc()]
	# if failedTests:
		# return ('Some tests failed', failedTests)
	# else:
		# return ('All tests OK') 



