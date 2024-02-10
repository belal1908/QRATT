import web3 from './web3';
import compiledFactory from './build/CampaignFactory.json';

const factory = new web3.eth.Contract(compiledFactory.abi,'0xc3d490fb48ef6dc1C56f3114dDCA6e25851138F7');

export default factory;
