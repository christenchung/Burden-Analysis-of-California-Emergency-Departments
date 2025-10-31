# Burden Analysis of California Emergency Departments 2021-2023

## Project Background

Fortunately, emergency departments/rooms in the United States treat all patients regardless of insurance or payment. ERs have been crucial for all patients, including those who are unable to seek or afford timely medical care often due to systemic health disparities. However, this strains ERs due to limited treatment stations and resources. Health care workers begrudgingly find themselves in conditions where they are forced to stretch limited resources thinly amongst their ever-increasing patient load - patients who are emergent and non-emergent. This leads to rapid burn out, further exacerbating available skill and resources. In California ERs, supply (ER resources and beds) and demand (patient visits) have been increasingly disproportionate. Using [ER data from California Health and Human Services](https://data.chhs.ca.gov/dataset/emergency-department-volume-and-capacity/resource/929362c5-513b-4e89-8a9e-b34834a3004d?view_id=26ff11c1-af4d-4c9a-900c-c7ed3f30cfd4), I analyze statewide ER burden with particular aim to guide decision making of resource allocation and health disparity. 

## Executive Summary 

Analysis of 12,000+ records from 2021-2023 demonstrates that California ERs are facing increasing burden (quantified as visits per treatment beds). ER beds and resources are unable to support the increasing number of patient visits. Burden is especially exacerbated in urban, non-profit hospitals and in areas with health care shortages. Top counties facing increasing burden include Los Angeles, San Bernardino, San Diego, Alameda, Santa Clara, San Joaquin, Fresno, Kern, Sacramento, Monterey, Ventura, Sonoma, and Contra Costa. Hypertension, diabetes, mental health, and substance abuse are the leading contributors to ER burden despite not being emergent. Ironically, the lowest contributors of ER burden are emergent such as respiratory, sepsis, stroke, and cardiac diagnoses. Therefore, there is significant demand for healthcare services and supporting services amongst California non-profit ERs within these counties. Addressing aforementioned chronic diseases can ameliorate ER burden.

## Insights

#### Burden Trends 

* There was a yearly average of about 10 million visits and 7K treatment beds 
* In just 2 years, ER burden increased by 17%. While ER visits increased by 22%, ER beds only had a net increase of 7%.
* In 2023, beds decreased by 1% and ER count decreased by 2%. The decrease in beds coupled with increasing visits exacerbated ER burden. 
* Compared to bed and ER count, ever-increasing visit count influenced burden the most.
* Non-profit ERs face the most burden while government ERs face the least.
* Extending access to health care and increasing resources for ERs may improve ER burden
* Further analysis of 2023 may reveal why ER burden has been worsening 
<img width="402" height="788" alt="Screenshot 2025-10-24 at 5 07 27 PM" src="https://github.com/user-attachments/assets/12b77ce0-f29d-44e1-98a9-2e42b7c909f2" />
<img width="574" height="806" alt="Screenshot 2025-10-24 at 5 07 36 PM" src="https://github.com/user-attachments/assets/52dcd065-46ee-4a18-8110-d1134b66a22d" />

#### Burden by Disease  

* Chronic factors contribute to highest ER burden, such as hypertension, diabetes, mental health, substance abuse, active COVID-19, homeless, and obesity.
* Emergent diseases contribute the least burden and include respiratory, sepsis, stroke, and cardiac
* Addressing chronic diseases and social determinants of health (homelessness, substance abuse, mental health) can alleviate ER burden 
<img width="492" height="310" alt="Screenshot 2025-10-24 at 4 52 55 PM" src="https://github.com/user-attachments/assets/9ba32148-8f7d-4e43-919e-8748fc3a7ecd" /> 

#### Regional Hotspots  

*  Top 10 counties facing highest ER burden include: Los Angeles, San Bernardino, Riverside, Orange, San Diego, Alameda, Santa Clara, San Joaquin, Fresno, and Kern.
*  ER burden is most pronounced in Southern California.
* Los Angeles County ERs experience the highest burden and has 7 ERs consistently ranked as most burdened year after year.
* Top burdened counties facing increasing yearly burden include Los Angeles, San Bernardino, San Diego, Alameda, Santa Clara, San Joaquin, Fresno, Kern, Sacramento, Monterey, Ventura, Sonoma, and Contra Costa
* Half of the top 25% burdened ERs are in areas facing health care disparity. This increased in 2023. Since this is during the end of the COVID pandemic, the increase in visits especially warrants further investigation
* Urban ERs face the highest burden compared to rural or frontier ERs. Of the top 25% burdened ERs, 80% are urban. 
<img width="1340" height="460" alt="Screenshot 2025-10-28 at 12 00 36 PM" src="https://github.com/user-attachments/assets/0c17bffa-3cbe-49a2-b7b1-ec77e1483010" />
<img width="1327" height="536" alt="Screenshot 2025-10-28 at 12 00 48 PM" src="https://github.com/user-attachments/assets/5d59c953-6cfe-4d2b-89f7-a1a312439f3b" />

#### Hospital Comparison

* Certain ERs rank as highest burdened year after year. This demonstrates unrelentingly high visit to bed ratios that have gone untreated. 
* Addressing burden in these ERs/in surrounding areas - and extending these measures statewide - could effectively improve California's ER burden. 
* Los Angeles County ERs are the highest burdened each year, with burden ratios significantly surpassing all others in California. These ERs include: Torrance Memorial, Providence Holy Cross, Monterey Park Hospital, Memorial Hospital of Gardena, MLK Jr. Community Hospital, Lakewood Regional, and Antelope Valley Hospital.
* The second most persistently burdened ERs are in San Bernardino County: Community Hospital of San Bernardino and Chino Valley Medical Center. 
<img width="1205" height="650" alt="Screenshot 2025-10-28 at 12 35 19 PM" src="https://github.com/user-attachments/assets/3a0c8e5b-1ff8-43e4-9d36-3aebfeda072a" />

#### Recommendations 

* Promote programs coordinating care of chronic diseases for patients suffering from homelessness, mental health problems, and substance abuse 
* Conduct further analysis behind causes of increasing ER visits, specifically after 2022
* Direct resources and health care services to non-profit ERs in urban areas where demand is high 
* Streamline ER processes to maximize efficiency (examples: merging patient records/EMR documents, optimize triage processes, and have case managers coordinate follow up care for chronic diseases at discharge)

#### Data Query and Visualization
* I used SQL for data cleaning, querying, and understanding. To visualize data, I used Tableau to compliment analysis obtained from SQL querying.
* I downloaded [this dataset](https://data.chhs.ca.gov/dataset/emergency-department-volume-and-capacity/resource/929362c5-513b-4e89-8a9e-b34834a3004d?view_id=26ff11c1-af4d-4c9a-900c-c7ed3f30cfd4) as a database called "VolumeCapacity".
* SQL query can be found [here](https://github.com/christenchung/Burden-Analysis-of-California-Emergency-Departments/blob/590b1180013e6c8eb22cb4de5ceddbce0721df72/data%20query.sql). 
* ER burden dashboard can be found [here](https://public.tableau.com/views/ERBurdenOverall/DASH1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link). 

