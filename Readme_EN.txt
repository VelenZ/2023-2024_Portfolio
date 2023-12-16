Project: Organization and Analysis of Netflix's North American Program Database

Data Sources:
https://www.netflix.com/
https://unogs.com/ (An unofficial Netflix search website providing an API, not used in this project due to limited access.)
https://www.imdb.com (Provides API, costs $150,000 per year.)
http://www.imdb.com/interfaces (An official, non-profit mirror site for IMDb. A lifesaver for students on a budget.)

Reference: 
https://7color94.github.io/2016/01/imdb-db-structure/

Workflow:
1.Use a Python scraping script to collect program information from https://unogs.com/search/?country_andorunique=or&start_year=1900&end_year=2023&end_rating=10&genrelist=&audiosubtitle_andor=or&countrylist=78. Also, scrape the IMDb links for matching with the IMDb database. The script isn't entirely original; note that unogs.com has some access limitations.
2.Export to unogs_us.csv, clean, and supplement missing data.
3.Download the mirror database and match using unique identifiers (ttxxxxxx), as detailed in combine.R.
4.Export to Netflix_us_database.xlsx.
5.Further organize data for cluster analysis, export to Data_Net.xlsx.
6.Dissect summaries and conduct cluster analysis on all variables, as detailed in cluster.R.
7.Export to output.csv, analyze, and produce output_analysis.xlsx.