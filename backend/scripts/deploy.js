// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // const organizer = hre.ethers.provider.getSigner(0).address;

  // const Lock = await hre.ethers.getContractFactory("MyContract");
  // const lock = await Lock.deploy({ from: organizer });
  // await lock.deployed();

  // console.log(
  //   `Deployed to ${lock.address}`
  // );
  
  // const catagory = "Sports";
  // const clubOwner = hre.ethers.provider.getSigner(0).address;
  // const clubTitle = "NSS";
  // const clubDescription = "National Service Scheme";
  // const clubId = 1;
  // const funds = 3000;
  // const clubImage = "";
  // const clubLogo = "";
  // const createClub = await lock.createClub(category, clubOwner, clubTitle, clubDescription,clubImage,clubLogo, clubFunds);
  // console.log("Club created with ID ",createClub);

  const main= async () => {
    console.log("hello world...")
    const Lock= await hre.ethers.getContractFactory("Lock");
    const lock= await Lock.deploy();
    await lock.deployed();
    console.log("Lock deployed to:", lock.address);
  };

  const main_1= async () => {
    try{
      await main();
      process.exit(0);
    }catch(e){
      console.log(e);
      process.exit(1);
    }
  };

  main_1();
}

