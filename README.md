# Paysim Fraud Analysis (SQLite)
## Overview
This project analyzes simulated mobile money transactions to identify patterns associated with fraudulent behavior using SQLite and DBeaver.

## Dataset
- The analysis uses the PaySim dataset, a simulated mobile money transaction dataset containing approximately 6 million records. Each row represents a single transaction with details on transaction type, amount, account balances, and a fraud indicator. The dataset is simulated and commonly used for fraud detection practice.
- Source: https://www.kaggle.com/datasets/ealaxi/paysim1

## Tools Used
- SQLite, DBeaver, Excel
  
## Questions Explored
1. How common is fraud overall?
2. Which transaction types are most fraud-prone?
3. Are larger transactions riskier?
4. Are balance inconsistencies associated with fraud?
5. Which destination accounts receive repeated fraudulent transactions and how much?
6. Do the hours that have the most transactions mean they have the most fraud cases?

## Key Findings
- Fraud presents ~0.13% of all transactions, confirming a strong class imbalance.
- Transfer transactions show the highest fraud rate and should be prioritized for monitoring.
- Large transactions are significantly more likely to be fraudulent than small or medium ones.
- Balance inconsistencies are highly correlated with fraud and represent a strong detection signal.
- Fraud activity occurs in short, concentrated time bursts rather than evenly over time.
- Repeated fraud appears among destination accounts, while no origin accounts repeat fraud more than once in this dataset.
- High transaction volume does not necessarily indicate higher fraud risk.

### Fraud Risk by Transaction Type
![Fraud by Type](screenshot/03_risk_by_type.png)

### Fraud vs Transaction Volume
![Volume vs Fraud](screenshot/08_volume_vs_fraud.png)

## How to Run
- Download the dataset from Kaggle
- Import CVS into SQLite (DBeaver)
- Open queries.sql and run queries top to bottom

## Repo structure
- queries.sql = analysis
- *.png = screenshots showing query results
- README.md = project overview and findings

## Limitation
- Data is simulated. Results show patterns in Paysim simulation, not real bank data.



