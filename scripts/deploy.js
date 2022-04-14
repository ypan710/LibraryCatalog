// Contract deployed to:  0xcB9Ee3d8179d360468E4e0BAf246C5a37F48D223

const { ethers } = require("hardhat")

// deploying to blockchain is a asynchronous function 
// because we don't know how long it's going to take
const main = async () => {
    // fetch contract from Library.sol
    const contractFactory = await ethers.getContractFactory('Library');

    // await on deployment
    const contract = await contractFactory.deploy();

    // await after deployment
    await contract.deployed();

    // print out address contract is deployed to
    console.log("Contract deployed to: ", contract.address);
}

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    }
    catch(error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();