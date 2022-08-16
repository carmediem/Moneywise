![ezgif com-gif-maker](https://user-images.githubusercontent.com/98146281/184979536-1c0ca1a4-e7bf-4c28-8e0e-ec16879bc45e.gif)



Moneywise is a personal finance manager that enables users to meet their financial objectives by understanding their spending habits through expense management. In Moneywise, users are able to view and filter their expenses and incomes by category, month, and dollar amount.  For the frequent traveler, there is an in- app currency converter API that updates daily with over 160 exchange rates. 

When users consistently track their spending, they know where their money goes and can better ensure that their money is used wisely. Tracking expenditures also allows users to understand their spending habits and make data supported decisions to identify and eliminate wasteful spending habits in their financial life. 

**Features:**
- Users will be able to input their expenses and income, as well as make updates and delete entries. Entry details will include date, category, total amount, and a photo of the receipt.
- Users will create better financial habits by monitoring their transitions over a period of time and course-correct unnecessary expenses by creating new entries for their income and expenses 
- Users will better understand how much they are spending in certain categories, such as food, travel, and rent over a period of time. 
- Users traveling outside of the United States can use the currency conversion feature to easily convert their international expenses to USD.
- Users will be able to visualize the category breakdown of their expenditures by reviewing the pie chart and bar chart.

**Tech stack**
- SwiftUI 
- CoreData

**Dependencies**
- Pie Graph - Geometry Reader
- Currency Data API 

**User Authentification**
<br>
<img width="150" alt="Screen Shot 2022-08-16 at 12 54 42 PM" src="https://user-images.githubusercontent.com/98146281/184977002-a1267b69-0ab9-4484-8436-8657fe7de01c.png">
<br>
Finances tend to be personal and private so when the user first logs into the app, the user will authenticate by using the default method of FaceID or TouchID depending on the model of the phone, or by authenticating with their login credentials. 

**Expense Overview**
<br>
<img align = "center" width="150" alt="Screen Shot 2022-08-16 at 12 55 17 PM" src="https://user-images.githubusercontent.com/98146281/184977169-1782affe-bfcc-4dca-af6e-6d6db3314005.png">
<br>
Users are able to quickly review their monthly expenses in two ways, a bar and a pie chart. The data has to filter, refresh, and load each time a new month is selected in order for the categories to be updated in the charts. 


**Transaction List View**
<br>
<img align = "center" width="150" alt="Screen Shot 2022-08-16 at 12 55 32 PM" src="https://user-images.githubusercontent.com/98146281/184977262-24204fed-f0f5-4b7b-acc5-0d412d19cf46.png">
<br>
Users can also review their expenses in the form of a list where they can search their entries, as well as sort by category, date, and amount. I used enums and switch cases for the Cateogry icons and expense types to ensure that the correct icon and color (green or red) was associated with the transaction.

**Currency Converter**
<br>
<img align = "center" width="150" alt="Screen Shot 2022-08-16 at 12 55 54 PM" src="https://user-images.githubusercontent.com/98146281/184977582-1ee12b15-25db-41eb-9571-636961b216a2.png">
<br>
For the frequent international traveler, Moneywise has a currency converter that updates the daily exchange rate for 167 global currencies. 
