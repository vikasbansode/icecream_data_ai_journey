from pathlib import Path
import pandas as pd
from datetime import datetime

BASE=Path(__file__).resolve().parents[1]
DATA=BASE/"data"
OUT=BASE/"output"
OUT.mkdir(exist_ok=True)

def quality_gate(df):
    checks={
        "rows_gt_zero":len(df)>0,
        "transaction_id_not_null":df.transaction_id.notna().all(),
        "transaction_id_unique":df.transaction_id.is_unique,
        "sales_non_negative":df.sales_amount.ge(0).all(),
    }
    if not all(checks.values()):
        raise ValueError(f"Quality gate failed: {checks}")

def main():
    sales=pd.read_csv(DATA/"fact_sales.csv")
    products=pd.read_csv(DATA/"dim_product.csv")
    quality_gate(sales)
    report=(sales.merge(products,on="product_id",validate="many_to_one")
              .groupby(["product_id","product_name","category"],as_index=False)
              .agg(sales=("sales_amount","sum"),units=("quantity","sum"),profit=("profit","sum"))
              .sort_values("sales",ascending=False))
    report.to_csv(OUT/"daily_product_sales.csv",index=False)
    pd.DataFrame([{
      "run_id":datetime.now().isoformat(timespec="seconds"),
      "status":"SUCCESS","input_rows":len(sales),"output_rows":len(report)
    }]).to_csv(OUT/"run_log.csv",index=False)

if __name__=="__main__": main()
