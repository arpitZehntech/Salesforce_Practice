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

    // Method to fetch accounts by industry
    public static List<Account> fetchAccountsByIndustry(String industry) {
        try {
            // Query to fetch account data filtered by industry
            return [SELECT Id, Name, Industry, AnnualRevenue FROM Account WHERE Industry = :industry];
        } catch (Exception e) {
            // Handle any exceptions
            System.debug('Error fetching accounts by industry: ' + e.getMessage());
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

// fetch the invoices created today, Note, you must have at least one invoice 
// created today

List<apex_invoice__c> invoiceList = [SELECT id, Name, APEX_Status__c,
   createdDate FROM APEX_Invoice__c WHERE createdDate = today];

// create List to hold the updated invoice records
List<apex_invoice__c> updatedInvoiceList = new List<apex_invoice__c>();
APEX_Customer__c objCust = new APEX_Customer__C();
objCust.Name = 'Test ABC';

//DML for Inserting the new Customer Records
insert objCust;
for (APEX_Invoice__c objInvoice: invoiceList) {
   if (objInvoice.APEX_Status__c == 'Pending') {
      objInvoice.APEX_Status__c = 'Paid';
      updatedInvoiceList.add(objInvoice);
   }
}

// DML Statement to update the invoice status
update updatedInvoiceList;

// Prints the value of updated invoices
System.debug('List has been updated and updated values are' + updatedInvoiceList);

// Inserting the New Records using insert DML statement
APEX_Invoice__c objNewInvoice = new APEX_Invoice__c();
objNewInvoice.APEX_Status__c = 'Pending';
objNewInvoice.APEX_Amount_Paid__c = 1000;
objNewInvoice.APEX_Customer__c = objCust.id;

// DML which is creating the new Invoice record which will be linked with newly
// created Customer record
insert objNewInvoice;
System.debug('New Invoice Id is '+objNewInvoice.id+' and the Invoice Number is'
   + objNewInvoice.Name);


//    updserting the new customer record
List<APEX_Customer__c> customerList = new List<APEX_Customer__c>();
APEX_Customer__c objCustomer = new APEX_Customer__C();      
objCustomer.Name = 'Test ABC';
customerList.add(objCustomer);

    // Example for upserting the Customer records
List<apex_customer__c> CustomerList = new List<apex_customer__c>();
for (Integer i = 0; i < 10; i++) {
   apex_customer__c objcust=new apex_customer__c(name = 'Test' +i,
   apex_external_id__c='1234' +i);
   customerlist.add(objcust);
} //Upserting the Customer Records

upsert CustomerList;

System.debug('Code iterated for 10 times and created 9 records as one record with External Id 12341 is already present');

for (APEX_Customer_c objCustomer: CustomerList) {
   if (objCustomer.APEX_External_Id_c == '12341') {
      system.debug('The Record which is already present is '+objCustomer);
   }
}