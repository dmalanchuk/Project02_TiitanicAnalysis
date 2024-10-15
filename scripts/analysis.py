import matplotlib.pyplot as plt
import pandas as pd

gs = pd.read_csv('../data_source/processed/vizual.csv')


fig, ax = plt.subplots(figsize=(10, 12))
grouped_data = gs.groupby(['grouped_age', 'sex', 'pclass'])['total_survived_people'].sum().unstack(level='pclass')
grouped_data.plot(kind='bar', ax=ax)

ax.set_ylabel('Total Survived People')
plt.show()
