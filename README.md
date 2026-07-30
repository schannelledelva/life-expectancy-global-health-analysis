# Global Health & Life Expectancy Analysis

## Project Overview
An analytical deep-dive into global life expectancy trends across 193 countries 
(2000–2015), exploring what drives health outcomes — wealth, education, or 
geography — with a focus on African nations.

Built as a full data pipeline: raw CSV → SQL Server → Power BI.

**Key Question:** Between GDP and years of schooling, which factor correlates 
more strongly with life expectancy — and does the answer differ for Africa?

---

## Business Context
This project looks at how economic wealth versus education levels affect how long people live. For organizations with limited budgets, 
knowing whether money or schooling has a bigger impact on life expectancy helps show where development resources can do the most good.

---

## Dashboard Preview

### Page 1 — Global Health Overview
![Page 1](dashboard/screenshots/page1_global_overview.png)

### Page 2 — Wealth & Health: The GDP Factor
![Page 2](dashboard/screenshots/page2_gdp_factor.png)

### Page 3 — Beyond Wealth: The Schooling Factor
![Page 3](dashboard/screenshots/page3_schooling_factor.png)

### Page 4 — Africa in Focus
![Page 4](dashboard/screenshots/page4_africa_focus.png)

### Page 5 — The Verdict: Education vs Wealth
![Page 5](dashboard/screenshots/page5_verdict_education_vs_wealth.png)
---

## Key Findings

### Global Picture
- Global average life expectancy rose from 66.85 years (2000) to 71.72 years (2015)
- The life expectancy difference gap between Developed and Developing nations is closing — but slowly
- Europe leads all continents in average life expectancy; Africa trails significantly
- Bottom 10 countries globally are all African nations

### The GDP vs Schooling Question
- **GDP correlation with Life Expectancy: 0.43** (moderate)
- **Schooling correlation with Life Expectancy: 0.57** (stronger)
- Based on these findings, years of schooling exhibits a stronger statistical
  relationship with life expectancy than economic wealth alone

## Statistical Anomalies & Model Limitations
While the general trends show a clear positive trajectory, several stark anomalies highlight the boundaries of evaluating health strictly through economic and educational lenses:
- **The Wealth Paradox (Equatorial Guinea)**: Exhibits an above-average GDP per capita but a below-average life expectancy. This may indicate high economic inequality, where resource wealth is concentrated rather than redistributed into public health infrastructure.
- **The Education Gap (Fiji, Kazakhstan, South Africa)**: These nations maintain above-average schooling years but struggle with below-average life expectancy. 
- **Analytical Limitations**: These exceptions prove that while wealth and schooling are vital drivers, they are not the sole determinants of population health. Unanalyzed external variables and localized demographic factors also play a significant role.


### Africa in Focus
- Africa's average life expectancy improved from 54.85 years (2000) to 62.84 years (2015)
- The gap between Africa and the global average narrowed from 12 years in 2000  to 8.87 years in 2015
- **Zimbabwe** leads African nations in life expectancy improvement ( 22.70 years)
- **Eritrea, Uganda, and Botswana** also show significant improvement (20+ years)
- Sierra Leone, Lesotho, and the Central African Republic remain the most at-risk African nations

---
### The Verdict: Education vs Wealth 
- Pearson correlation analysis conducted per continent across all 193 countries
- Schooling correlates more strongly with life expectancy than GDP
  in 4 out of 5 continents
- **Africa: GDP correlation = 0.31 (weak) | Schooling correlation = 0.50 (moderate)**
- Oceania shows the largest gap: Schooling (0.87) vs GDP (0.59)
- Europe is the only exception with near-identical values:
  Schooling (0.43) vs GDP (0.44)
- Caveat: correlation does not imply causation — shared underlying 
  factors may drive both variables

---

## Technical Pipeline

### 1. Data Source
- Dataset: Life Expectancy (WHO) via Kaggle
- 2,938 rows × 22 columns
- 193 countries, 2000–2015
- Source: [dataset_source.md](data/dataset_source.md)

### 2. SQL Server (T-SQL)
- Created staging table with appropriate data types per column
- Used BULK INSERT to load cleaned tab-separated data
- Built Star Schema via SQL Views:
  - `v_Dim_Geography` — country + continent lookup (surrogate key via DENSE_RANK)
  - `v_Dim_Status` — Developed/Developing classification
  - `v_Dim_Date` — year dimension
  - `v_Dim_Continent` — continent mapping for 193 countries
  - `v_Fact_LifeExpectancy` — central fact view joining all dimensions
  - `v_Most_Improved_Africa` — top 10 most improved African countries 
     by life expectancy
  - `v_Anomalies_GDP` — countries with above-average GDP but 
     below-average life expectancy
  - `v_Correlation_By_Continent` — Pearson correlation coefficients 
     per continent comparing GDP and Schooling impact on life expectancy
    
### 3. Power BI
- Connected to SQL Views (not raw staging table)
- Star Schema model with relationships on surrogate keys
- DAX measures such as:
  - Global Life Expectancy Average
  - African Average Life Expectancy
  - Africa vs Global Gap
  - GDP-Life Expectancy Correlation Coefficient 
  - Schooling-Life Expectancy Correlation Coefficient
 

---

## Tools Used
- **Python** (pandas) — column standardization and export
- **SQL Server / T-SQL** — data storage, Star Schema design, analytical queries
- **Power BI** — data modeling, DAX measures

---

## How to Reproduce
1. Download dataset from [Kaggle](data/dataset_source.md)
2. Run SQL scripts in order: `01` → `02` → `03`
3. Open Power BI and connect to your SQL Server instance
4. Load the four views as separate tables and recreate relationships

**Note:** The .pbix file connects to a local SQL Server instance.
To use it, follow the steps above then update the data source in Power BI:
Home → Transform data → Data source settings → update server name.

---

## Project Context
This project was built as part of a self-directed data analytics learning journey,
combining SQL and Power BI skills developed over self-paced studies.
