public class AccountDataFetcher {
    // Method to fetch account data
    public static List<Account> fetchAccounts() {
        try {
            // Query to fetch account data
            return [SELECT Id, Name, Industry, AnnualRevenue FROM Account];
        } catch (Exception e) {
            // Handle any exceptions
            System.debug('Error fetching accounts: ' + e.getMessage());
            return new List<Account>();
        }
    }
}

public class AccountDataFetcherController {
    // List to hold account data this comment is for testing
    public List<Account> accounts { get; set; }

    // Constructor to fetch accounts
    public AccountDataFetcherController() {
        accounts = AccountDataFetcher.fetchAccounts();
    }
}