//Deploying to live network+

async function main() {
  const contractFactory = await ethers.getContractFactory("TwitterClone"); //create instance of contract
  const contract = await contractFactory.deploy(); //deploy contract
  await contract.deployed(); //wait for contract to be deployed

  console.log("Contract deployed to :", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
