# Homework 1 - Working with Nested JSON Data
## 1. Dataset Selection
I chose the dataset I was working with during another SQL course in KSE (Databases, autumn 2025).
Here's the link: https://github.com/vintagedon/steam-dataset-2025/tree/main.

## 2. Data Loading
CREATE TABLE games AS
SELECT *
FROM read_json_auto("C:\Users\Lesya\Desktop\Databases\games_dataset_small.json",
      maximum_object_size=100000000);
CREATE OR REPLACE TABLE games AS
       SELECT games FROM games;
