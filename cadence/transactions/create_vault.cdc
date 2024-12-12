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
    }

    post {
        // Check that the capabilities were created correctly
        assert(
            getAccount(0x02)
                .capabilities
                .borrow<&ExampleToken.Vault>(/public/MainReceiver) != nil,
            message: "Vault Receiver Reference was not created correctly"
        )
    }
}
