# Nolen Young
from functools import reduce


def main():
	print(testBusStops())
	print(testAddDict())
	print(testAddDictN())
	print(testSearchDicts())
	print(testSearchDicts2())
	print(testSubsets())
	print(testNumPaths())
	print(testIterPrimes())
	print(testNumbersToSum())

#1
def busStops(b):
	result = {}
	for bus, stops in b.items():
		for stop in stops:
			if stop in result.keys():
				if not(bus in result[stop]):
					result[stop].append(bus)
			else:
				result[stop] = [bus]
				
	return result
	
def testBusStops():
	buses = {
		"Lentil": ["Chinook", "Orchard", "Valley", "Emerald","Providence",
		"Stadium", "Main", "Arbor", "Sunnyside", "Fountain", "Crestview",
		"Wheatland", "Walmart", "Bishop", "Derby", "Dilke"],
		"Wheat": ["Chinook", "Orchard", "Valley", "Maple","Aspen", "TerreView",
		"Clay", "Dismores", "Martin", "Bishop", "Walmart", "PorchLight",
		"Campus"],
		"Silver": ["TransferStation", "PorchLight", "Stadium",
		"Bishop","Walmart", "Shopco", "RockeyWay"],
		"Blue": ["TransferStation", "State", "Larry", "TerreView","Grand",
		"TacoBell", "Chinook", "Library"],
		"Gray": ["TransferStation", "Wawawai", "Main", "Sunnyside","Crestview",
		"CityHall", "Stadium", "Colorado"]
	}
	if (sorted(busStops(buses)) != sorted({'Arbor': ['Lentil'], 'TransferStation': ['Silver', 'Blue', 'Gray'], 'Martin': ['Wheat'], 'Valley': ['Wheat', 'Lentil'], 'Crestview': ['Lentil', 'Gray'], 'Stadium': ['Lentil', 'Silver', 'Gray'], 'RockeyWay': ['Silver'], 'Chinook': ['Wheat', 'Lentil', 'Blue'], 'Aspen': ['Wheat'], 'CityHall': ['Gray'], 'Emerald': ['Lentil'], 'Dismores': ['Wheat'], 'Main': ['Lentil', 'Gray'], 'Bishop': ['Wheat', 'Lentil', 'Silver'], 'Sunnyside': ['Lentil', 'Gray'], 'Fountain': ['Lentil'], 'Campus': ['Wheat'], 'State': ['Blue'], 'Colorado': ['Gray'], 'Providence': ['Lentil'], 'Grand': ['Blue'], 'Derby': ['Lentil'], 'Library': ['Blue'], 'Wheatland': ['Lentil'], 'TacoBell': ['Blue'], 'Walmart': ['Wheat', 'Lentil', 'Silver'], 'Dilke': ['Lentil'], 'Orchard': ['Wheat', 'Lentil'], 'Larry': ['Blue'], 'TerreView': ['Wheat', 'Blue'], 'Maple': ['Wheat'], 'PorchLight': ['Wheat', 'Silver'], 'Wawawai': ['Gray'], 'Shopco': ['Silver'], 'Clay': ['Wheat']})):
		return False
	if (busStops({}) != {}):
		return False
		
	return True
	
#2.a
def addDict(d):
    result = {}
    for x in d.values():
        for i,j in x.items():
            if i in result:
                result[i] = result[i] + j
            else:
                result[i] = j
    return result

def testAddDict():
    d = {'355':{'Mon':3,'Wed':2,'Sat':2},'360':{'Mon':3,'Tue':2,'Wed':2,'Fri':10},'321':{'Tue':2,'Wed':2,'Thu':3},'322':{'Tue':1,'Thu':5,'Sat':2}}
    if addDict({}) != {}:
        return False
    if dict(sorted(list(addDict(d).items()))) != {'Fri': 10, 'Mon': 6, 'Sat': 4,'Thu': 8, 'Tue': 5, 'Wed': 6}:
        return False
    return True

#2.b
def addDictN(L):
	def addDictTogether(x,y):
		for i, j in x.items():
			for k, l in y.items():
				if i == k:
					x[i] = j+l
		return x
	if L == {}:
		result = {}
	else:
		result = []
		result = list(map(addDict, L))
		result = dict(reduce(addDictTogether, result))
	return result

def testAddDictN():
	l = [{'355':{'Mon':3,'Wed':2,'Sat':2},'360':{'Mon':3,'Tue':2,'Wed':2,'Fri':10},'321':{'Tue':2,'Wed':2,'Thu':3},'322':{'Tue':1,'Thu':5,'Sat':2}},{'322':{'Mon':2},'360':{'Thu':2, 'Fri':5},'321':{'Mon':1, 'Sat':3}},{'355':{'Sun':8},'360':{'Fri':5},'321':{'Mon':4},'322':{'Sat':3}}]
	if addDictN({}) != {}:
		return False
	if dict(sorted(list(addDictN(l).items()))) != {'Tue': 5, 'Wed': 6, 'Thu': 10, 'Mon': 13, 'Sat': 10, 'Fri': 20}:
		return False
	return True
	
#3.a
def searchDicts(L,K):
	for i in reversed(L):
		if K in i:
			return i[K]
	return None
	
def testSearchDicts():
	l = [{"x":1,"y":True,"z":"found"},{"x":2},{"y":False}]
	if searchDicts(l, "x") != 2:
		return False
	if searchDicts(l, "y") != False:
		return False
	return True
	
#3.b
def searchDicts2(tL, k):
    count = len(tL) - 1
    def lookupVal2Helper(tL, k, listindex):
        if listindex == 0:
            return tL[listindex][1].get(k)
        
        if tL[listindex][1].get(k) is not None:
            return tL[listindex][1].get(k)
        else:
            return lookupVal2Helper(tL,k,tL[listindex][0])
                                    
    return lookupVal2Helper(tL, k, count)

def testSearchDicts2():
    l = [(0,{"x":0,"y":True,"z":"zero"}),(0,{"x":1}),(1,{"y":False}),(1,{"x":3, "z":"three"}),(2,{})]
    if searchDicts2(l, "x") != 1:
        return False
    if searchDicts2(l, "y") != False:
        return False
    return True	
	
#4
def subsets(set):
	return sorted(subsetsHelper([], sorted(set)), key = len)
    
def subsetsHelper(result, set):
	if set:
		return subsetsHelper(result, set[1:]) + subsetsHelper(result + [set[0]], set[1:])
		
	return [result]
	
def testSubsets():
	if subsets([1,2,3]) != [[],[3],[2],[1],[2,3],[1,3],[1,2],[1,2,3]]:
		return False
	if subsets([(1,"one"),(2,"two")]) != [[],[(2,"two")],[(1,"one")],[(1,"one"),(2,"two")]]:
		return False
	if subsets([]) != [[]]:
		return False
	return True
	
#5
def numPaths(m, n):
	return numPathsHelper(m-1, n-1)

def numPathsHelper(m, n):
	if m == 0 and n == 0:
		return 1
	elif m > 0 and n == 0:
		return numPathsHelper(m-1, n)
	elif m == 0 and n > 0:
		return numPathsHelper(m, n-1)
	else: #they are both > 0
		return numPathsHelper(m-1, n) + numPathsHelper(m, n-1)
		
def testNumPaths():
	if numPaths(2,2) != 2:
		return False
	if numPaths(3,3) != 6:
		return False
	if numPaths(4,5) != 35:
		return False
	return True
	
#6
class iterPrimes():
    def __init__(self):
        self.next_number = 2

    def __iter__(self):
        return self

    def isPrime(self, number):
        if number in (2, 3):
            return True

        if number % 2 == 0:
            return False

        for i in range(2, number):
            if number % i == 0:
                return False
        return True

    def __next__(self):
        number = self.next_number
        while not self.isPrime(number):
            number += 1

        self.next_number = number + 1
        return number

    next = __next__
		
def testIterPrimes():
	primes = iterPrimes()
	if primes.__next__() != 2:
		return False
	if primes.__next__() != 3:
		return False
	if primes.__next__() != 5:
		return False
	return True
	
def numbersToSum(iNumbers, sum):
	result = []
	while sum > 0:
		num = iNumbers.__next__()
		sum -= num
		if sum > 0:
			result.append(num)
		print(result)
	
	return result
	
def testNumbersToSum():
	primes = iterPrimes()
	if numbersToSum(primes, 58) != [2, 3, 5, 7, 11, 13]:
		return False
	if numbersToSum(primes, 100) != [19, 23, 29]:
		return False
	return True

if __name__ == "__main__":
	main()

