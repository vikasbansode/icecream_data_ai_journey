"""Generate Parquet and Arrow source examples on the student's machine.
Run after: pip install pyarrow pandas
"""
from pathlib import Path
import pandas as pd
import pyarrow as pa
import pyarrow.ipc as ipc

ROOT = Path(__file__).parent / 'source_data'
product = pd.read_excel(ROOT / 'excel' / 'product_catalog.xlsx')
product.to_parquet(ROOT / 'parquet' / 'historical_product_catalog.parquet', index=False)
table = pa.Table.from_pandas(product, preserve_index=False)
with ipc.new_file(ROOT / 'arrow' / 'product_catalog.arrow', table.schema) as writer:
    writer.write(table)
print('Created Parquet and Arrow source files.')
