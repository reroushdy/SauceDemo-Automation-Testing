# Testing Notes

This document captures testing philosophy, coverage considerations, and prioritization decisions for the SauceDemo automation project.  
It exists to explain **why** certain tests were written and **how** risk was evaluated.

---

## 🧠 Testing Philosophy

This project follows a **risk-based testing** approach.

The goal is not maximum test count, but:
- Fast feedback on critical failures
- Clear signal when user workflows break
- Actionable failures that support triage

Automation is treated as a **decision-support tool**, not a substitute for thinking.

---

## 🎯 Test Coverage Strategy

Coverage is evaluated across **functional domains**, not individual UI elements.

### Covered Domains
- Authentication & authorization
- Inventory browsing & sorting
- Cart behavior
- Checkout validation & completion
- Error handling for invalid inputs

Each domain has:
- At least one **happy-path** test
- Targeted **negative tests** for validation
- Selected **edge cases** where user behavior is ambiguous

---

## 🧪 Test Types Used

| Test Type       | Purpose |
|-----------------|---------|
| Smoke           | Validate the application is usable at all |
| Functional      | Confirm core workflows behave correctly |
| Negative        | Ensure invalid actions fail safely |
| Edge Case       | Catch boundary behaviors (e.g., whitespace input) |
| Data-Driven     | Validate consistent behavior across multiple inputs |

Regression suites are organized **by domain**, not by execution order.

---

## ⚖️ Priority vs Severity

Priority and severity are treated as **separate concepts**.

### Severity
How badly the issue impacts the user if it occurs.

- **Critical**: User cannot complete checkout
- **High**: Core workflow degraded but recoverable
- **Medium**: Validation errors or incorrect messaging
- **Low**: Visual or non-blocking issues

### Priority
How urgently the issue must be fixed.

Priority is influenced by:
- Business impact
- Frequency
- Visibility
- Risk of cascading failures

---

### Example Mapping

| Scenario | Severity | Priority |
|--------|----------|----------|
| Checkout cannot complete | Critical | P0 |
| Missing required field error | Medium | P1 |
| Whitespace accepted incorrectly | Medium | P2 |
| Cosmetic alignment issue | Low | P3 |

Not all severe bugs are high priority, and not all high priority bugs are severe.

---

## 🧭 Why Some Tests Are Not Included

Certain test types are intentionally excluded or minimized:

- Visual regression (out of scope for this project)
- Performance testing (not meaningful on demo site)
- Security testing beyond basic validation

These exclusions are **documented decisions**, not omissions.

---

## 🔁 Future Expansion

Potential additions if this were a production system:
- Contract tests against real APIs
- CI-triggered smoke runs per commit
- Visual diffs for checkout confirmation
- Data-quality checks on backend responses

---

## ✅ Summary

This project emphasizes:
- Clear intent over exhaustive coverage
- Tests that fail for meaningful reasons
- Documentation that explains testing choices

The automation is designed to be **maintainable, explainable, and expandable**.