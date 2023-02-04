const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Lock", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.

  let website;
  let deployer, buyer;
  this.beforeEach(async()=>{

    
    //A Signer in ethers is an abstraction of an Ethereum Account, 
    //which can be used to sign messages and transactions and send 
    //signed transactions to the Ethereum Network to execute state 
    //changing operations.
    [deployer, buyer] = await ethers.getSigners();//getSigners func to get all the fake 
    //accounts provided by hardhat with some ethereum in it.
    //deplyer and buyer only two acc as of now
    // console.log(deployer.address, buyer.address); 


    //creating an instance of the smart contract or fetched as well to 
    //create its copy. Inside the getContractFactory goes the name of the
    //smart contract rather than the name of the solidity file.
    const Website = await ethers.getContractFactory("Lock");

    //deploying a copy of it on the test blockchain running in the background
    website = await Website.deploy();
  })
  describe("Deployment", ()=>{ 
    it('setting the owner',async()=>{
      expect(await website.owner()).to.equal(deployer.address)
    })
  })
  describe("create_club",()=>{
    this.beforeEach(async()=>{
      transaction = await website.list( 
        "technical",
        "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
        "CEV",
        "Lorem ipsum dolor, Lorem ipsum dolor, Lorem ipsum dolor, Lorem ipsum dolor ",
        "https://ipfs.io/ipfs/QmTYEboq8raiBs7GTUg2yLXB3PMz6HuBNgNfSZBx5Msztg/shoes.jpg",
        "https://ipfs.io/ipfs/QmTYEboq8raiBs7GTUg2yLXB3PMz6HuBNgNfSZBx5Msztg/shoes.jpg",
        1000
      ) //waiting for the new product to be listed on the website
      await transaction.wait();
    })
    it('create a club function',async()=>{
      const item = await website.items(1);
      expect(item.id).to.equal(ID);
      expect(item.name).to.equal(NAME);
      expect(item.category).to.equal(CATEGORY);
      expect(item.cost).to.equal(COST);
      expect(item.image).to.equal(IMAGE);
      expect(item.rating).to.equal(RATING);
      expect(item.stock).to.equal(STOCK);
    })
  })
});
