---
layout: default
title: DAR Evaluation Methodology
permalink: /knowledge/DAR_Evaluation

---

# DAR Evaluation Methodology

This document describes a repeatable methodology for evaluating DAR (Data, Application, and Release) items — a lightweight, auditable process for scoring, prioritizing, and tracking remediation or acceptance decisions. The guidance below includes roles, steps, a scoring rubric, data collection instructions, and example spreadsheet tab layouts (presented as Markdown tables) you can import into Excel/Sheets.

## Purpose

The DAR evaluation formalizes how technical findings, change requests, vulnerabilities, or new features are assessed, prioritized, and tracked from discovery through closure. It provides consistent scoring, clear ownership, and records decisions.

## Scope

- Types of items covered: security findings, defect reports, configuration drifts, feature requests, and deployment rollbacks.
- Environments: dev, test, staging, production.
- Stakeholders: engineering teams, security, operations, product owners.

## Roles & Responsibilities

- Submitter: Provides initial description and steps to reproduce.
- Triage Lead: Reviews new items, assigns severity and initial owner.
- Technical Assessor: Engineers who analyze root cause and suggest remediation.
- Product/Business Owner: Confirms business impact and priority.
- Closure Approver: Validates remediation and closes the item.

## High-level Process

1. Intake: Item submitted into tracking system with required metadata.
2. Triage: Triage Lead assigns an initial severity and owner.
3. Assessment: Technical Assessor performs analysis, estimates work, and recommends action (Fix / Accept / Monitor / Defer).
4. Scoring & Prioritization: Apply scoring rubric to produce a priority score.
5. Planning: Place the item into a sprint/backlog or schedule maintenance window.
6. Remediation: Implement and test fix; update verification steps.
7. Closure: Closure Approver verifies the fix and marks the item closed.

## Scoring Rubric

Use a simple numeric rubric to make prioritization defensible. Final priority is a weighted sum of Impact, Likelihood (or Frequency), and Effort.

- Impact (1–5): Business or user impact (1 = negligible, 5 = critical outage).
- Likelihood (1–5): Probability or frequency of occurrence (1 = rare, 5 = frequent).
- Effort (1–5): Estimated engineering effort to remediate (1 = trivial, 5 = large multi-week project).

PriorityScore = (Impact * 0.5) + (Likelihood * 0.3) + (5 - Effort) * 0.2

Higher PriorityScore means higher priority (max 5.0). The formula weights Impact most heavily, reduces priority for high-effort items, and balances frequency.

Suggested buckets (after computing PriorityScore):

- 4.0 – 5.0: Critical — schedule immediate remediation or emergency patch.
- 3.0 – 3.99: High — remediate in upcoming sprint.
- 2.0 – 2.99: Medium — schedule in roadmap.
- 0.0 – 1.99: Low — monitor or defer.

## Required Intake Fields

When submitting a DAR item, require at minimum:

- ID (auto-generated)
- Title
- Submitter
- Date submitted
- Environment (dev/test/staging/prod)
- Component / Service
- Short description
- Steps to reproduce (if applicable)
- Initial severity (low/medium/high/critical)
- Attachments / logs / screenshots

Optional but helpful:
- Suggested owner
- Estimated impact metric (e.g., users affected, RTO/RPO)
- Suggested SLA

## Data Collection & Evidence

- Collect logs, stack traces, configuration files, screenshots, and any relevant metrics (CPU, request rate, error rate).
- Record console commands and outputs for reproducible evidence.
- If the item is security-related, include vulnerability scanner output and the exact path to reproduce.
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

---

This page provides a starting point — tell me which parts you'd like to expand (e.g., sample scripts to extract data, a Jira automation recipe, or printable runbooks) and I'll add them.