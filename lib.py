"""
"""
import sys, re

BIG = 1E30

def cat(v,dec=3):
  "Pretty print. Hide pirvate slots (those starting with '_')."
  it = type(v)
  inf = float('inf')
  def ok(s): return not str(s).startswith("_")
  if it is list:  return "{" + ", ".join(map(cat, v)) + "}"
  if it is float: return str(int(v)) if -inf<v<inf and v==int(v) else f"{v:.{dec}g}"
  if it is dict:  return cat([f":{k} {cat(w)}" for k, w in v.items() if ok(k)])
  if it in [type(abs), type(cat)]: return v.__name__ + '()'
  return str(v)

def coerce(z):
  "Atom to thing."
  try: return int(z)
  except:
    try: return float(z)
    except: 
      z = z.strip()
      return {'True':True, 'False':False}.get(z,z)

class o:
  "Class with simple inits. Can pretty print itself."
  __init__ = lambda i,*d: i.dict.update(**d)
  __repr__ = cat

def settings(s):
  "Returns a setting for each 'x=y' string within 's'."
  return o(**{k:coerce(v) for k,v in re.findall(r"(\w+)=(\S+)", s)})

def cli(d):
  "Updated d's slots from  command line."
  for n,arg in enumerate(sys.argv):
    for key in d:
      if arg == "-"+key[0]: 
        d[key] = coerce(sys.argv[n+1])
  return d

def main(oConfig, fns):
  "Update settings from CLI, run any eg functions."
  cli(oConfig.__dict__)
  for arg in sys.argv:
    if (fn := fns.get(f"eg{arg.replace('-', '_')}")):
      random.seed(oConfig.__dict__.get("seed",1234567891))
      fn() 


