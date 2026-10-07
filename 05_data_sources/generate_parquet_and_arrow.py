import pandas as pd
df=pd.read_csv("csv/dim_product.csv")

# Parquet
df.to_parquet("parquet/dim_product.parquet", index=False)

# Arrow IPC
import pyarrow as pa
import pyarrow.ipc as ipc
table=pa.Table.from_pandas(df)
with pa.OSFile("arrow/dim_product.arrow","wb") as sink:
    with ipc.new_file(sink, table.schema) as writer:
        writer.write_table(table)
