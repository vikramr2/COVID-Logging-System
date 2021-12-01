import React from 'react';
import Plot from 'react-plotly.js';

function Graph() {
    const rows = require('./world_covid/world_covid.json');
    console.log(rows);

    console.log(rows.map(row => row.location));
    return (
        <div class="graph">
            <Plot
                data = {[{
                    type: 'choropleth',
                    locationmode: 'country names',
                    locations: rows.map(row => row.location),
                    z: rows.map(row => row.total_cases != "" ? row.total_cases : 0.0),
                    text: rows.map(row => row.location),
                    autocolorscale: true
                }]}

                layout = {{
                    title: 'Covid Cases as of 11-29-2021',
                    geo: {
                        projection: {
                            type: 'robinson'
                        }
                    }
                }}

                showLink = {false}
            />
        </div>
    );
}

// Export the component so that it can be used by the main app
export default Graph;