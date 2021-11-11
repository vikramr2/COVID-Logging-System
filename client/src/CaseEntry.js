import React, { useState } from 'react';

function CaseEntry({ listEntry, context }) {
    let attributeName = 
         context == "country"  ? listEntry.country  : 
        (context == "province" ? listEntry.province : listEntry.city);

    return (
        <div class="entry-card">
            <h3 class="L">{attributeName}</h3>
            <div class="row">
                <div class="col-8"><p class="L">Number of Cases:</p></div>
                <div class="col-4"><p class="L">{listEntry.cases}</p></div>
            </div>
        </div>
    )
}

export default CaseEntry;