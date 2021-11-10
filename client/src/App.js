import React, { useState, useEffect } from 'react';
import { getPeople, getPeopleDetails } from './apicall';

import './App.css';
import Entry from './Entry';
import SelectorAdvanced from './SelectorAdvanced';
import SelectorBasic from './SelectorBasic';

function filterPeople(people, query) {
  if (!query) {
    return people;
  }

  return people.filter((person) => {
    const fname = person.first_name.toLowerCase();
    const lname = person.last_name.toLowerCase();
    return fname.includes(query.toLowerCase()) || lname.includes(query.toLowerCase());
  })
}

function filterAdvanced(people, query, hasCovid, advanced) {
  if (!advanced) {
    return people;
  }

  let copy = [...people];
  if (query) {
    copy = copy.filter((person) => {
      const city = person.city.toLowerCase();
      const prov = person.state_province.toLowerCase();
      const coun = person.country.toLowerCase();

      return city.includes(query.toLowerCase()) ||
        prov.includes(query.toLowerCase()) ||
        coun.includes(query.toLowerCase());
    })
  }

  if (hasCovid) {
    copy = copy.filter((person) => {
      return person.has_covid;
    })
  }

  return copy;
}

function App() {
  const [people, setPeople] = useState([]);
  const [detail, setDetail] = useState([]);
  const [showDetail, setShowDetail] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [locQuery, setLocQuery] = useState("");
  const [hasCovid, setHasCovid] = useState(false);

  useEffect(() => {
    async function updatePeople() {
      let newPeople = await getPeople();
      setPeople(newPeople);
    }
    updatePeople();
  }, []);

  useEffect(() => {
    async function updatePeopleDetails() {
      let newDetails = await getPeopleDetails();
      setDetail(newDetails);
    }
    updatePeopleDetails();
  }, []);

  console.log(hasCovid);

  let selectedList = filterAdvanced(filterPeople((showDetail ? detail : people).slice(0, 100), searchQuery), locQuery, hasCovid, showDetail);

  return (
    <div>
      <h2>COVID Exposure Tracker</h2>
      <SelectorBasic
        showDetail={showDetail}
        setShowDetail={setShowDetail}
        searchQuery={searchQuery}
        setSearchQuery={setSearchQuery}
      />
      <SelectorAdvanced
        showDetail={showDetail}
        locQuery={locQuery}
        setLocQuery={setLocQuery}
        hasCovid={hasCovid}
        setHasCovid={setHasCovid}
      />
      {selectedList.map((entry) => (
        <Entry
          listItem={entry}
          detailed={showDetail}
        />
      ))}
    </div>
  );
}

export default App;
