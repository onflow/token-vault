// Pass the repo name
const recipe = "token-vault";

//Generate paths of each code file to render
const contractPath = `${recipe}/cadence/contract.cdc`;
const transactionPath = `${recipe}/cadence/transaction.cdc`;

//Generate paths of each explanation file to render
const smartContractExplanationPath = `${recipe}/explanations/contract.txt`;
const transactionExplanationPath = `${recipe}/explanations/transaction.txt`;

export const tokenVault = {
  slug: recipe,
  title: "Token Vault",
  createdAt: Date(2022, 9, 14),
  author: "Flow Blockchain",
  playgroundLink:
    "https://play.onflow.org/8b168390-9712-4578-a437-d15125cf18d9",
  excerpt:
    "This explains the vault resource that can be created in order for you to handle fungible tokens.",
  smartContractCode: contractPath,
  smartContractExplanation: smartContractExplanationPath,
  transactionCode: transactionPath,
  transactionExplanation: transactionExplanationPath,
};
