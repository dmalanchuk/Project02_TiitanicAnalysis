import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

gs = pd.read_csv('../data_source/processed/vizual.csv')
res = pd.read_csv('../data_source/processed/res2.csv')

fig, ax = plt.subplots(figsize=(10, 12))
grouped_data = gs.groupby(['grouped_age', 'sex', 'pclass'])['total_survived_people'].sum().unstack(level='pclass')
grouped_data.plot(kind='bar', ax=ax)

ax.set_ylabel('Total Survived People')

# Другий графік
np.random.seed(0)
x = res['pclass']
y = res['rate']
z = res['age_with_avg']

# Створюємо DataFrame
data = pd.DataFrame({'x': x, 'y': y, 'z': z})

# Побудова графіка з трьома змінними
plt.figure(figsize=(8, 6))
scatter = plt.scatter(data['x'], data['y'], c=data['z'], cmap='viridis', s=100)
plt.colorbar(scatter, label='вік')
plt.title('Кореляційний графік з трьома змінними (x, y, z)')
plt.xlabel('клас квитка')
plt.ylabel('шанс вижити')
plt.show()
