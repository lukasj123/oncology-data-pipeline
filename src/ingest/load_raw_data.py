import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine
import logging
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Suppress SQLAlchemy verbose output
logging.getLogger('sqlalchemy.engine').setLevel(logging.WARNING)

# Database connection from environment variables
db_user = os.getenv('POSTGRES_USER')
db_password = os.getenv('POSTGRES_PASSWORD')
db_host = os.getenv('POSTGRES_HOST')
db_port = os.getenv('POSTGRES_PORT')
db_name = os.getenv('POSTGRES_DB')

engine = create_engine(f'postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}')

# Load associations (all partitions)
print("Loading associations...")
associations_dir = Path('data/raw/direct_associations')
association_files = sorted(associations_dir.glob('*.parquet'))

a_df = pd.concat([pd.read_parquet(f) for f in association_files], ignore_index=True)
a_df.to_sql('associations', engine, schema='raw', if_exists='replace', index=False, chunksize=1000)
print(f"✓ Loaded {len(a_df):,} association records\n")

# Load biomarkers
print("Loading biomarkers...")
b_df = pd.read_parquet('data/raw/evidence_cancer_biomarkers/evidence_cancer_biomarkers.parquet')
print(f"  Shape: {b_df.shape[0]:,} rows, {b_df.shape[1]} columns")

# Simplify complex columns to text
print("  Converting complex columns...")
for col in ['literature', 'urls', 'biomarkers', 'qualityControls']:
    if col in b_df.columns:
        b_df[col] = b_df[col].astype(str)

print("  Inserting into Postgres...")
b_df.to_sql('biomarkers', engine, schema='raw', if_exists='replace', index=False, chunksize=100)
print(f"✓ Loaded {len(b_df):,} biomarker records\n")

print("✓ All raw data loaded successfully!")