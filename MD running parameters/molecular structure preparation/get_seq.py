from modeller import *
import sys

log.verbose()
env = environ()
env.io.hetatm = True
env.io.water = True

code = sys.argv[1]
m = model(env, file=code)
aln = alignment(env)
aln.append_model(m, align_codes=code)
aln.write(file=code+'.ali')
