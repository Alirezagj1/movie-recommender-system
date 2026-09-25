Movie Recommender System

An end-to-end movie recommendation system built with Python, SQL Server, Machine Learning, and PyTorch using the MovieLens 25M dataset.

The project implements and compares:

- Collaborative Filtering — Matrix Factorization with PyTorch
- Content-Based Filtering — TF-IDF using movie genres and user-generated tags
- Hybrid Recommendation — combination of collaborative and content-based signals

Dataset

The project uses the "MovieLens 25M" (https://grouplens.org/datasets/movielens/) dataset from GroupLens.

Statistic| Value
Ratings| 25,000,095
Users| 162,541
Movies| 62,423
Movies with ratings| 59,047
Rating range| 0.5–5.0
Average rating| 3.53
Rating sparsity| ~99.74%

The raw dataset is not included in this repository.

Approach

Collaborative Filtering

A PyTorch Matrix Factorization model learns latent representations for users and movies from explicit ratings.

Evaluation:

- MAE
- RMSE
- Precision@10
- Recall@10

Content-Based Filtering

Movie genres and user-generated tags are transformed into TF-IDF representations. User profiles are constructed from previously rated movies.

Hybrid Recommendation

Collaborative Filtering and Content-Based scores are normalized and combined using a weighting parameter selected on validation data.

Workflow

MovieLens 25M
      │
      ▼
Data Exploration & Validation
      │
      ▼
SQL Server
      │
      ▼
Feature Engineering
      │
      ├───────────────────┐
      ▼                   ▼
Collaborative        Content-Based
Filtering             Filtering
      │                   │
      └─────────┬─────────┘
                ▼
         Hybrid Recommender
                │
                ▼
         Top-N Recommendation
                │
                ▼
            Evaluation
          ┌─────┴─────┐
          ▼           ▼
    Random Split  Temporal Split

Results

Two evaluation protocols were used: a random split and a temporal split.

Evaluation| Model| MAE| RMSE| Precision@10| Recall@10
Random| CF| 0.6939| 0.9012| 0.0980| 0.0417
Random| Content-Based| —| —| 0.0566| 0.0409
Random| Hybrid| —| —| 0.1222| 0.0579
Temporal| CF| 0.6730| 0.9010| 0.0450| 0.0191
Temporal| Content-Based| —| —| 0.0310| 0.0176
Temporal| Hybrid| —| —| 0.0530| 0.0220

For Top-N evaluation, ratings of 4.0 or higher were treated as relevant.

The temporal split uses ratings before 2018 for training, 2018 for validation, and 2019 onward for testing. Pre-2018 tags were used for the temporal Content-Based model to reduce future-information leakage.

The temporal Top-N evaluation was performed on a selected set of 100 warm-start users. The temporal CF model was trained using a 2-million-rating sample due to CPU constraints.

Project Structure

movie-recommender-system/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── 01_data_exploration.ipynb
│   └── 03_modeling.ipynb
│
├── sql/
│   ├── schema.sql
│   └── feature_engineering.sql
│
├── .gitignore
├── requirements.txt
└── README.md

Tech Stack

- Python
- Pandas / NumPy
- Scikit-learn
- PyTorch
- SQL Server
- SQLAlchemy / PyODBC
- Jupyter
- Matplotlib / Seaborn
- Git / GitHub

Limitations

- The dataset is highly sparse.
- Random splitting can introduce temporal leakage.
- Temporal Top-N evaluation uses a limited user sample.
- The temporal CF model uses a sampled training set because of CPU limitations.
- Offline metrics do not directly measure real-world user satisfaction.
- Cold-start users and movies remain challenging for collaborative filtering.

Status

Completed

Future improvements could include more advanced ranking models, implicit-feedback methods, better cold-start handling, GPU training, and additional ranking metrics.

Author

Alireza Gorji

MSc Information Technology — E-commerce