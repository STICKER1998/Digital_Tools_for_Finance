import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# Read Data
csv_data = pd.read_csv('coding-environment-exercise.csv')

# Plot and Save figure
x = np.array(csv_data)[:,0]
y = np.array(csv_data)[:,1]
fig = plt.figure(dpi=128, figsize=(10, 6))
plt.plot(x,y, c='red')
fig.autofmt_xdate()
plt.savefig("/out/fig.png") 
print(x)
