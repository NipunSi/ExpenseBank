# ExpenseBank

<p align="center">
<img src="https://user-images.githubusercontent.com/53502826/122479979-dc141800-cf80-11eb-91fc-16c01680f0a2.png" width="120" height="120">
</p>

## About the app

<p align="center">
<img src="https://user-images.githubusercontent.com/53502826/122481100-f3540500-cf82-11eb-96a0-7a893bd7b20e.png" width="317" height="600">
</p>

### ExpenseBank

Every few seconds, the app fetches a batch of expense data from a built in API. The JSON data is decoded and displayed on the screen in a simple, clean table view. The category with the most spend is displayed as well as the total amount spend and whether it is over or under the month's budget.

<br />

### What I learned

I was able to learn a lot more about building UI programatically and how it compares to using storyboards, which is what i've always used in the past. I also got the chance to understand a small amout of Combine and learn how it could be used with networking. In addition, I gained even more experience making custom UITableViewCell's and was able to fill them in within the cell class to reduce code in the view controller.

<br />

### Concepts used

* VC, Models, and Interactor for architecture
* Fully programatic UI and constraints
* JSON, Codable, and Combine
* Custom UITableViewCell

### Features

- [x] Get new expense data every few seconds
- [x] Show all of the expense's titles, categories, and amounts on a table
- [x] Calculate and display the category with the highest spending
- [x] Display the total amount spent and determine whether it was over budget
