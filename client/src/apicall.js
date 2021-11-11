const axios = require('axios').default;

// URLs to ping
const PEOPLE_URL = 'http://localhost:8000/people/';
const DETAIL_URL = 'http://localhost:8000/people/detailed/';

/** Ping people URL and grab data
 * 
 * @returns Array of people objects
 */
export async function getPeople() {
    var people = [];

    await axios.get(PEOPLE_URL, {}).then(res => {
        people = res.data;
    }).catch(error => {
        console.log(error);
    })

    return people;
}

export async function deletePerson(id) {
    await axios.delete(PEOPLE_URL + id + '/', {}).then(res => {
        console.log('Success!');
    }).catch(error => console.log(PEOPLE_URL + id + '/'))
}

export async function modifyPerson(id, age) {
    await axios.put(PEOPLE_URL + id + '/', {age: age}).then(res => {
        console.log('Success!');
    }).catch(error => console.log(PEOPLE_URL + id + '/'))
}

export async function addPerson(people_id, fname, lname) {
    await axios.post(PEOPLE_URL, {
        people_id: people_id,
        first_name: fname,
        last_name: lname,
        has_covid: 0,
        age: 20,
        gender: "Other",
        email: "vikramr2@illinois.edu",
        country: "USA",
        state_province: "Illinois",
        city: "Champaign"
    }).then(res => {console.log("Success!")})
    .catch(error => console.log(PEOPLE_URL))
}

/** Ping detail URL and grab data
 * 
 * @returns Array of detailed people objects
 */
export async function getPeopleDetails() {
    var details = [];

    await axios.get(DETAIL_URL, {}).then(res => {
        details = res.data
    }).catch(error => {
        console.log(error);
    })

    return details;
}