const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const JAN_1ST_2030 = 1893456000;
const ONE_GWEI = 1_000_000_000n;

module.exports = buildModule("velnerableBank", (m) => {
 
  const lock = m.contract("VelnerableBank", []);

  return { lock };
});

module.exports = buildModule("attacker", (m) => {
  const velnerableBank = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const lock = m.contract("Attacker", [velnerableBank]);

  return { lock };
});
