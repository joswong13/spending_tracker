# Spending Tracker V1.1.0 - alpha

This is an app built to help people track their monthly spending. In the monthly view, you can see the entire month (6 weeks) as a calendar. Clicking on any day will open that week and display the weekly spending view with a list of transactions at the bottom.

## Data Storage

Currently using SQFLite to store the transaction as one big table of transactions and then performing a query search for any transactions between dates (dates are stored as milliseconds since epoch). Currently, only supporting adding to the database and querying the database.

## TODO

- [x] change monthly calendar view to something more representative of the month (6 weeks)
- [x] change category picker from dropdown to a dialog pop up
- [x] need to add edit and delete functionality to each transaction
- [ ] add firebase functionality (for backup storage and data restore)
- [x] add a way to view the category totals
- [x] remove appbar in favor of bottom navigation screen (maybe)
- [x] improve codebase logistics (remove functions out of AddExpenseView to its own dart file)
- [ ] improve flow of app
- [x] improve navigation between widgets
- [x] improved speed of calculating monthly data table object by adding compute (splitting to seperate thread)
- [ ] need to change bottom nav bar icons
- [x] removed unused classes/files
- [ ] add version/version_two screenshots
- [ ] add a way to click into each category

## Note

Future improvements to this app will NOT be merged to [version_one](https://github.com/joswong13/spending_tracker/tree/version/version_one) branch.