#Nolen Young

from functools import reduce
import random

#1.a
def addDict(d):
    result = {}
    for x in d.values():
        for i,j in x.items():
            if i in result:
                result[i] = result[i] + j
            else:
                result[i] = j
    return result

def testaddDict():
    d = {'355':{'Mon':3,'Wed':2,'Sat':2},'360':{'Mon':3,'Tue':2,'Wed':2,'Fri':10},'321':{'Tue':2,'Wed':2,'Thu':3},'322':{'Tue':1,'Thu':5,'Sat':2}}
    if addDict({}) != {}:
        return False
    if dict(sorted(list(addDict(d).items()))) != {'Fri': 10, 'Mon': 6, 'Sat': 4,'Thu': 8, 'Tue': 5, 'Wed': 6}:
        return False
    return True

#1.b

                

def addDictN(L):
    def addDictTogether(x,y):
        for i, j in x.items():
            for k, l in y.items():
                if i == k:
                    x[i] = j+l
        return x

    result = []
    result = list(map(addDict, L))
    result = dict(reduce(addDictTogether, result))
    return result

def testaddDictN():
    l = [{'355':{'Mon':3,'Wed':2,'Sat':2},'360':{'Mon':3,'Tue':2,'Wed':2,'Fri':10},'321':{'Tue':2,'Wed':2,'Thu':3},'322':{'Tue':1,'Thu':5,'Sat':2}},{'322':{'Mon':2},'360':{'Thu':2, 'Fri':5},'321':{'Mon':1, 'Sat':3}},{'355':{'Sun':8},'360':{'Fri':5},'321':{'Mon':4},'322':{'Sat':3}}]
    if addDictN({}) != {}:
        return False
    if dict(sorted(list(addDictN(l).items()))) != {'Fri': 20,'Mon': 13,'Sat': 10,'Sun': 8, 'Thu': 10, 'Tue': 5, 'Wed': 6}:
        return False
    return True

#2.a
def lookupVal(L,K):
    for i in reversed(L):
        if K in i:
            return i[K]
    return None

def testlookupVal():
    l = [{"x":1,"y":True,"z":"found"},{"x":2},{"y":False}]
    if lookupVal(l, "x") != 2:
        return False
    if lookupVal(l, "y") != False:
        return False
    return True

#2.b
def lookupVal2(tL, k):
    count = len(tL) - 1
    def lookupVal2Helper(tL, k, listindex):
        if listindex == 0:
            return tL[listindex][1].get(k)
        
        if tL[listindex][1].get(k) is not None:
            return tL[listindex][1].get(k)
        else:
            return lookupVal2Helper(tL,k,tL[listindex][0])
                                    
    return lookupVal2Helper(tL, k, count)

def testlookupVal2():
    l = [(0,{"x":0,"y":True,"z":"zero"}),(0,{"x":1}),(1,{"y":False}),(1,{"x":3, "z":"three"}),(2,{})]
    if lookupVal2(l, "x") != 1:
        return False
    if lookupVal2(l, "y") != False:
        return False
    return True

#3.
def numPaths(m, n, blocks):
    down = 0
    right = 0
    if m == 1 and n == 1:
        return 1
    if not (m - 1, n) in blocks and m - 1 > 0 and n > 0:
        down = numPaths(m-1, n, blocks)
    if not (m, n - 1) in blocks and m > 0 and n - 1 > 0:
        right = numPaths(m, n - 1, blocks)
    return down + right

def testnumPaths():
    if numPaths(2,2,[(2,1)]) != 1:
        return False
    if numPaths(10,3,[(2,2),(7,1)]) != 27:
        return False
    return True

#4.
def palindromes(S):
    results = set()
    for index, char in enumerate(S):
        start, end = index - 1, index + 1
        while start >= 0 and end < len(S) and S[start] == S[end]:
            results.add(S[start:end+1])
            start -= 1
            end += 1

        start, end = index, index + 1
        while start >= 0 and end < len(S) and S[start] == S[end]:
            results.add(S[start:end+1])
            start -= 1
            end += 1

    results=list(results)
    return results

def testpalindromes():
    if palindromes('cabbbaccab') != ['abbba', 'acca', 'baccab', 'bb', 'bbb', 'cabbbac', 'cc']:
        return False
    if palindromes('bacdcabdbacdc') != ['abdba', 'acdca', 'bacdcab', 'bdb', 'cabdbac', 'cdc', 'cdcabdbacdc','dcabdbacd']:
        return False
    return True
        

#5.a
class iterApply:
    def __init__(self, n, f):
        self.current = n
        self.func = f

    def __iter__(self):
        return self

    def next(self):
        n = self.func(self.current)
        self.current +=1
        return n

    def prev(self):
        self.current -= 1
        return self.current

#5.b
def iMerge(iNumbers1, iNumbers2, N):
    x = []
    for y in range(0, N - 1):
        one = iNumbers1.next()
        two = iNumbers2.next()
        if (one < two):
            x.append(two)
            iNumbers2.prev()
        elif (two < one):
            x.append(two)
            iNumbers1.prev()
        else:
            x.append(one)
            x.append(two)

    return x

#6.a
def streamRandoms(k, rmin, rmax):
    def compute_rest():
        return streamRandoms(random.randint(rmin, rmax), rmin, rmax)
    return Stream(k, compute_rest)

#6.b
#I cannot figure this one out
def oddStream(stream):
    if stream % 2 != 0
        return stream
        

if __name__ == '__main__':
    passedMsg = "%s passed"
    failedMsg = "%s failed"
    if testaddDict():
        print ( passedMsg % 'addDict' )
    else:
        print ( failedMsg % 'addDict')

    if testaddDictN():
        print ( passedMsg % 'addDictN' )
    else:
        print ( failedMsg % 'addDictN')

    if testlookupVal():
        print ( passedMsg % 'lookupVal' )
    else:
        print ( failedMsg % 'lookupVal')

    if testlookupVal2():
        print ( passedMsg % 'lookupVal2' )
    else:
        print ( failedMsg % 'lookupVal2')

    if testnumPaths():
        print ( passedMsg % 'numPaths' )
    else:
        print ( failedMsg % 'numPaths')

    if testpalindromes():
        print ( passedMsg % 'palindromes' )
    else:
        print ( failedMsg % 'palindromes')





















    
