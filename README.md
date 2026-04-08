# Data Analyst Assignment – PlatinumRx

## Structure
- `SQL/` — Schema setup and query solutions for Hotel & Clinic systems
- `Python/` — Scripts for time conversion and duplicate removal
- `Spreadsheets/` — Excel workbook for ticket analysis (see instructions below)

## SQL Notes
- Written for **MySQL**. For PostgreSQL, replace `DATE_FORMAT(col, '%Y-%m')` with `TO_CHAR(col, 'YYYY-MM')`.
- Run `01_Hotel_Schema_Setup.sql` before `02_Hotel_Queries.sql`.
- Run `03_Clinic_Schema_Setup.sql` before `04_Clinic_Queries.sql`.
- Year/month filters (e.g., `2021`, `'2021-12'`) can be changed as needed.

## Spreadsheet Notes (Ticket_Analysis.xlsx)
### Q1 – Populate ticket_created_at in feedbacks sheet
In cell D2 of the feedbacks sheet:
=VLOOKUP(A2, ticket!$E:$B, 2, FALSE)
- A2 = cms_id in feedbacks; ticket!$E:$B = range with cms_id and created_at

### Q2a – Tickets closed on same day
Add helper column in ticket sheet:
=INT(B2) = INT(C2)   → returns TRUE/FALSE
Then use COUNTIFS per outlet_id on TRUE values.

### Q2b – Tickets closed in same hour of same day
Add helper column:
=(INT(B2) = INT(C2)) AND (HOUR(B2) = HOUR(C2))
Then COUNTIFS per outlet_id on TRUE values.

## Python Notes
- Requires Python 3.x
- No external libraries needed
- Run: `python 01_Time_Converter.py` and `python 02_Remove_Duplicates.py`
