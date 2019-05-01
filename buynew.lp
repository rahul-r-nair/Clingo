#script (python)
import clingo
from clingo import Function
import re

def main(prg):
    prg.configuration.solve.models = 0
    
    prg.ground([("base",[])])
    goal = 's'

    while goal != 'T':
        input = raw_input('Proposal:\n')
        match = re.search(r'{([\w]+)},{([\w\s,]*)},{([\w\s,]*)}',input)
        G = match.group(1)
        S = match.group(2)
        R = match.group(3)

        price = check_G(G,prg)
        if price == 'lowest':
            k = False
            maker = check_SM(R,prg)
            if maker == 'C':
                product = check_SP(R,prg)
                if product == 'A':
                    prg.assign_external(Function("rule",[6]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif product == 'B':
                    prg.assign_external(Function("rule",[6]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif product == 'e':
                    print 'Please give an available product(product_A/product_B)'
            elif maker == 'D':
                product = check_SP(R,prg)
                if product == 'A':
                    prg.assign_external(Function("used",[6]), True)
                    prg.assign_external(Function("rule",[7]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif product == 'B':
                    prg.assign_external(Function("used",[6]), True)
                    prg.assign_external(Function("rule",[7]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif product == 'e':
                    print 'Please give an available product(product_A/product_B)'
            elif maker == 'e':
                print 'Please give an available maker(maker_C/maker_D)'
            if k: goal = 'T'
        elif price == 'low':
            k = False
            maker = check_SM(R,prg)
            if maker == 'C':
                product = check_SP(R,prg)
                if product == 'A':
                    prg.assign_external(Function("used",[6]), True)
                    prg.assign_external(Function("used",[7]), True)
                    prg.assign_external(Function("rule",[8]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif product == 'B':
                    prg.assign_external(Function("used",[6]), True)
                    prg.assign_external(Function("used",[7]), True)
                    prg.assign_external(Function("rule",[8]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif product == 'e':
                    print 'Please give an available product(product_A/product_B)'
            elif maker == 'D':
                product = check_SP(R,prg)
                if product == 'A':
                    print '{low_price},{not_student},{product_A, maker_C, quality} OR'
                    print '{low_price},{not_student},{product_A, maker_D, quality}'
                elif product == 'B':
                    print '{low_price},{not_student},{product_B, maker_C, quality} OR'
                    print '{low_price},{not_student},{product_B, maker_D, quality}'
                elif product == 'e':
                    print 'Please give an available product(product_A/product_B)'
            elif maker == 'e':
                print 'Please give an available maker(maker_C/maker_D)'
            if k: goal = 'T'
        elif price == 'high':
            k = False
            product = check_SP(R,prg)
            if product == 'A':
                maker = check_SM(R,prg)
                if maker == 'C':
                    print '{low_price},{not_student},{product_A, maker_C, quality} OR'
                    print '{low_price},{not_student},{product_A, maker_D, quality}'
                elif maker == 'D':
                    print '{low_price},{not_student},{product_A, maker_D, quality} OR'
                    print '{low_price},{not_student},{product_A, maker_C, quality}'
                elif maker == 'e':
                    print 'Please give an available maker(maker_C/maker_D)'
            elif product == 'B':
                maker = check_SM(R,prg)
                if maker == 'C':
                    print '{low_price},{not_student},{product_B, maker_C, quality} OR'
                    print '{low_price},{not_student},{product_B, maker_D, quality}'
                elif maker == 'D':
                    print '{low_price},{not_student},{product_B, maker_D, quality} OR'
                    print '{low_price},{not_student},{product_B, maker_C, quality}'
                elif maker == 'e':
                    print 'Please give an available maker(maker_C/maker_D)'
            elif product == 'e':
                    print 'Please give an available product(product_A/product_B)'
            if k: goal = 'T'
        elif price == 'e':
            print 'No such price! Please give a valid price(high_price/low_price/lowest_price)'

def check_G(G,prg):
    if G == 'high_price':
        p = 'high'
    elif G == 'low_price':
        p = 'low'
    elif G == 'lowest_price':
        p = 'lowest'
    else:
        p = 'e'
    return p

def check_SP(S,prg):
    strings = S.split(", ")
    if strings[0] == 'product_A':
        prg.assign_external(Function("product_A"), True)
        q = 'A'
    elif strings[0] == 'product_B':
        prg.assign_external(Function("product_B"), True)
        q = 'B'
    else: q = 'e'
    return q

def check_SM(S,prg):
    strings = S.split(", ")
    if strings[1] == 'maker_C':
        prg.assign_external(Function("maker_C"), True)
        r = 'C'
    elif strings[1] == 'maker_D':
        prg.assign_external(Function("maker_D"), True)
        r = 'D'
    else: q = 'e'
    if strings[2] == 'quality':
        prg.assign_external(Function("quality"), True)
    return r

def prin(m):
    print 'insert'
    str_x = " ".join(map(str, m.symbols(shown=True)))
    print 'ans:'
    print str_x
    print '\n'
    return True

#end.

#external quality.
#external product_A.
#external product_B.
#external maker_C.
#external maker_D.
#external used(6;7;8).
#external rule(6;7;8).
