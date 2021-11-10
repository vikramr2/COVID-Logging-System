const axios = require('axios').default;

const PEOPLE_URL = 'http://localhost:8000/people/';
const DETAIL_URL = 'http://localhost:8000/people/detailed/';

export async function getPeople() {
    var people = [];

    await axios.get(PEOPLE_URL, {}).then(res => {
        people = res.data;
    }).catch(error => {
        console.log(error);
    })

    return people;
}

export async function getPeopleDetails() {
    var details = [];

    await axios.get(DETAIL_URL, {}).then(res => {
        details = res.data
    }).catch(error => {
        console.log(error);
    })

    return details;
}