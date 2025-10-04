# Scottish Council Analysis

This project provides a simple analysis of data from Scottish councils, visualizing the population and area of each council.

## Project Structure

- `analysis.R`: The R script used to perform the data analysis and generate the plots.
- `app.py`: A Flask web application to display the analysis results.
- `static/`: A directory containing the generated plots.
- `templates/`: A directory containing the HTML template for the web application.
- `requirements.txt`: A file listing the Python dependencies for the web application.
- `.gitignore`: A file specifying which files and directories to ignore in the git repository.

## Analysis

The `analysis.R` script performs the following steps:

1.  Loads the necessary libraries (`ggplot2` and `readr`).
2.  Reads the council data from a remote CSV file.
3.  Creates a bar chart of the population by council and saves it as `population_by_council.png`.
4.  Creates a scatter plot of the area vs. population and saves it as `area_vs_population.png`.

## Web Application

This project includes a simple web application to display the analysis results.

### Running the application

1.  Install the required Python packages:

    ```
    pip install -r requirements.txt
    ```

2.  Run the Flask application:

    ```
    python app.py
    ```

3.  Open your web browser and go to `http://127.0.0.1:5000`.
