import React from 'react';

function Entry({ listItem, detailed }) {
    if (!listItem) {
        return (<div></div>);
    }

    if (!detailed) {
        return (
            <div class="entry-card">
                <h3>{listItem.first_name} &nbsp; {listItem.last_name}</h3>
                <div class="row">
                    <div class="col-8">Age</div>
                    <div class="col-4">{listItem.age}</div>
                </div>
                <div class="row">
                    <div class="col-8">Gender</div>
                    <div class="col-4">{listItem.gender}</div>
                </div>
                <div class="row">
                    <div class="col-8">Email</div>
                    <div class="col-4">{listItem.email}</div>
                </div>
            </div>
        );
    }

    return (
        <div class="entry-card">
            <h3>{listItem.first_name} &nbsp; {listItem.last_name}</h3>
            <div class="row">
                <div class="col-8">Age</div>
                <div class="col-4">{listItem.age}</div>
            </div>
            <div class="row">
                <div class="col-8">Gender</div>
                <div class="col-4">{listItem.gender}</div>
            </div>
            <div class="row">
                <div class="col-8">Email</div>
                <div class="col-4">{listItem.email}</div>
            </div>
            <div class="row">
                <div class="col-8">Has COVID?</div>
                <div class="col-4">{listItem.has_covid ? "Yes" : "No"}</div>
            </div>
            <div class="row">
                <div class="col-8">Location</div>
                <div class="col-4">{listItem.city},&nbsp;{listItem.state_province},&nbsp;{listItem.country}</div>
            </div>
        </div>
    );
}

export default Entry;