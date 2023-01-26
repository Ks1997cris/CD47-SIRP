from modeller import *
# Load the AutoModel class
from modeller.automodel import * 
from modeller import selection


log.verbose() # 记录日志
env = environ() # 创建MODELLER环境
env.io.atom_files_directory = ['.'] # 搜寻文件文件夹

# 保留水分子,HETATM残基
env.io.hetatm = True  
env.io.water = True

# 对model过程进行残基选择, 仅选择的残基才会进行建模
class MyModel(AutoModel):
    def special_patches(self, aln):
        # Rename both chains and renumber the residues in each
        self.rename_segments(segment_ids=['L', 'H', 'C', 'L','H','C'],
                             renumber_residues=[1, 1, 1, 401,401,301])
    def select_atoms(self):
        # Residue index starts from 1, not 0
        return selection(
                        self.residues['15:C']
                        )
   

code = '5tzu_fixed2901'
m = MyModel(env,
            alnfile  = code + '.ali',
            knowns   = code,
            sequence = code + '_mutation')

m.starting_model = 1 
m.ending_model = 1
m.md_level = None


# 建模后数据分析
# assess.GA341, assess.DOPE, assess.DOPEHR, assess.normalized_dope
m.assess_methods = (assess.DOPE, assess.DOPEHR)

m.make()

#获取所有成功模型
ok_models = [x for x in m.outputs if x['failure'] is None]

for key in ['molpdf', 'DOPE score', 'DOPE-HR score']:
    try:
        ok_models.sort(key=lambda x: x[key])
    except:
        ok_models.sort(lambda x, y: cmp(x[key], y[key]))
        
    # 获取最高打分模型
    top = ok_models[0] 
    print("Model with the lowest %s: %s, %f" % (key, top['name'], top[key]))
