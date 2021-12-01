import React, { useState } from 'react';
import { addPerson } from './apicall';

function CreateWindow({ window, people, setPeople, id, setId, fname, setFname, lname, setLname }) {
    if (!window) return (<div></div>);

    const addAPerson = e => {
        let copy = [...people];
        copy.unshift({
            people_id: id,
            first_name: fname,
            last_name: lname,
            has_covid: 0,
            age: 20,
            gender: "Other",
            email: "vikramr2@illinois.edu",
            country: "USA",
            state_province: "Illinois",
            city: "Champaign"
        });
        setPeople(copy);

        async function add() {
            await addPerson(id, fname, lname);
        }

        add();
    }

    return (
        <div class="create-window">
            <p><b>Add Person</b></p>
            <p>First Name:</p>
            <input type="text" id="fname" name="fname" value={fname} onChange={e => setFname(e.target.value)}/><br/>
            <p>Last Name:</p>
            <input type="text" id="lname" name="lname" value={lname} onChange={e => setLname(e.target.value)}/><br/><br/>
            <input type="submit" value="Submit" onClick={addAPerson}/>
        </div>
    )
}

export default CreateWindow;