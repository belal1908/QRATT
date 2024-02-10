async function connectToMetamask() {
    if (window.ethereum) {
      const ethereum = window.ethereum;
      try {
        const accounts = await ethereum.send('eth_requestAccounts');
        console.log(accounts);
      } catch (error) {
        console.error(error);
      }
    } else {
      console.error("Metamask is not installed or enabled in your browser");
    }
  }
document.getElementById('login').addEventListener('click',connectToMetamask)
