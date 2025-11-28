
<img width="100" height="135" alt="BrandAssets_Logos_02-NSymbol copy" src="https://github.com/user-attachments/assets/3b0276a1-d1ab-4e65-b241-0340b4c06636" />

# Understanding Netflix Customer Churn: Engagement, Revenue, and Key Drivers

<img width="1370" height="196" alt="Screenshot 2025-11-28 at 18 12 04" src="https://github.com/user-attachments/assets/93130da0-9765-4b40-90c5-2d2d015a0ec4" />

<img width="1467" height="381" alt="Screenshot 2025-11-28 at 18 08 48" src="https://github.com/user-attachments/assets/b6497fd6-e541-4f59-a594-26647b52ade5" />

## Executive Summary

This project analyses a dataset of 5,000 Netflix customers to understand why customers churn, how churn affects revenue, and what customer behaviors or subscription plan types explain these patterns.

The investigation looked at churn through two distinct lenses:

**1. Customer Engagement Churn** — How many customers leave?

**2. Revenue Churn** — How much money is lost when they leave?

The results show that engagement-driven churn and revenue-driven churn follow different patterns, meaning Netflix would require two separate business strategies to reduce overall churn:

- A strategy focused on **growing and retaining the user base**
- A strategy focused on **maximizing revenue retention**

 📊 [Following this link to the interactive Tableau Dashboard](https://public.tableau.com/app/profile/jenny.core.holt/viz/NetflixCustomerChurnAnalysis/churn_dashboard)

 ## Table of Contents
1. [Data and Scope](#data-and-scope)
2. [Key Findings](#key-findings)
3. [Insights](#insights)
4. [Recommendations for Stakeholders](#recommendations-for-stakeholders)
5. [Limitations and Next Steps](#limitations-and-next-steps)

## Data and Scope
This project uses a sample dataset of 5,000 Netflix users, containing:

- Customer demographics
- Average daily watch time
- Subscription type (Basic, Standard, Premium)
- Monthly fee
- Churn flag (1 = churned, 0 = active)

The analysis explores:
- The relationship between watch time and churn likelihood
- The relationship between watch time and revenue lost from churn
- Churn by subscription plan
- Comparative churn numbers vs. churn revenue
- Additional characteristics such as age, gender, geographic region, and genre preference

## Key Findings
Overall Metrics:
<img width="1370" height="196" alt="Screenshot 2025-11-28 at 18 12 04" src="https://github.com/user-attachments/assets/93130da0-9765-4b40-90c5-2d2d015a0ec4" />

- Churn rate: **50.3%**
- Total churned customers: **2,515**
- Total revenue: **63.467,00 €**
- Churned revenue: **30.520,00 €**
- Revenue loss from churn: **48%**

### 1. Watch Time vs. Churn Engagement Loss 

<img width="751" height="430" alt="Screenshot 2025-11-28 at 18 37 58" src="https://github.com/user-attachments/assets/f019a83d-ed03-4c82-a7fd-608f6cddbd7c" />

- **57%** of customers who watched < 1 hour/day churned.
- Low watch time is the strongest predictor of churn, indicating engagement-driven cancellations.

### 2. Watch Time vs. Revenue Loss

<img width="744" height="406" alt="Screenshot 2025-11-28 at 18 39 24" src="https://github.com/user-attachments/assets/aa9df4bf-85ce-46ae-aa93-c3cae7618fe6" />

- Customers who watched > 5 hours/day generated **22.174 € in monthly churned revenue**.
- These customers represent high-value losses, driven primarily by Premium and Standard plan holders.

### 3. Plans vs. Churn Engagement (Customer Count Loss)

<img width="549" height="234" alt="Screenshot 2025-11-28 at 18 40 02" src="https://github.com/user-attachments/assets/66be6441-497d-4c0b-8d17-6a8afa584f2b" />

- Basic plan customers had the highest churn rate: 61.83%

### 4. Plans vs. Churn Revenue Loss

<img width="592" height="233" alt="Screenshot 2025-11-28 at 18 40 47" src="https://github.com/user-attachments/assets/5b026e39-8ba9-4347-8ab6-82f7c59d8fc8" />

- Premium plan (17.99€/month) generated the **highest churn revenue loss: 12.580 €**

### 5. Plan Comparison
<img width="327" height="403" alt="Screenshot 2025-11-28 at 18 49 44" src="https://github.com/user-attachments/assets/d19bd3cb-0329-44f4-8f93-e8c2e626fea1" />
<br></br>
<table aria-labelledby="Plan Comparison">
  <thead>
    <tr>
      <th scope="col">Plan</th>
      <th scope="col">Fee</th>
      <th scope="col">Churned</th>
      <th scope="col">Active</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Basic</td>
      <td> 8.99 € </td>
      <td> 1,027 </td>
      <td> 634 </td>
    </tr>
    <tr>
      <td>Standard</td>
      <td> 13.99 € </td>
      <td> 748 </td>
      <td> 898 </td>
    </tr>
    <tr>
      <td>Premium</td>
      <td> 17.99 €</td>
      <td> 740 </td>
      <td> 953 </td>
    </tr>
  </tbody>
</table>

### 6. Plan Churn for Users Watching < 1 Hour/Day (Engagement Risk Group)

<img width="555" height="248" alt="Screenshot 2025-11-28 at 18 42 15" src="https://github.com/user-attachments/assets/a13573c3-e79e-4248-a135-324d1071b569" />

- Basic: **66.67%**
- Standard: **44.68%**
- Premium: **57.69%**

## 7. Plan Churn Revenue for Users Watching > 5 Hours/Day (High-Value Risk Group)

<img width="536" height="239" alt="Screenshot 2025-11-28 at 18 44 03" src="https://github.com/user-attachments/assets/dfaf6eea-1c2f-4746-8d5b-c764147c6b0f" />

Revenue lost:
- Basic: **6,040 €**
- Standard: **7,124 €**
- Premium: **9,010 €**

## Insights
<img width="1499" height="1199" alt="churn_dashboard" src="https://github.com/user-attachments/assets/3a50d66a-1857-499e-a532-5fb4af00abe3" />

### 1. Engagement and revenue churn behave differently
Low watch time drives high churn volume, while high watch time drives high revenue loss per churned customer.

### 2. Two distinct user groups drive churn

- Casual, low-watch-time users drive engagement loss
- Premium, high-watch-time users drive revenue loss

### 3. Basic plan users churn in the highest volume

This suggests issues such as low perceived value or weaker content alignment.

### 4. Premium users create the highest financial impact when they churn

A relatively small churn count results in disproportionately large revenue loss.

### 5. Additional characteristics show no strong correlation to churn

The following variables were analyzed but did not show a meaningful or actionable relationship with churn:

- Geographic region
- Age
- Gender
- Average age
- Genre preference

These findings reinforce that engagement (watch time) and plan type are the dominant churn drivers in this dataset.

## Recommendations for Stakeholders

### For Product & Engagement Teams

- Enhance early-stage user engagement (new user onboarding, recommendations).

- Trigger retention workflows for users whose watch time declines.

### For Business & Strategy Teams

- Reassess Basic plan value proposition.

- Build retention initiatives targeted specifically at Premium subscribers.

### For Marketing Teams

- Run segmented campaigns based on engagement level and plan tier.

- Offer tailored win-back promotions for high-value churners.

## Limitations and Next Steps

### Limitations

- Dataset of 5,000 users, not full Netflix population

- Watch time is the only behavioral metric

- No qualitative data (user satisfaction, support interactions)

- Demographic variables (age, gender, geography) and genre preferences showed no strong correlation with churn in this dataset

### Next Steps

- Build a machine learning–based churn prediction model

- Analyse changes in watch time month-to-month

- Expand the dataset with more behavioural and demographic fields

- Develop a Customer Lifetime Value (CLV) segmentation

- Conduct A/B testing of retention strategies
