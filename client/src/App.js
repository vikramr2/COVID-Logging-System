import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Link, Route, Switch } from "react-router-dom";
import { getCityData, getCountryData, getPeople, getPeopleDetails, getProvinceData } from './apicall';

import './App.css';
import CaseEntry from './CaseEntry';
import ContextSelect from './ContextSelect';
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

function filterCases(casesList, query, context) {
  if (!query) {
    return casesList;
  }

  return casesList.filter((entry) => {
    let selectedAttribute = 
      (context == "country" ? entry.country : (context == "province" ? entry.province : entry.city))
      .toLowerCase();

    console.log(selectedAttribute);
    
    return selectedAttribute.includes(query.toLowerCase());
  })
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
  const [context, setContext] = useState("country");
  const [query, setQuery] = useState("");
  const [country, setCountry] = useState([]);
  const [province, setProvince] = useState([]);
  const [city, setCity] = useState([]);

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

  useEffect(() => {
    async function updateCountry() {
      let newCases = await getCountryData();
      setCountry(newCases);
    }
    updateCountry();
  }, []);

  useEffect(() => {
    async function updateProvince() {
      let newCases = await getProvinceData();
      setProvince(newCases);
    }
    updateProvince();
  }, []);

  useEffect(() => {
    async function updateCity() {
      let newCases = await getCityData();
      setCity(newCases);
    }
    updateCity();
  }, []);

  // Filter appropriate data
  let selectedList = filterAdvanced(filterPeople((showDetail ? detail : people), searchQuery), locQuery, hasCovid, showDetail).slice(0, 100);
  let casesList = filterCases(context == "country" ? country : (context == "city" ? city : province), query, context);

  return (
    <Router>
      <div>
        <nav class="not-sliding navbar navbar-expand-lg navbar-light bg-light">
          <Link class="navbar-brand" to="/home"><p class="L"><b>COVID Logging System</b></p></Link>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
              <li class="nav-item active">
                <Link class="nav-link" to="/home"><p class="L">Home</p></Link>
              </li>
              <li class="nav-item">
                <Link class="nav-link" to="/world"><p class="L">World</p></Link>
              </li>
            </ul>
          </div>
        </nav>
        <Switch>
          <Route path="/home">
            <h2>COVID Exposure Tracker</h2>
            <div class="horizontals">
              <SelectorBasic
                showDetail={showDetail}
                setShowDetail={setShowDetail}
                searchQuery={searchQuery}
                setSearchQuery={setSearchQuery}
                window={window}
                setWindow={setWindow}
              />
              <SelectorAdvanced
                showDetail={showDetail}
                locQuery={locQuery}
                setLocQuery={setLocQuery}
                hasCovid={hasCovid}
                setHasCovid={setHasCovid}
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
            </div>
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
          </Route>
          <Route path="/world">
            <h2>Cases Logged in File</h2>
            <ContextSelect
              setContext={setContext}
              query={query}
              setQuery={setQuery}
            />
            {casesList.map((entry) => (
              <CaseEntry
                listEntry={entry}
                context={context}
              />
            ))}
          </Route>
        </Switch>
      </div>
    </Router>
  );
}

export default App;
