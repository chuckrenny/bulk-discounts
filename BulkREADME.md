# Bulk Discounts

## Overview
"Bulk Discounts" is an application that allows merchants to offer discounts based on the quantity of items a customer is buying, for example, "20% off orders of 10 or more items".

### Criteria
- Bulk discounts should have a percentage discount as well as a quantity threshold.
- Bulk discounts should belong to a Merchant.
- A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant.
- Merchants can have multiple bulk discounts.
- If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied.
- Bulk discounts should apply on a per-item basis.
- If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only. Other items that did not meet the quantity threshold will not be affected.
- The quantities of items ordered cannot be added together to meet the quantity thresholds.

## Examples

### Example 1
- Merchant A has one Bulk Discount: 20% off 10 items.
- Invoice A includes two of Merchant A’s items: Item A (quantity of 5) and Item B (quantity of 5).
- No bulk discounts should be applied.

### Example 2
- Merchant A has one Bulk Discount: 20% off 10 items.
- Invoice A includes two of Merchant A’s items: Item A (quantity of 10) and Item B (quantity of 5).
- Item A should be discounted at 20% off. Item B should not be discounted.

### Example 3
- Merchant A has two Bulk Discounts: 20% off 10 items and 30% off 15 items.
- Invoice A includes two of Merchant A’s items: Item A (quantity of 12) and Item B (quantity of 15).
- Item A should be discounted at 20% off, and Item B should be discounted at 30% off.

### Example 4
- Merchant A has two Bulk Discounts: 20% off 10 items and 15% off 15 items.
- Invoice A includes two of Merchant A’s items: Item A (quantity of 12) and Item B (quantity of 15).
- Both Item A and Item B should be discounted at 20% off. Additionally, there is no scenario where Bulk Discount B can ever be applied.

### Example 5
- Merchant A has two Bulk Discounts: 20% off 10 items and 30% off 15 items.
- Merchant B has no Bulk Discounts.
- Invoice A includes two of Merchant A’s items: Item A1 (quantity of 12) and Item A2 (quantity of 15).
- Invoice A also includes one of Merchant B’s items: Item B (quantity of 15).
- Item A1 should be discounted at 20% off, and Item A2 should be discounted at 30% off. Item B should not be discounted.

## User Stories

### 1: Merchant Bulk Discounts Index
As a merchant:
- When I visit my merchant dashboard
- Then I see a link to view all my discounts
- When I click this link
- Then I am taken to my bulk discounts index page
- Where I see all of my bulk discounts including their percentage discount and quantity thresholds
- And each bulk discount listed includes a link to its show page

### 2: Merchant Bulk Discount Create
As a merchant:
- When I visit my bulk discounts index
- Then I see a link to create a new discount
- When I click this link
- Then I am taken to a new page where I see a form to add a new bulk discount
- When I fill in the form with valid data
- Then I am redirected back to the bulk discount index
- And I see my new bulk discount listed

### 3: Merchant Bulk Discount Delete
As a merchant:
- When I visit my bulk discounts index
- Then next to each bulk discount I see a button to delete it
- When I click this button
- Then I am redirected back to the bulk discounts index page
- And I no longer see the discount listed

### 4: Merchant Bulk Discount Show
As a merchant:
- When I visit my bulk discount show page
- Then I see the bulk discount's quantity threshold and percentage discount

### 5: Merchant Bulk Discount Edit
As a merchant:
- When I visit my bulk discount show page
- Then I see a link to edit the bulk discount
- When I click this link
- Then I am taken to a new page with a form to edit the discount
- And I see that the discount's current attributes are pre-populated in the form
- When I change any/all of the information and click submit
- Then I am redirected to the bulk discount's show page
- And I see that the discount's attributes have been updated

### 6: Merchant Invoice Show Page: Total Revenue and Discounted Revenue
As a merchant:
- When I visit my merchant invoice show page
- Then I see the total revenue for my merchant from this invoice (not including discounts)
- And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation

### 7: Merchant Invoice Show Page: Link to applied discounts
As a merchant:
- When I visit my merchant invoice show page
- Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)

### 8: Admin Invoice Show Page: Total Revenue and Discounted Revenue
As an admin:
- When I visit an admin invoice show page
- Then I see the total revenue from this invoice (not including discounts)
- And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
