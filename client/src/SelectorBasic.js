import React from 'react';

/** React Component for Basic Selector opened on startup
 * 
 * @param {Boolean} showDetail open up detail menu?
 * @param {Function} setShowDetail set in the button click
 * @param {String} searchQuery query entered in search bar
 * @param {Function} setSearchQuery function to set search query; triggered on enter in textbox
 * @returns HTML for render
 */
function SelectorBasic({ showDetail, setShowDetail, searchQuery, setSearchQuery }) {
    // Message to place on the button for opening up detailed menu
    var message = showDetail ? "Hide Detail" : "Show Detail";

    // Method to open/close detailed menu on click
    const switchMode = e => {
        setShowDetail(!showDetail);
    }

    // Render component
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

// Export the component so that it can be used by the main app
export default SelectorBasic;