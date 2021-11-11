import React, { useState } from 'react';

function ContextSelect({ setContext, query, setQuery }) {
    const radioChange = e => {
        setContext(e.target.value);
    }

    return (
        <div>
            <div class="input-container">
                <input type="radio" name="select_by" onChange={radioChange} value="country"/><p class="rlabel">Country&nbsp;</p>
                <input type="radio" name="select_by" onChange={radioChange} value="province"/><p class="rlabel">Province&nbsp;</p>
                <input type="radio" name="select_by" onChange={radioChange} value="city"/><p class="rlabel">City&nbsp;</p>
            </div>

            <input 
                value={ query }
                onInput={ e => setQuery(e.target.value) }
                type="text"
            />
        </div>
    );
}

export default ContextSelect;