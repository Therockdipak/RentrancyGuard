const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("velnerableBank", (m) => {
 
  const lock = m.contract("VelnerableBank", []);

  return { lock };
});

module.exports = buildModule("attacker", (m) => {
  const velnerableBank = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const lock = m.contract("Attacker", [velnerableBank]);

  return { lock };
});
