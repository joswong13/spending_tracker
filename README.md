# Spending Tracker V1.2.0 - alpha

This is an app built to help people track their monthly spending. In the monthly view, you can see the entire month (6 weeks) split weekly. Clicking on any week will open and display the weekly spending view with a list of transactions at the bottom. There is also a category view where users can view the entire six weeks categorically. Clicking on a category will allow users to view all the transactions for that category in that six weeks.

## Data Storage

Currently using SQFLite to store the transaction as one big table of transactions and then performing a query search for any transactions between dates (dates are stored as milliseconds since epoch). Currently, only supporting adding to the database and querying the database.

## TODO

- [ ] add firebase functionality (for backup storage and data restore)
- [ ] Theme: ability to change colors (low priority)
- [ ] add screenshots

## Completed

### Added

- [x] added a way to view the category totals
- [x] added a way to click into each category
- [x] added const to widgets that will never be re-rendered when ChangeNotifier fires (eg. Text widgets and TextStyle widgets)
- [x] added a confirmation dialog before deleting a transaction
- [x] added a datepicker on the homeview to quickly pick date
- [x] added edit and delete functionality to each transaction
- [x] added a way to edit transactions when clicked in from category transaction page
- [x] added bottom nav bar
- [x] added dismissible to weeklyView to allow swiping to change weeks
- [x] added chevrons to dismissible (background and secondary background)

### Changed

- [x] changed monthly calendar view to something more representative of the month (6 weeks)
- [x] changed category picker from dropdown to a dialog pop up
- [x] changed bottom nav bar icons
- [x] changed color constants to const variables
- [x] changed weekday list functions to const
- [x] refactored models to singleton and added static methods

### Improved

- [x] improved codebase logistics (remove functions out of AddExpenseView to its own dart file)
- [x] improved flow of app
- [x] improved readability in month view
- [x] improved navigation between widgets
- [x] improved speed of calculating monthly data table object by adding compute (splitting to seperate thread)

### Removed

- [x] removed unused classes/files
- [x] removed top appbar
