import urllib.request
import os

# URL for the biomarkers dataset
url = "http://ftp.ebi.ac.uk/pub/databases/opentargets/platform/25.12/output/evidence_cancer_biomarkers/part-00000-ed2a6582-5984-4c42-8789-f5f8bfd10c82-c000.snappy.parquet"

# Output location
output_dir = "data/raw/evidence_cancer_biomarkers/"
filename = "evidence_cancer_biomarkers.parquet"
output_path = os.path.join(output_dir, filename)

print(f"Downloading {filename}...")
urllib.request.urlretrieve(url, output_path)
print(f"✓ Saved to {output_path}")