import React from 'react';

function SelectorAdvanced({ showDetail, locQuery, setLocQuery, hasCovid, setHasCovid }) {
    if (!showDetail) {
        return (<div></div>);
    }
    
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

export default SelectorAdvanced;