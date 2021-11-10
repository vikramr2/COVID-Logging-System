import React from 'react';

/** React Component for the Advanced Selector that opens up when you want details
 * 
 * @param {Boolean} showDetail was this widget opened?
 * @param {String} locQuery query entered for location
 * @param {Function} setLocQuery set in the search bar
 * @param {Boolean} hasCovid checkbox value for fitering who has COVID
 * @param {Function} setHasCovid set in click event for checkbox value
 * @returns HTML for render
 */
function SelectorAdvanced({ showDetail, locQuery, setLocQuery, hasCovid, setHasCovid }) {
    // If detail wasn't opened, dont render
    if (!showDetail) {
        return (<div></div>);
    }
    
    // Otherwise, render the form
    return  (
        <div>
            <div class="search-section">
                <p> Search Location </p>
                <input 
                    value={ locQuery }
                    onInput={ e => setLocQuery(e.target.value) }
                    type="text"
                    id="header-search"
                    placeholder=""
                    name="s"
                />
            </div>
            <p> Has COVID </p>
            <input 
                type="checkbox" 
                name="covid"
                checked={hasCovid} 
                onClick={ e => setHasCovid(!hasCovid) }
            />
        </div>
    );
}

// Export the component so that it can be used by the main app
export default SelectorAdvanced;