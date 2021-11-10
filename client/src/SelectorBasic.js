import React from 'react';

function SelectorBasic({ showDetail, setShowDetail, searchQuery, setSearchQuery }) {
    var message = showDetail ? "Hide Detail" : "Show Detail";

    const switchMode = e => {
        setShowDetail(!showDetail);
    }

    return (
        <div>
            <div class="search-section">
                <p> Search Name </p>
                <input 
                    value={ searchQuery }
                    onInput={ e => setSearchQuery(e.target.value) }
                    type="text"
                    id="header-search"
                    placeholder=""
                    name="s"
                />
            </div>
            <div class="basic-wrapper">
                <input class="basic" type="button" onClick={switchMode} value={message}/>
            </div>
        </div>
    )
}

export default SelectorBasic;