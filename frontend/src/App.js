import { ethers } from 'ethers';
import { useEffect, useState } from 'react';
import './App.css';
import Navbar from './components/Navbar';
import Website from './config.json'
import abi from './abi/Voting.json'
import Section from './components/Section';
import Product from './components/Product';


function App() {
  const [acc, setAcc] = useState(null);
  const [provider, setProvider] = useState(null);
  const [website,setWebsite] = useState(null);
  const [sports,setSports] = useState(null);
  const [clothing,setClothing] = useState(null);
  const [accessories,setAccessories] = useState(null);
  const [item,setItem] = useState({}); //empty object as default value
  const [toggle, setToggle] = useState(null);
  let togglePop = (items)=>{
    // console.log("Popped!");
    setItem(items); //for updating the items dictionary, i.e to show the details for the particular item on screen
    toggle ? setToggle(false) : setToggle(true); //for opening and closing the particular item info
  }
  //first we need a way to get hold of the metamask acc in the browser
  let loadData = async()=>{
    //Connect to blockchain -> frontend application to blockchain
    let provider = new ethers.providers.Web3Provider(window.ethereum);
    setProvider(provider);
    let network = await provider.getNetwork();
    console.log(network);

    //Connect to smart contract
    //means to create the JS versions of smart contract - meaning that we 
    //want to be able to use the functions and methods of smart contracts
    //, of the .sol file and other methods of , inside here, in the JS file
    //ether.js such as .deploy(), .connect(), etc...
    const website = new ethers.Contract("0x0f989B4A4aE5648aDB776c74F42C9bCcA3DF1009" ,abi, provider)
    setWebsite(website);

    //abi -> abstract binary interface -> it refers to the binary form
    //of all the things that a smart contract does, ranging from its
    //function to data types, etc. It describes how the contract works


    //filtering out the item
  }
  
  useEffect(()=>{
    loadData();
  },[]) 
  return (
    <div className="App">
      <Navbar acc={acc} setAcc={setAcc} />
      <h2 style={{margin: "10px", fontSize: "3rem"}}>Club Portals</h2>
      {/* this we have done so that while all the products are not loaded 
      till then do not show any product on the webpage */}
      {accessories && clothing && sports ? 
      <div>
        <Section title={"Clothing"} items={clothing} togglePop={togglePop} />
        <Section title={"Sports"} items={sports} togglePop={togglePop} />
        <Section title={"Accessories"} items={accessories} togglePop={togglePop} />
      </div>:""}
      {toggle && (
        <Product item={item} provider={provider} account={acc} website={website} togglePop={togglePop} />
      )}
    </div>
  );
}

export default App;
