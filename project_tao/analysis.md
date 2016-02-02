##Group Project1 Part Using Python

###README
This is the Tao's summary of group prject1 using Python. It will be still updating. For now, it mainly focuses on data cleaning and processing. More visualization parts (plt or D3.js) will be added.

###Data Processing
First, take a look at `Program` and `Gender` attributes, there are some small categories that could be grouped into other categories.
```Python
#first set 'Student_ID' as table index

data = rowdata.set_index(['Student ID'])

print data['Program'].value_counts()
print data['Gender'].value_counts()

```
IDSE (master)                 54
Data Science Certification    22
Statistics (master)           17
Other masters                 11
QMSS                           2
Ph.D.                          2
Data Science                   1
PhD Biomedical Informatics     1
Applied Math                   1
QMSS (master)                  1
Ms in ds                       1
MSDS                           1
dtype: int64

he/him            80
she/her           32
doesn't matter     1
0                  1
```

```

do following data mapping. Also mapping F/T into 1/0 and confident level

```Python

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

def mapping_func(df, mapping):
  f = lambda x: mapping.get(x, x)
  return df.applymap(f)

data = mapping_func(data, mapping)
print data['Program'].value_counts()

```
IDSE (master)                 57
Data Science Certification    22
Statistics (master)           17
Other masters                 11
Ph.D.                          3
QMSS (master)                  3
Applied Math                   1
```
```

Then sum all skills and confident level to get total skill score(SkillVal) and self evaluation score(SelfVal). Adding these two columns into table. Moreover, set data['over_valuation'] = data['SelfVal'] - data['SkillVal']

```Python

by_column = data.groupby(group_mapping, axis=1)
values = by_column.sum() #dataframe
#print values
data = pd.concat([data, values], axis=1)
data['over_valuation'] = data['SelfVal'] - data['SkillVal']

```

Finally, to see the transformed data

```Python
print data.head()

```
                 Waiting List          Program      Matlab    R  Github  Excel  \
Student ID                                                                      
1                    No               IDSE (master)       0  1       0      1   
2                    No               Other masters       0  1       0      1   
3                    No  Data Science Certification       0  1       1      1   
4                    No               IDSE (master)       0  1       0      1   
5                    No               IDSE (master)       0  1       0      0

.......
                  Github Experience  SelfVal  SkillVal  over_valuation  
Student ID                                                        
1                           0        7         9              -2  
2                           1        7         7               0  
3                           2       14        15              -1  
4                           0        0         6              -6  
5                           0        7         7               0    
```

```

Try some data visualization. They following creates some interesting plots of skillset_avg_by_program, skillset_avg_by_gender, valuation_avg_by_program etc.

```Python

def get_top_amounts(data, group_key, groups):
  skillset_avg_by_program = pd.DataFrame()
  for group in groups:
    program_skill_avg = data.groupby(group_key)[group].mean()
    # program_skill_avg = program_skill_avg.order(ascending=False)
    skillset_avg_by_program = pd.concat([skillset_avg_by_program, program_skill_avg], axis=1)
    # Order totals by key in descending order
  return skillset_avg_by_program.transpose()

  skillset = ['Matlab', 'R', 'Github', 'Excel', 'SQL', 'Rstudio', 'SPSS', 'ggplot2', 'shell (terminal / command line)', 'C/C++',
              'Python', 'Stata', 'LaTeX', 'lattice', 'regular expressions (grep)', 'Sweave/knitr', 'XML', 'Web: html css js',
              'dropbox', 'google drive (formerly docs)']

  valuation = ['SelfVal', 'SkillVal', 'over_valuation']
  #over_5 = data[data['Program'].value_counts() >= 5]
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
  skillset_avg_by_gender.plot(kind='barh')
  skillset_avg_by_waitlist.plot(kind='barh')
  valuation_avg_by_program.plot(kind='barh')
  valuation_avg_by_gender.plot(kind='barh')
  valuation_avg_by_waitlist.plot(kind='barh')
  plt.show()

```

The visualization results are shows as following. Notes that to let visualization makes more sense, we excluded some small categories whose count is less than 5.

Average score of each skill by program. We can see many info from this picture. For example: the majority uses R and RStudio before; Data Sciene and stats masters has stronger background in C/C++ because some of them are from China where C/C++ is a required course for them in their undergraduate. Students from Data Science Certification are more likely to have background in some industry skills such as XML, dropbox, and Excel. Stats students do not so much programming background in python, command line, css (cs skills).
![pic1](/images/figure_1.png)

Average score of each skill by gender. Male has stronger background than female in most skills.
![pic2](/images/figure_2.png)

Average score of each skill by waiting list. People in waiting list are mostly from stats. So that is why they have stronger stats background but weaker programming background.
![pic3](/images/figure_3.png)

Interesting plots for self evaluation and confident level by program. We can see that stats people are likely to over evaluate themselves but data science students are modest. Just for fun.
![pic4](/images/figure_4.png)

plots for self evaluation and confident level by gender. Male intends to under evaluate themselves.
![pic5](/images/figure_5.png)

plots for self evaluation and confident level by gender. People in waiting list are mostly from stats and here waiting list people (yes in plot) intends to be over confident. The same result as above.
![pic6](/images/figure_6.png)
