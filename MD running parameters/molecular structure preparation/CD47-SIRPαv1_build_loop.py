from modeller import *
# Load the AutoModel class
from modeller.automodel import * 
from modeller import soap_loop 
from modeller import selection

log.verbose() # 记录日志
env = environ() # 创建MODELLER环境
env.io.atom_files_directory = ['.'] # 搜寻文件文件夹

# 保留水分子,HETATM残基
env.io.hetatm = True  
env.io.water = True

# 对model过程中和loop细化过程中进行残基选择, 仅选择的残基才会进行建模
class MyModel(loopmodel):
    def special_patches(self, aln):
        # Rename both chains and renumber the residues in each
        self.rename_segments(segment_ids=['A', 'B', 'A', 'B'],
                             renumber_residues=[1, 1, 2001, 2001])
    def select_atoms(self):
        # Residue index starts from 1, not 0
        return selection(
                        self.residue_range('1:A', '2:A')                        
                        )
    def select_loop_atoms(self):
        return selection(
                        self.residue_range('1:A', '2:A')                        
                        )

code = '4cmm'
m = MyModel(env,
            alnfile  = code + '.ali',
            knowns   = code,
            sequence = code + '_fixed')

# 建模数量loop细化数目
m.starting_model = 1 
m.ending_model = 1
m.md_level = None

m.loop.starting_model = 1 # 第一个loop模型
m.loop.ending_model = 500 # 最后一个loop模型
m.loop.md_level = refine.slow  # loop精炼水平

# 建模后数据分析
# assess.GA341, assess.DOPE, assess.DOPEHR, assess.normalized_dope, soap_loop.Scorer()
m.loop.assess_methods = (assess.DOPE, assess.DOPEHR, soap_loop.Scorer())

m.make()

#获取所有成功模型
ok_models = [x for x in m.loop.outputs if x['failure'] is None]

for key in ['molpdf', 'DOPE score', 'DOPE-HR score', 'SOAP-Loop score']:
    try:
        ok_models.sort(key=lambda x: x[key])
    except:
        ok_models.sort(lambda x, y: cmp(x[key], y[key]))
        
    # 获取最高打分模型
    top = ok_models[0] 
    print("Model with the lowest %s: %s, %f" % (key, top['name'], top[key]))
