# Homework 1 - Working with Nested JSON Data
## 1. Dataset Selection
* I chose the dataset I was working with during another SQL course in KSE (Databases, autumn 2025).
* Here's the link: https://github.com/vintagedon/steam-dataset-2025/tree/main.

## 2. Data Loading
* In DataGrip, I set up a local DuckDB instance by creating a database file called identifier.db.
* Then loaded the data using the "read_json_auto" function and created a table called "games".

## 3. Data Parsing
* Using such functions as "UNNEST", "json_extract", and "json_extract_string", I made "games" more structured, turning it into:
  * 1. "flattened_games": excluding the "metadata" column and using first UNNEST;
    2. "structured_games": turning it into a normal table step by step, making it easy to work with.

## 4. Data Analysis Using Window Functions
* Analysis 1: Mac-friendly game categories (ranking different game categories by how many games of such category can be played on Mac);
* Analysis 2: Free games by game type (ranking game types by the absence of a need to pay for use);
* Functions used: RANK, COUNT.

## 5. Vizualisation
* I decided to make a bar chart in Tableau based on the results of Analysis 1:
  <img width="914" height="792" alt="Top10_Game_Genres_For_Mac" src="https://github.com/user-attachments/assets/e3ca6ccf-aba7-4791-88f8-d09a58f57c49" />

