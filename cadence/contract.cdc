// A vault resource to be stored in an account that tracks your balance of tokens
access(all)
resource Vault: Provider, Receiver, Balance {
        
    // Keeps track of the total balance of the account's tokens
    access(all)
    var balance: UFix64

    // Initialize the balance at resource creation time
    init(balance: UFix64) {
        self.balance = balance
    }

    // Withdraw
    //
    // Function that takes an amount as an argument
    // and withdraws that amount from the Vault.
    //
    // It creates a new temporary Vault that is used to hold
    // the tokens being transferred. It returns the newly
    // created Vault to the context that called it so it can be deposited
    // elsewhere.
    access(all)
    fun withdraw(amount: UFix64): @Vault {
        self.balance = self.balance - amount
        return <-create Vault(balance: amount)
    }
    
    // Deposit
    //
    // Function that takes a Vault object as an argument and adds
    // its balance to the balance of the owner's Vault.
    //
    // It is allowed to destroy the sent Vault because the Vault
    // was a temporary holder of the tokens. The Vault's balance has
    // been consumed and therefore can be destroyed.
    access(all)
    fun deposit(from: @Vault) {
        self.balance = self.balance + from.balance
        destroy from
    }
}
