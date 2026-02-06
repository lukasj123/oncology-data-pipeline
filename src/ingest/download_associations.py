import urllib.request
import os

# Base URL for the dataset
base_url = "http://ftp.ebi.ac.uk/pub/databases/opentargets/platform/25.12/output/association_overall_direct/"

# List of partition files (original filenames)
files = [
    "part-00000-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00001-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00002-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00003-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00004-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00005-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00006-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00007-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00008-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00009-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00010-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00011-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00012-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00013-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00014-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00015-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00016-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00017-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00018-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
    "part-00019-aaa1c63d-a07c-4486-af49-f58da5ca71d5-c000.snappy.parquet",
]

# Download each file with cleaner names
output_dir = "data/raw/direct_associations/"
for i, filename in enumerate(files):
    url = base_url + filename
    # New clean filename: association_overall_direct_1.parquet, etc.
    new_filename = f"association_overall_direct_{i+1}.parquet"
    output_path = os.path.join(output_dir, new_filename)
    print(f"Downloading {new_filename}...")
    urllib.request.urlretrieve(url, output_path)
    print(f"✓ Saved to {output_path}")

print("All files downloaded!")