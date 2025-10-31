--ED visit count by year--
SELECT
    "year",
    CAST(SUM("Tot_ED_NmbVsts") AS REAL) AS 'total visits'
FROM
    "VolumeCapacity"
WHERE
    "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Average visit--
SELECT
    AVG("total_visits") AS 'yearly average visits'
FROM (
    SELECT
        "year",
        SUM("Tot_ED_NmbVsts") AS 'total_visits'
    FROM
        "VolumeCapacity"
    WHERE
        "Category" = 'All ED Visits'
    GROUP BY "year"
) AS sub;

--Bed count by year--
SELECT
    "year",
    CAST(SUM("EDStations") AS REAL) AS 'beds'
FROM
    "VolumeCapacity"
WHERE
    "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Average beds--
SELECT
    AVG("total_beds") AS 'yearly average beds'
FROM (
    SELECT
        "year",
        SUM("EDStations") AS 'total_beds'
    FROM
        "VolumeCapacity"
    WHERE
        "Category" = 'All ED Visits'
    GROUP BY "year"
) AS sub;

--Top 10 most burdened ERs in California in 2021--
SELECT DISTINCT("FacilityName2") AS 'most_burdened_2021',
    "CountyName",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS "Burden_Ratio_2021" FROM "VolumeCapacity"
WHERE
    "Category" = 'All ED Visits'
    AND "Year" = 2021
GROUP BY
    "FacilityName2"
ORDER BY
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) DESC,
    "FacilityName2" ASC
    LIMIT 10;

--Top 10 most burdened ERs in California in 2022--
SELECT DISTINCT("FacilityName2") AS 'most_burdened_2022',
    "CountyName",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS "Burden_Ratio_2021" FROM "VolumeCapacity"
WHERE
    "Category" = 'All ED Visits'
    AND "Year" = 2022
GROUP BY
    "FacilityName2"
ORDER BY
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) DESC,
    "FacilityName2" ASC
    LIMIT 10;

--Top 10 most burdened ERs in California in 2023--
SELECT DISTINCT("FacilityName2") AS 'most_burdened_2023',
    "CountyName",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS "Burden_Ratio_2021" FROM "VolumeCapacity"
WHERE
    "Category" = 'All ED Visits'
    AND "Year" = 2023
GROUP BY
    "FacilityName2"
ORDER BY
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) DESC,
    "FacilityName2" ASC
    LIMIT 10;

--Quartiles of burden ratio amongst 2021-2023--
SELECT
    ROUND(AVG("Visits_Per_Station"), 2) AS 'average burden ratio',
    (ROUND(AVG("Visits_Per_Station"), 2) / 2) * 3 AS 'top 25% burden ratio is greater than'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits';

--Top 25% persistently burdened ERs by county from 2021-2023--
SELECT
    "FacilityName2" AS 'ERs with persistent burden 2021-2023',
    "CountyName" AS 'county',
    COUNT("FacilityName2") AS 'years burdened out of 3'
FROM "VolumeCapacity"
WHERE
    "Category" = 'All ED Visits'
    AND CAST("Visits_Per_Station" AS REAL) >= 2226.63
GROUP BY "CountyName", "FacilityName2"
HAVING COUNT("FacilityName2") >= 2
ORDER BY "CountyName", COUNT("FacilityName2") DESC;

--Top 5 most burdened ERs by year--
WITH "Ranked_ERs" AS (
SELECT
    "year",
    "FacilityName2",
    "CountyName",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS "burden ratio",
    ROW_NUMBER() OVER (
        PARTITION BY "year"
        ORDER BY SUM("Visits_Per_Station") DESC
    ) AS RANK
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY
    "year",
    "FacilityName2",
    "CountyName"
)
SELECT *
FROM "Ranked_ERs"
WHERE rank <= 5;

--The most burdened ERs in 2021-2023--
SELECT DISTINCT("FacilityName2"), "CountyName", ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "FacilityName2"
ORDER BY  ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) DESC, "FacilityName2" ASC;

--Burden ratio change by county 2021-2023--
WITH cte_burdenratio AS (
    SELECT
        "CountyName",
        "year",
        CAST(SUM(CASE WHEN "year" = '2021' THEN "Visits_Per_Station" ELSE 0 END) AS REAL) AS "br21",
        CAST(SUM(CASE WHEN "year" = '2023' THEN "Visits_Per_Station" ELSE 0 END)  AS REAL) AS "br23"
    FROM "VolumeCapacity"
    WHERE "Category" = 'All ED Visits'
    GROUP BY "CountyName"
    ),

cte_burdenratiodifference AS (
    SELECT
        "CountyName",
        "year",
        "br23" - "br21" AS "diff_23_21"
    FROM "cte_burdenratio"
)

SELECT
    "CountyName",
    "diff_23_21" AS "burden ratio change"
FROM "cte_burdenratiodifference"
GROUP BY "CountyName";

--Percent change of burden ratio by county 2021-2023--
WITH cte_countyburdenratio AS (
    SELECT
        "CountyName",
        "year",
        ROUND(
            CAST(SUM("Visits_Per_Station") AS REAL), 2) AS "burdenratio"
    FROM "VolumeCapacity"
    WHERE "Category" = 'All ED Visits'
    GROUP BY "CountyName", "year"
    ORDER BY "year"
),
cte_percentchange AS (
    SELECT
        "CountyName",
        "year",
        "burdenratio",
        COALESCE(
        ROUND(
        ("burdenratio" - LAG("burdenratio", 1) OVER (PARTITION BY "CountyName" ORDER BY "year")) * 100
        / NULLIF(LAG("burdenratio", 1) OVER (PARTITION BY "CountyName" ORDER BY "year"), 0),
        2), 0)
        AS "percentchange_prioryear"
FROM "cte_countyburdenratio")

SELECT
    "CountyName",
    "year",
    "burdenratio",
    "percentchange_prioryear",
    SUM("percentchange_prioryear") OVER (PARTITION BY "CountyName") AS "net percent change for county 2021-2023"
FROM "cte_percentchange"
GROUP BY "CountyName", "year";

--ED count from 2021-2023--
SELECT
    "year",
    COUNT("FacilityName2") AS 'california ED count'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Percent change of ED count--
WITH cte_edcount AS (
    SELECT
        "year",
        COUNT(DISTINCT("Facilityname2")) AS "edcount"
    FROM "VolumeCapacity"
    WHERE "Category" = 'All ED Visits'
    GROUP BY "year"
)

SELECT
    "year",
    "edcount",
    ROUND(
        ("edcount" - LAG("edcount") OVER (ORDER BY "year")) * 100
        / NULLIF(LAG("edcount") OVER (ORDER BY "year"), 0),
        2)
        AS "percent change from year prior"
FROM "cte_edcount";

--Change in ED visits from 2021-2023--
SELECT
    "year",
    ROUND(SUM(CAST("Tot_ED_NmbVsts" AS REAL)), 2) AS 'ED visit count'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Percent change of ED visits during 2021-2023--
SELECT
    "year",
    ROUND(SUM(CAST("Tot_ED_NmbVsts" AS REAL)), 2) AS 'ED visit count',
    ROUND(
    (SUM(CAST("Tot_ED_NmbVsts" AS REAL))
    - (LAG(SUM(CAST("Tot_ED_NmbVsts" AS REAL)), 1, 0) OVER (ORDER BY "year")))
    / (LAG(SUM(CAST("Tot_ED_NmbVsts" AS REAL)), 1, 0) OVER (ORDER BY "year")),
    2) * 100
    AS 'percent change of ED visits from year prior'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Change in ED stations from 2021-2023--
SELECT
    "year",
    ROUND(SUM(CAST("EDStations" AS REAL)), 2) AS 'ED station count'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Percent change of ED stations during 2021-2023--
SELECT
    "year",
    ROUND(SUM(CAST("EDStations" AS REAL)), 2) AS 'ED station count',
    ROUND(
    (SUM(CAST("EDStations" AS REAL))
    - (LAG(SUM(CAST("EDStations" AS REAL)), 1, 0) OVER (ORDER BY "year")))
    / (LAG(SUM(CAST("EDStations" AS REAL)), 1, 0) OVER (ORDER BY "year")),
    2) * 100
    AS 'percent change of ED stations from year prior'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Change in burden ratio from 2021-2023--
SELECT
    "year",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS 'burden ratio'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Percent change of burden ratio during 2021-2023--
SELECT
    "year",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS 'burden ratio',
    ROUND(
    (SUM(CAST("Visits_Per_Station" AS REAL))
    - (LAG(SUM(CAST("Visits_Per_Station" AS REAL)), 1, 0) OVER (ORDER BY "year")))
    / (LAG(SUM(CAST("Visits_Per_Station" AS REAL)), 1, 0) OVER (ORDER BY "year")),
    2) * 100
    AS 'percent change of burden ratio from year prior'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY "year";

--Relationship between ER Burden and shortage of both primary care and mental health resources--
SELECT
    DISTINCT("FacilityName2"),
    "CountyName",
    ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) AS 'Burden_Ratio',
    "PrimaryCareShortageArea", "MentalHealthShortageArea"
FROM "VolumeCapacity"
WHERE
    "PrimaryCareShortageArea" = 'Yes'
    AND "MentalHealthShortageArea" = 'Yes'
    AND "Category" = 'All ED Visits'
GROUP BY "FacilityName2"
ORDER BY ROUND(SUM(CAST("Visits_Per_Station" AS REAL)), 2) DESC;

--Diagnoses' relationship with burden 2021-2023--
SELECT "Category", ROUND(SUM(DISTINCT(CAST("Visits_Per_Station" AS REAL))), 2) AS "Burden_Ratio"
FROM "VolumeCapacity"
WHERE NOT "Category" = 'All ED Visits'
GROUP BY "Category"
ORDER BY ROUND(SUM(DISTINCT(CAST("Visits_Per_Station" AS REAL))), 2) DESC;

--Diagnoses' relationship with burden ratio by year--
SELECT "year",
    "Category" AS 'highest_burdened_ddx',
    ROUND(SUM(DISTINCT(CAST("Visits_Per_Station" AS REAL))), 2) AS "Burden_Ratio"
FROM "VolumeCapacity"
WHERE NOT "Category" = 'All ED Visits'
GROUP BY "year"
ORDER BY year;

--Burden by hospital ownership--
    SELECT
        "year",
        "HospitalOwnership",
        CAST(
            ROUND(SUM("Visits_Per_Station"), 2)
            AS REAL) AS 'Visits per station'
        FROM "VolumeCapacity"
        WHERE "Category" = 'All ED Visits'
        GROUP BY "year", "HospitalOwnership"
        ORDER BY "year" ASC, 'Visits per station' DESC;

--Average burden by hospital ownership--
WITH cte_hosp_ownership AS (
    SELECT
        "year",
        "HospitalOwnership",
        CAST(
            ROUND(SUM("Visits_Per_Station"), 2)
            AS REAL) AS "burden ratio"
        FROM "VolumeCapacity"
        WHERE "Category" = 'All ED Visits'
        GROUP BY "year", "HospitalOwnership"
        ORDER BY "year"
)

SELECT
    "HospitalOwnership",
    ROUND(AVG("burden ratio"), 2) AS 'average burden'
FROM "cte_hosp_ownership"
GROUP BY "HospitalOwnership"
ORDER BY "average burden" DESC;

--Top 25% burdened ERs--
SELECT
    "year",
    COUNT("FacilityName2") AS 'top 25% burdened ER count'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
    AND "Visits_Per_Station" >= 2226.63
GROUP BY "year"
ORDER BY "year";

--Top 25% burdened ERs with shortages--
SELECT
    "year",
    COUNT("FacilityName2") AS 'top 25% burdened ER with health care shortages'
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
    AND ("PrimaryCareShortageArea" = 'Yes' OR "MentalHealthShortageArea" = 'Yes')
    AND "Visits_Per_Station" >= 2226.63
GROUP BY "year"
ORDER BY "year";

--Urban versus rural count of the top 25% burdened ERs--
WITH cte1 AS (
    SELECT
    "FacilityName2",
    CAST("Visits_Per_Station" AS REAL) AS 'Burden ratio',
    "UrbanRuralDesi" AS "urban or rural"
FROM "VolumeCapacity"
WHERE "Category" = 'All ED Visits'
    AND CAST("Visits_Per_Station"AS REAL) >= 2226
ORDER BY CAST("Visits_Per_Station" AS REAL) DESC
)
SELECT
    COUNT(CASE WHEN "urban or rural" = 'Urban' THEN 1 END) AS 'urban from top 25%',
    COUNT(CASE WHEN "urban or rural" = 'Rural' THEN 1 END) AS 'rural from top 25%'
FROM "cte1";
