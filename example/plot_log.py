import pandas as pd
from matplotlib import RcParams
import matplotlib.pyplot as plt

# Plot style
latex_style_cm = RcParams(
    {
        "font.family": "serif",
        "font.serif": ["Computer Modern Roman"],
        "font.size": 10,
        "text.usetex": True,
        # 'text.latex.unicode': True,
        "text.latex.preamble": ["\\usepackage{siunitx}"],
        "axes.linewidth": 0.4,
        "xtick.major.width": 0.2,
        "xtick.minor.width": 0.2,
        "ytick.major.width": 0.2,
        "ytick.minor.width": 0.2,
        "grid.linestyle": "-",
        "grid.linewidth": 0.3,
        "grid.color": [0.5] * 3,
    }
)
plt.style.use(latex_style_cm)

# Loading data
log_data = pd.read_csv("log", sep=" ").to_numpy()
t = log_data[:, 0]
depth_min = log_data[:, 1]
depth_max = log_data[:, 2]

# Plot
plt.figure()
plt.plot(t, depth_min, "-", label="min")
plt.plot(t, depth_max, "-", label="max")
plt.legend()
plt.xlabel("Time")
plt.ylabel("Depth")
plt.savefig("log.pdf")
