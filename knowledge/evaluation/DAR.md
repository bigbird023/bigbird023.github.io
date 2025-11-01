---
layout: page
title: DAR Evaluation Methodology
permalink: /knowledge/evaluation/DAR

---

# DAR (Vendor) Evaluation Methodology

Note: This document describes a DAR process tailored to vendor evaluation and selection — mapping business and technical requirements to vendor responses, scoring vendors, and producing a defensible recommendation. The methodology focuses on requirements, weighting, scoring, risk, and total-cost-of-ownership (TCO) considerations.

## Purpose

Provide a repeatable, auditable vendor evaluation process that converts requirements into weighted scores and a final ranked shortlist. Use DAR to justify vendor selections and record trade-offs.

## Key Concepts

- Requirement: A stated functional or non-functional need (e.g., "Supports OAuth 2.0", "99.95% uptime SLA").
- Priority: MUST / SHOULD / NICE-TO-HAVE (maps to weight).
- Vendor Response: How the vendor meets the requirement (Yes / Partial / No), optionally with evidence links.
- Score: Numeric value computed per requirement and aggregated.
- Risk & Notes: Qualitative notes about uncertainty, integration risk, or vendor maturity.

## Process Overview

1. Define Requirements — gather functional, non-functional, security, compliance, integration, and commercial requirements.
2. Assign Priority & Weight — label each requirement MUST/SHOULD/NICE and map to numeric weight.
3. Request Responses — distribute RFI/RFP to vendors; capture responses and evidence.
4. Score Responses — for each vendor, score each requirement according to a consistent rubric.
5. Aggregate Scores — compute weighted totals and normalize to compare vendors.
6. Risk Assessment — capture qualitative risks, gaps, and mitigations.
7. Recommendation & TCO — produce a ranked recommendation and include estimated implementation cost and TCO.

## Requirement Priority → Weight (suggested)

- MUST: Weight = 5
- SHOULD: Weight = 3
- NICE-TO-HAVE: Weight = 1

Adjust weights to fit organizational needs; the important part is consistency across vendors.

## Scoring per Requirement (suggested rubric)

- Full support (Yes) = 1.0
- Partial support (Partial / Workaround) = 0.5
- No support (No) = 0.0

Optional: allow differentiation for "Native" support vs. "Third-party plugin" by scoring 1.0 vs. 0.75.

## Aggregation formula

For each vendor:

WeightedScore = SUM( RequirementWeight * RequirementScore )

Normalize (if desired) to a percentage:

NormalizedScore = WeightedScore / SUM(RequirementWeight) * 100

Use NormalizedScore to compare vendors on a 0–100 scale.

## Recommended Spreadsheet Tabs (and example columns)

Below are suggested tabs and example tables that map to columns you can import into Excel/Sheets. Each tab corresponds to a typical RFP evaluation workflow.

### Tab: Requirements Master

Columns: ReqID | Category | Requirement | Priority (MUST/SHOULD/NICE) | Weight | Notes

Example rows:

| ReqID | Category | Requirement | Priority | Weight | Notes |
|---|---|---|---|---:|---|
| R-001 | Security | Support OAuth 2.0 / OpenID Connect | MUST | 5 | Native support preferred |
| R-002 | Availability | SLA 99.95% | SHOULD | 3 | Prefer financially-backed SLA |
| R-003 | Integration | Out-of-the-box connector for ServiceNow | NICE | 1 | Can be custom-built if needed |

### Tab: Vendor Responses (raw)

Columns: Vendor | ReqID | Response (Yes/Partial/No) | Evidence Link | Comments

Example rows:

| Vendor | ReqID | Response | Evidence Link | Comments |
|---|---:|---|---|---|
| Vendor A | R-001 | Yes | https://... | Native OIDC python lib |
| Vendor A | R-002 | Partial | https://... | SLA depends on plan |
| Vendor B | R-001 | Partial | doc.pdf | Plugin required |

### Tab: Scoring (per vendor)

Columns: Vendor | ReqID | Weight | Score (0/0.5/1) | Weighted Score = Weight * Score | Notes

Example rows:

| Vendor | ReqID | Weight | Score | Weighted Score | Notes |
|---|---:|---:|---:|---:|---|
| Vendor A | R-001 | 5 | 1.0 | 5.0 | Native OIDC |
| Vendor A | R-002 | 3 | 0.5 | 1.5 | SLA tier required |

### Tab: Scoring Summary

Columns: Vendor | Total Weighted Score | Max Possible Score | Normalized Score (%) | Rank | TCO Estimate | Final Notes

Example rows:

| Vendor | Total Weighted Score | Max Possible Score | Normalized Score (%) | Rank | TCO Estimate | Final Notes |
|---|---:|---:|---:|---:|---:|---|
| Vendor A | 48.5 | 60 | 80.8 | 1 | $1.2M | Strong fit; minor SLA gap |
| Vendor B | 41.0 | 60 | 68.3 | 2 | $900k | Needs custom integration |

### Tab: Risk & Gaps

Columns: Vendor | ReqID | Risk Level (High/Med/Low) | Description | Mitigation | Residual Risk

Example rows:

| Vendor | ReqID | Risk Level | Description | Mitigation | Residual Risk |
|---|---:|---|---|---|---|
| Vendor B | R-001 | Medium | Requires custom plugin, vendor support limited | Plan for in-house connector; budget 120h | Low |

### Tab: Commercial & TCO

Columns: Vendor | License Cost (Year 1) | Implementation Cost | Ongoing Cost / Year | 3-yr TCO | Notes

Example rows:

| Vendor | License Cost (Y1) | Implementation Cost | Ongoing Cost / Yr | 3-yr TCO | Notes |
|---|---:|---:|---:|---:|---|
| Vendor A | $400k | $300k | $200k | $1.3M | Assumes 2-year discount |

## Scoring Tips & Normalization

- Use consistent mapping of responses to score values (Yes=1, Partial=0.5, No=0).
- Consider soft-cap weighting: if an item is a blocking MUST and a vendor scores 0, mark vendor as ineligible automatically.
- Normalize to percentage to present to stakeholders.

## Example formulas (Excel/Sheets)

- WeightedScore per vendor (sum product):

  = SUMPRODUCT(WeightsRange, ScoresRange)

- Normalized Score (%) = WeightedScore / SUM(WeightsRange) * 100

## Decision & Recommendation

- Combine normalized requirement score with TCO and Risk analysis to produce an overall recommendation.
- Present top-3 vendors with a summary of strengths, gaps, and mitigations.

## Appendix: Sample spreadsheet setup notes

- Ensure `Requirements Master` has a unique `ReqID` column that matches the `ReqID` column on the `Vendor Responses` and `Scoring` tabs so you can use VLOOKUP / INDEX-MATCH to pull weights into the scoring calculations.
- Add conditional formatting to `Scoring Summary` to highlight top performers and any vendors that fail MUST requirements (red).
- Protect the `Requirements Master` tab to prevent accidental weight changes during scoring.

---

If you'd like, I can generate an example XLSX file with these tabs and the example rows and add it to the repository. I can also add a short script to ingest vendor responses (CSV) and compute scores automatically.

- add concurrency guard | 24 | perf test: 10k r/s smoke | revert deployment via job | In Progress | |

### Tab: Audit Log / Decision History

Fields: ID | Date | Actor | Action | Comments

Example rows:

| ID | Date | Actor | Action | Comments |
|---:|---|---|---|---|
| DAR-0001 | 2025-10-02 | Triage Lead | Assigned | prioritized as High based on user impact |
| DAR-0001 | 2025-10-03 | Tech Assessor | Recommendation | recommended hotfix; tests added |

### Tab: Metrics / KPIs

Fields: Metric | Baseline | Current | Target | Notes

Example rows:

| Metric | Baseline | Current | Target | Notes |
|---|---:|---:|---:|---|
| Mean Time to Remediate (MTTR) | 20 days | 12 days | 7 days | Track per priority bucket |
| Deployment success rate | 95% | 98% | 99.5% | post-pipeline improvements |

## Example: How to use the spreadsheet

1. Intake team or automated scanner creates a row in the Intake tab.
2. Triage Lead moves the item to Assessment and assigns the Technical Assessor.
3. Technical Assessor fills the Assessment tab (impact, likelihood, effort) and notes their Recommendation.
4. PriorityScore is calculated (spreadsheet formula) and color-coded to show critical items.
5. Owners plan remediation in the Remediation Plan tab and record progress.
6. The Audit Log records all status changes and key decisions.

## Example formulas (Excel/Sheets)

- PriorityScore (Excel):

  = (Impact * 0.5) + (Likelihood * 0.3) + ((5 - Effort) * 0.2)

- Color coding (conditional formatting):
  - PriorityScore >= 4 => Red (Critical)
  - PriorityScore >= 3 => Orange (High)
  - PriorityScore >= 2 => Yellow (Medium)
  - PriorityScore < 2 => Green (Low)

## Best practices

- Keep descriptions concise but include reproduction steps for technical findings.
- Require an owner for every item; escalate unowned critical items daily.
- Track time-to-remediate and use KPIs to evaluate process improvements.
- Keep the audit log immutable (append-only) to preserve decision history.

## Next steps / Templates

- Copy the tables above into a new spreadsheet and add formulas for PriorityScore and conditional formatting.
- Integrate your tracking tool (Jira/GitHub Issues) to auto-create or sync DAR items into the Intake tab.
- Create a short runbook for Triage Leads that outlines the daily triage meeting cadence and SLA targets.
