import React, { useState, useEffect } from 'react';
import { getPeople, getPeopleDetails } from './apicall';

import './App.css';

function App() {
  const [people, setPeople] = useState([]);
  const [detail, setDetail] = useState([]);

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

  console.log(people);
  console.log(detail);

  return (
    <div>
      <p>Hello World</p>
    </div>
  );
}

export default App;
