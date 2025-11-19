# Burden Analysis of California Emergency Departments 2021-2023

## Table of Contents 
- [Project Background](#project-background) <br>
- [Executive Summary](#executive-summary) <br>
- [Insights](#insights) <br>
  - [Burden Trends](#burden-trends) <br>
  - [Burden by Disease](#burden-by-disease) <br>
  - [Regional Hotspots](#regional-hotspots) <br>
  - [Hospital Comparison](#hospital-comparison) <br>
- [Recommendations](#recommendations) <br>
- [Assumptions and Caveats](#assumptions-and-caveats) <br>
- [Data Query and Visualization](#data-query-and-visualization)

## Project Background

Fortunately, ERs provide medical care to patients who otherwise face systemic health disparities. However, there exists a disproportionate relationship between increasing demand (patient visits) versus supply (medical care). ER burden has been worsening, due to policies that have more to do with bureaucracy than medicine. This leads to burnout, misdistribution of resources, and threatens the well-being of patients and health care workers. Using [ER data from California Health and Human Services](https://data.chhs.ca.gov/dataset/emergency-department-volume-and-capacity/resource/929362c5-513b-4e89-8a9e-b34834a3004d?view_id=26ff11c1-af4d-4c9a-900c-c7ed3f30cfd4), I analyze statewide ER burden to promote guided decision making.

## Executive Summary 

Analysis of 12,000+ records from 2021-2023 demonstrates that California ERs are facing increasing burden. Burden is especially exacerbated in urban, non-profit hospitals in areas facing health care shortages. Highest burden is concentrated in Southern California, with Los Angeles County ERs at the top. Chronic diseases and social problems contribute the most burden, rather than emergencies. ER burden can be improved through initiatives addressing chronic diseases, social problems, and resource disparity in urban areas by non-profit ERs. 

## Insights

#### Burden Trends 

* In just 2 years, ER burden increased by 17%. While ER visits increased by 22%, ER beds only had a net increase of 7%.
* There may be a relatively stronger correlation between burden and ED visits versus burden and bed availability. However, these correlations are very weak and may be insignificant. 
* Non-profit ERs face the most burden while government ERs face the least.
* Further research of increasing visit count may point to contributing factors of ER burden  
<img width="402" height="788" alt="Screenshot 2025-10-24 at 5 07 27 PM" src="https://github.com/user-attachments/assets/12b77ce0-f29d-44e1-98a9-2e42b7c909f2" />
<img width="574" height="806" alt="Screenshot 2025-10-24 at 5 07 36 PM" src="https://github.com/user-attachments/assets/52dcd065-46ee-4a18-8110-d1134b66a22d" />

#### Burden by Disease  

* Chronic factors and social problems contribute the highest ER burden (such as hypertension, diabetes, mental health, substance abuse, active COVID-19, homeless, obesity)
* Emergencies contribute the least burden (such as respiratory, sepsis, stroke, and cardiac)
* Hypertension, diabetes, mental health, and substance abuse are the leading contributors to ER burden despite not being emergent. Ironically, the lowest contributors of ER burden are emergent such as respiratory, sepsis, stroke, and cardiac diagnoses. 
* Addressing chronic diseases and social determinants of health (homelessness, substance abuse, mental health) can alleviate ER burden
<img width="492" height="310" alt="Screenshot 2025-10-24 at 4 52 55 PM" src="https://github.com/user-attachments/assets/9ba32148-8f7d-4e43-919e-8748fc3a7ecd" /> 

#### Regional Hotspots  

* Top 5 counties facing highest ER burden include: Los Angeles, San Bernardino, Riverside, Orange, and San Diego. ER burden is most pronounced in Southern California.
* Los Angeles County ERs experience the highest burden and consists of 7 ERs with the highest burden year after year.
* Top burdened counties facing increasing yearly burden include Los Angeles, San Bernardino, and San Diego.
* Half of the top burdened ERs happen to be in areas facing health care disparity.
* Urban ERs face the highest burden. Of the top 25% burdened ERs, 80% are urban compared to rural or frontier.
<img width="1340" height="460" alt="Screenshot 2025-10-28 at 12 00 36 PM" src="https://github.com/user-attachments/assets/0c17bffa-3cbe-49a2-b7b1-ec77e1483010" />
<img width="1327" height="536" alt="Screenshot 2025-10-28 at 12 00 48 PM" src="https://github.com/user-attachments/assets/5d59c953-6cfe-4d2b-89f7-a1a312439f3b" />

#### Hospital Comparison

* Certain ERs rank as highest burdened year after year. This demonstrates unrelentingly high visit to bed ratios that have gone untreated. 
* Targeting these ERs/surrounding areas could effectively improve California's ER burden. 
* Los Angeles County ERs are the highest burdened each year, with burden ratios significantly surpassing all others in California.
<img width="1205" height="650" alt="Screenshot 2025-10-28 at 12 35 19 PM" src="https://github.com/user-attachments/assets/3a0c8e5b-1ff8-43e4-9d36-3aebfeda072a" />

## Recommendations 

* Promote programs coordinating care of chronic diseases for patients suffering from homelessness, mental health problems, and substance abuse.
* Identify and re-direct non-clinical problems to appropriate social agencies. 
* Support programs that provide resources and health care services to urban areas surrounding non-profit ERs.  
* Streamline ER processes to maximize efficiency (examples: merging patient records/EMR documents, optimize triage processes, and have case managers coordinate follow up care for chronic diseases at discharge)
* Conduct further analysis of increasing ER visits, exploring causes and confounding variables.

## Assumptions and Caveats

* **Visit count:** Complex factors affect ER visit count and are unique to each hospital's policies, admitted patient turnover rate, size of inpatient beds, and more. Further analysis will aid understanding of visit trends.  
* **Health service shortages:** The degree and specifics of health care shortages are ambiguous and would benefit from further research.
* **Diagnoses:** It is unclear if the primary diagnosis was used or if other diagnoses also contributed to multiple visits.
* **COVID-19 Pandemic**: The 2020 pandemic has had lasting effects on ER burden, especially exacerbating strain in urban areas [(Richards & Derlet, 2022)](https://pmc.ncbi.nlm.nih.gov/articles/PMC9464318/). It may be beneficial to relate contributing factors to the impact of the pandemic.

## Data Query and Visualization
* I used SQL (sqlite and postgresql) and R for data cleaning, querying, and understanding. To visualize data, I used Tableau to compliment analysis obtained from queries.
* SQL query can be found [here](https://github.com/christenchung/Burden-Analysis-of-California-Emergency-Departments/blob/590b1180013e6c8eb22cb4de5ceddbce0721df72/data%20query.sql).
* R statistical analysis can be found [here](https://github.com/christenchung/Burden-Analysis-of-California-Emergency-Departments/blob/290de03a22c03c313180970a3e53c24b7bd2c6e7/R_analysis.md).
* ER burden dashboard can be found [here](https://public.tableau.com/views/ERBurdenOverall/DASH1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link). 
