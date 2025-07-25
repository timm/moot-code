# Contribute

- All globals settings defined in one palce (about.py)
- All files have `eg__test()` functions (so they can test themselves)
- All tests registtered globalle in a Makefile
  - `make eg32` calls python3 xxx.py `--test` calls 
- Code indented 2 spaces.
- Line width upt to 70 characters.
- Procedural style code (so optional functinality can be spread out in different files).
  - Xxx() is a constructor. Returns some of type 'o' (see lib.py).
  - xxx (or xxx1, etc) is a variable build by Xxx().
  - xxxMethod() is a method to act on xxx variables.
  - isXxx(it) returns true if it came from Xxx()
