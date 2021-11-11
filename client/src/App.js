import React, { useState, useEffect } from 'react';
import { getPeople, getPeopleDetails } from './apicall';

import './App.css';
import CreateWindow from './CreateWindow';
import Entry from './Entry';
import SelectorAdvanced from './SelectorAdvanced';
import SelectorBasic from './SelectorBasic';

/** Filter names of people based on the search query
 * 
 * @param {Array} people Basic data fetched from API
 * @param {String} query String entered in Search Query
 * @returns Filtered list
 */
function filterPeople(people, query) {
  // If the query is empty, just return the full list
  if (!query) {
    return people;
  }

  // Otherwise filter by inclusion in first or last name
  return people.filter((person) => {
    const fname = person.first_name.toLowerCase();
    const lname = person.last_name.toLowerCase();
    return fname.includes(query.toLowerCase()) || lname.includes(query.toLowerCase());
  })
}

/** Filter attributes of people based on form
 * 
 * @param {Array} people Detailed data fetched from API
 * @param {String} query String entered in Search Query
 * @param {Boolean} hasCovid Should we only return people who have COVID?
 * @param {Boolean} advanced Is advanced selection open?
 * @returns Filtered list
 */
function filterAdvanced(people, query, hasCovid, advanced) {
  // If we are only on basic selection, return the entire list
  if (!advanced) {
    return people;
  }

  // Set aside a copy since we are doing multiple rounds of filtration
  let copy = [...people];

  // Filter first by query on the location
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

  // Then filter out those who dont have COVID if it is actually specified
  if (hasCovid) {
    copy = copy.filter((person) => {
      return person.has_covid;
    })
  }

  // Return filted list
  return copy;
}

/** Main render
 * 
 * @returns HTML of main render
 */
function App() {
  // Set initial states
  const [people, setPeople] = useState([]);
  const [detail, setDetail] = useState([]);
  const [showDetail, setShowDetail] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [locQuery, setLocQuery] = useState("");
  const [hasCovid, setHasCovid] = useState(false);
  const [window, setWindow] = useState(false);
  const [id, setId] = useState(0);
  const [fname, setFname] = useState("John");
  const [lname, setLname] = useState("Doe");

  // Use effect to fill array by pinging the API
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

  // Filter appropriate data
  let selectedList = filterAdvanced(filterPeople((showDetail ? detail : people), searchQuery), locQuery, hasCovid, showDetail).slice(0, 100);

  console.log(detail[detail.length - 1]);

  return (
    <div>
      <h2>COVID Exposure Tracker</h2>
      <SelectorBasic
        showDetail={showDetail}
        setShowDetail={setShowDetail}
        searchQuery={searchQuery}
        setSearchQuery={setSearchQuery}
        window={window}
        setWindow={setWindow}
      />
      <CreateWindow
        window={window}
        people={detail}
        setPeople={setDetail}
        id={id}
        setId={setId}
        fname={fname}
        setFname={setFname}
        lname={lname}
        setLname={setLname}
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
          people={people}
          setPeople={setPeople}
          details={detail}
          setDetails={setDetail}
        />
      ))}
    </div>
  );
}

export default App;
