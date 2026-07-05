---
name: resume-superpowers
disable-model-invocation: true
description: Recover after context compaction - read saved state and git history, then continue the active skill
---

- Read `.superpowers/active-skill.md` if it exists.
- Read `.superpowers/sdd/progress.md` if it exists.
- Run `git log --oneline -20`.
- If checkpoint files exist (meaning superpowers was previously loaded), re-invoke `/using-superpowers` so the skill-routing rule is re-established.
- If `.superpowers/active-skill.md` names a specific skill other than `using-superpowers`, invoke that skill after /using-superpowers.
- Re-state the active skill and next step.
- Continue from saved state, not memory.
- If no checkpoint files exist, ask the user what was happening before compaction.
