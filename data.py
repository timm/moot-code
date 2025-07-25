from lib import o

def Data(): return o(rows=[], cols=[])
def Sym(at=0,txt=""): return o(at=at,txt=txt,has={},w=1)
def Num(at=0,txt=" "): return o(at=at,txt=txt,lo=BIG,hi=-BIG,
                                mu=0,n=0,goal=0 if txt[0]=="-" else 1)

def isNum(col) : return hasattr(col, "mu") 
def isSym(col) : return hasattr(col, "has")
def isData(col): return hasattr(col, "rows")

def add(it, v):
  if v=="?": return v
  if isSym(it): it.has[v] = 1 + it.has.get(v, 0)
  elif isData(it):
    if it.cols: it.rows.append([add(c,v[c.at]) for c in it.cols.all])
    else: it.cols = dataHeader(v)
  else:
    it.n  += 1
    delta   = v - it.mu
    it.mu += delta / it.n
    it.lo  = min(it.lo, v)
    it.hi  = max(it.hi, v)
  return v

def adds(src,it=None):
  it = it or Num()
  for x in src: add(it,x)
  return it 

def norm(col, v): 
  return v if v=="?" or type(col) is Sym else (
        (v-col.lo)/(col.hi-col.lo + 1/BIG))
 
#---------------------------------------------------------------------
def dataClone(data, rows=[]):
  "Make new data. Copying structure of old data. Maybe add some rows."
  return adds([[col.txt for col in data.cols.all]] + rows, Data())

def dataHeader(names):
  "Crete Num and Syms from list of column names."
  cols = o(all=[], x=[], y=[], klass=None)
  for c,s in enumerate(names):
    col = Num(c, s) if s[0].isupper() else Sym(c, s)
    cols.all += [col]
    if s[-1] == "X": continue
    if s[-1] == "!": cols.klass = col
    (cols.y if s[-1] in "!-+" else cols.x).append(col)
  return cols

def dataRead(file):
  "Return a data, read from a csv file."
  data = Data()
  with open(file) as f:
    for line in f:
      line = line.strip()
      if line and not line.startswith("#"):
        add(data, [coerce(x) for x in line.split(",")])
  return data
