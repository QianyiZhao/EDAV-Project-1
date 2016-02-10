'''
EDAV project 1 Spring 2016
Refrence: Python for Data Analysis

'''

from collections import *
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


def load_data(file_path):
  """
  This method reads the dataset, and returns a list of rows.
  Each row is a list containing the values in each column.
  """
  data = pd.read_csv(file_path)
  return data

def mapping_func(df, mapping):
    f = lambda x: mapping.get(x, x)
    return df.applymap(f)

#you can group by candidate name and use a variant of the top method from earlier in the chapter:
def get_top_amounts(data, group_key, groups):
  skillset_avg_by_program = pd.DataFrame()
  for group in groups:
    program_skill_avg = data.groupby(group_key)[group].mean()
    # program_skill_avg = program_skill_avg.order(ascending=False)
    skillset_avg_by_program = pd.concat([skillset_avg_by_program, program_skill_avg], axis=1)
  return skillset_avg_by_program.transpose()






rowdata = load_data('survey_cleaned.csv')

data = rowdata.set_index(['Student ID'])

# print data['Program'].value_counts()
# print data['Gender'].value_counts()
# print pd.unique(data['Github Experience'])
# print pd.unique(data['Excel'])

mapping = {'Ms in ds':'IDSE (master)',
           'Data Science':'IDSE (master)',
           'MSDS': 'IDSE (master)',
           'QMSS': 'QMSS (master)',
           'PhD Biomedical Informatics': 'Ph.D.',
           '0': 'he/him',
           'doesn\'t matter': 'she/her',
            False: 0,
            True: 1,
            'None': 0,
            'A little': 1,
            'Confident': 2,
            'Expert': 3}

data = mapping_func(data, mapping)


#to print results for debugging
# print pd.unique(data['Program'])
# print pd.unique(data['Github Experience'])
# print pd.unique(data['Excel'])
#print data.head()
#print list(data.columns.values)

group_mapping = {'Matlab': 'SkillVal', 'R': 'SkillVal', 'Github': 'SkillVal', 'Excel': 'SkillVal',
                'SQL': 'SkillVal', 'Rstudio': 'SkillVal', 'SPSS': 'SkillVal', 'ggplot2': 'SkillVal',
                'shell (terminal / command line)': 'SkillVal', 'C/C++': 'SkillVal', 'Python': 'SkillVal',
                'Stata': 'SkillVal', 'LaTeX': 'SkillVal', 'lattice': 'SkillVal', 'regular expressions (grep)': 'SkillVal',
                'Sweave/knitr': 'SkillVal', 'XML': 'SkillVal', 'Web: html css js': 'SkillVal', 'dropbox': 'SkillVal',
                'google drive (formerly docs)': 'SkillVal', 'R Experience Data Modeling': 'SelfVal',
                'R Experience Graphics': 'SelfVal', 'R Experience Advanced': 'SelfVal', 'Github Experience': 'SelfVal',
                'R Experience Reproducible document': 'SelfVal', 'Matlab Experience': 'SelfVal'}

by_column = data.groupby(group_mapping, axis=1)
values = by_column.sum() #dataframe
#print values
data = pd.concat([data, values], axis=1)
data['over_valuation'] = data['SelfVal'] - data['SkillVal']
#print data.head()


skillset = ['Matlab', 'R', 'Github', 'Excel', 'SQL', 'Rstudio', 'SPSS', 'ggplot2', 'shell (terminal / command line)', 'C/C++',
            'Python', 'Stata', 'LaTeX', 'lattice', 'regular expressions (grep)', 'Sweave/knitr', 'XML', 'Web: html css js',
            'dropbox', 'google drive (formerly docs)']

valuation = ['SelfVal', 'SkillVal', 'over_valuation']
is_program_over5 = data['Program'].value_counts() >= 5
program_over5 = is_program_over5[is_program_over5==True].index
data_program_over5 = data[data['Program'].isin(program_over5)]

skillset_avg_by_program = get_top_amounts(data_program_over5, 'Program', skillset)
skillset_avg_by_gender = get_top_amounts(data_program_over5, 'Gender', skillset)
skillset_avg_by_waitlist = get_top_amounts(data_program_over5, 'Waiting List', skillset)

valuation_avg_by_program = get_top_amounts(data_program_over5, 'Program', valuation)
valuation_avg_by_gender = get_top_amounts(data_program_over5, 'Gender', valuation)
valuation_avg_by_waitlist = get_top_amounts(data_program_over5, 'Waiting List', valuation)

# print skillset_avg_by_program
skillset_avg_by_program.plot(kind='barh')
#skillset_avg_by_gender.plot(kind='barh')
#skillset_avg_by_waitlist.plot(kind='barh')
#valuation_avg_by_program.plot(kind='barh')
#valuation_avg_by_gender.plot(kind='barh')
#valuation_avg_by_waitlist.plot(kind='barh')
plt.show()


#print pd.crosstab(data.Program, [data.Excel, data.R], margins=True)
# program = data.groupby(['Program']).size()
# sex = data.groupby(['Gender']).size()
# group2 = data.groupby(['Program', 'Gender']).count()
# print program
