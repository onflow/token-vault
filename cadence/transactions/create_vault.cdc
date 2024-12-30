import "ExampleToken"

// This transaction configures an account to store and receive tokens defined by
// the ExampleToken contract.
transaction {
    prepare(acct: auth(Storage, Capabilities) &Account) {
        // Create a new empty Vault object
        let vaultA <- ExampleToken.createEmptyVault()

        // Store the vault in the account storage
        acct.storage.save<@ExampleToken.Vault>(<-vaultA, to: /storage/MainVault)

        log("Empty Vault stored")

        // Create a public Receiver capability to the Vault
        let receiverCap = acct.capabilities.storage.issue<&ExampleToken.Vault>(
            /storage/MainVault
        )
        acct.capabilities.publish(receiverCap, at: /public/MainReceiver)

        log("References created")

         // Verify the capability by borrowing the reference
        let borrowedVault = acct.capabilities
            .borrow<&ExampleToken.Vault>(/public/MainReceiver)
        
        if borrowedVault != nil {
            log("Vault Receiver Reference successfully created and borrowed.")
        } else {
            log("Vault Receiver Reference creation or borrowing failed.")
        }
    }
}
