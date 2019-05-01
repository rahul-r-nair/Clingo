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
        if price == 'high':
            k = False
            product = check_SP(S,prg)
            if product == 'A':
                maker = check_SM(S,prg)
                if maker == 'C':
                    prg.assign_external(Function("rule",[1]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif maker == 'D':
                    print '{high_price},{},{product_B, maker_D,  }\n OR'
                elif maker == 'e':
                    print 'Please specify a valid maker(maker_C/maker_D).'
                    print '\n{high_price},{},{product_B, maker_D,  }\n OR'
                if k: goal = 'T'
                else:
                    print '{high_price},{},{product_A, maker_C, quality}'
            elif product == 'B':
                maker = check_SM(S,prg)
                if maker == 'C':
                    print '{high_price},{},{product_A, maker_C, quality}\n OR'
                elif maker == 'D':
                    prg.assign_external(Function("rule",[1]), True)
                    ret = prg.solve(on_model = prin)
                    if ret: k = True
                elif maker == 'e':
                    print 'Please specify a valid maker(maker_C/maker_D).'
                    print '\n{high_price},{},{product_A, maker_C, quality}\n OR'
                if k:
                    #prg.assign_external(clingo.Function("used",[1]), True)
                    goal = 'T'
                else:
                    print '{high_price},{},{product_B, maker_D,  }'
            elif product == 'e':
                print 'No such products are available! Please enter a valid product(product_A, product_B)'

        elif price == 'low':
            k = False
            product = check_SP(S,prg)
            if product == 'A':
                maker = check_SM(S,prg)
                if maker == 'C':
                    customer = check_R(R,prg)
                    if customer == 'sen':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("rule",[2]), True)
                        print 'came to senior'
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    elif customer == 'stu':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("used",[2]), True)
                        prg.assign_external(Function("rule",[3]), True)
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    elif customer == 'cshb':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("used",[2]), True)
                        prg.assign_external(Function("used",[3]), True)
                        prg.assign_external(Function("rule",[4]), True)
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    elif customer == 'csh':
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                    elif customer != 'nsst':
                        if customer != 'ns':
                            print '{low_price},{senior},{product_A, maker_C, quality}'
                        elif customer != 'nst':
                            print '{low_price},{student},{product_A, maker_C, quality}'
                    else:
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                elif maker == 'D':
                    customer = check_R(R,prg)
                    if customer == 'sen':
                        ret = prg.solve(on_model = prin)
                        print '{low_price},{senior},{product_B, maker_D,  }\n OR'
                        print '{low_price},{senior},{product_A, maker_C, quality}'
                    elif customer == 'stu':
                        ret = prg.solve(on_model = prin)
                        print '{low_price},{student},{product_B, maker_D,  }\n OR'
                        print '{low_price},{student},{product_A, maker_C, quality}'
                    elif customer == 'cshb':
                        ret = prg.solve(on_model = prin)
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }\n OR'
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                    elif customer == 'csh':
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }\n OR'
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                    elif customer != 'nsst':
                        if customer != 'ns':
                            print '{low_price},{senior},{product_B, maker_D,  }\n OR'
                            print '{low_price},{senior},{product_A, maker_C, quality}'
                        elif customer != 'nst':
                            print '{low_price},{student},{product_B, maker_D,  }\n OR'
                            print '{low_price},{student},{product_A, maker_C, quality}'
                    else:
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }\n OR'
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                elif maker == 'e':
                    print 'Please specify a valid maker(maker_C/maker_D).'
                    print '\n{low_price},{},{product_A, maker_C, quality}\n OR'
                    print '\n{low_price},{},{product_B, maker_D,  }'
                if k: goal = 'T'
            if product == 'B':
                maker = check_SM(S,prg)
                if maker == 'C':
                    customer = check_R(R,prg)
                    if customer == 'sen':
                        ret = prg.solve(on_model = prin)
                        print '{low_price},{senior},{product_B, maker_D,  }\n OR'
                        print '{low_price},{senior},{product_A, maker_C, quality}'
                    elif customer == 'stu':
                        ret = prg.solve(on_model = prin)
                        print '{low_price},{student},{product_B, maker_D,  }\n OR'
                        print '{low_price},{student},{product_A, maker_C, quality}'
                    elif customer == 'cshb':
                        ret = prg.solve(on_model = prin)
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }\n OR'
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                    elif customer == 'csh':
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }\n OR'
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                    elif customer != 'nsst':
                        if customer != 'ns' and nsn == 0:
                            print '{low_price},{senior},{product_B, maker_D,  }\n OR'
                            print '{low_price},{senior},{product_A, maker_C, quality}'
                        elif customer != 'nst' and nstd == 0:
                            print '{low_price},{student},{product_B, maker_D,  }\n OR'
                            print '{low_price},{student},{product_A, maker_C, quality}'
                    else:
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }\n OR'
                        print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                elif maker == 'D':
                    customer = check_R(R,prg)
                    if customer == 'sen':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("rule",[2]), True)
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    elif customer == 'stu':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("used",[2]), True)
                        prg.assign_external(Function("rule",[3]), True)
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    elif customer == 'cshb':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("used",[2]), True)
                        prg.assign_external(Function("used",[3]), True)
                        prg.assign_external(Function("rule",[4]), True)
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    elif customer == 'csh':
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }'
                    elif customer != 'nsst':
                        if customer != 'ns':
                            print '{low_price},{senior},{product_B, maker_D,  }'
                        elif customer != 'nst':
                            print '{low_price},{student},{product_B, maker_D,  }'
                    else:
                        print '{low_price},{cash, bargain},{product_B, maker_D,  }'
                elif maker == 'e':
                    print 'Please specify a valid maker(maker_C/maker_D).'
                    print '\n{low_price},{},{product_A, maker_C, quality}\n OR'
                    print '\n{low_price},{},{product_B, maker_D,  }'
                if k: goal = 'T'
            elif product == 'e':
                print 'No such products are available! Please enter a valid product(product_A, product_B)'
	elif price == 'lowest':
            k = False
            product = check_SP(S,prg)
            if product == 'A':
                maker = check_SM(S,prg)
                if maker == 'C':
                    print '{lowest_price},{cash, mail_list},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                elif maker == 'D':
                    print '{lowest_price},{cash, mail_list},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                elif maker == 'e':
                    print 'Please specify a valid maker(maker_C/maker_D).'
                    print '{lowest_price},{cash, mail_list},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
            elif product == 'B':
                maker = check_SM(S,prg)
                if maker == 'C':
                    print '{lowest_price},{cash, mail_list},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                elif maker == 'D':
                    customer = check_R(R,prg)
                    if customer == 'csml':
                        prg.assign_external(Function("used",[1]), True)
                        prg.assign_external(Function("used",[2]), True)
                        prg.assign_external(Function("used",[3]), True)
                        prg.assign_external(Function("used",[4]), True)
                        prg.assign_external(Function("rule",[5]), True)
                        ret = prg.solve(on_model = prin)
                        if ret: k = True
                    else:
                        print '{lowest_price},{cash, mail_list},{product_B, maker_D,  }'
                elif maker == 'e':
                    print 'Please specify a valid maker(maker_C/maker_D).'
                    print '{lowest_price},{cash, mail_list},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_B, maker_D,  } OR'
                    print '{low_price},{cash, bargain},{product_A, maker_C, quality}'
                if k: goal = 'T'
            elif product == 'e':
                print 'No such products are available! Please enter a valid product(product_A, product_B)'
        elif price == 'e':
            print 'No such price! Please give a valid price(high_price/low_price/lowest_price)'
        #goal = 'T'
                

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
        r = 'C'
    elif strings[1] == 'maker_D':
        r = 'D'
    else: r = 'e'
    return r


def check_R(R,prg):
    conditions = R.split(", ")
    ns = False
    nst = False
    c = ''
    for l in conditions:
        if l == 'senior':
            prg.assign_external(Function("senior"), True)
            c = 'sen'
            print 'senior'
        elif l == 'student':
            prg.assign_external(Function("student"), True)
            c = 'stu'
            print 'student'
        elif l == 'cash':
            prg.assign_external(Function("cash"), True)
            c = 'csh'
            print 'cash'
            if any("bargain" in l for l in conditions):
                prg.assign_external(Function("bargain"), True)
                c = 'cshb'
                print 'bargain'
            if any("mail_list" in l for l in conditions):
                prg.assign_external(Function("mail_list"), True)
                c = 'csml'
                print 'mail_list'
        if any("not_senior" in l for l in conditions):
            prg.assign_external(Function("not_senior"), True)
            ns = True
            print 'not senior'
        if any("not_student" in l for l in conditions):
            prg.assign_external(Function("not_student"), True)
            nst = True
            print 'not student'
        if ns and nst: c = 'nsst'
        elif ns: c = 'ns'
        elif nst: c = 'nst'
        if c == '':
            c = 'e'
        print c
    return c



def prin(m):
    print 'insert'
    str_x = " ".join(map(str, m.symbols(shown=True)))
    print 'ans:'
    print str_x
    print '\n'
    return True

#end.

#external product_A.
#external product_B.
#external quality.
#external used(1;2;3;4;5).
#external student.
#external senior.
#external cash.
#external bargain.
#external mail_list.
#external rule(1;2;3;4;5).
