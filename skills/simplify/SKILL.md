---
name: simplify
description: Review recently changed or pasted code and cut accidental complexity without changing behavior. Use whenever the user says "simplify", "clean this up", "this feels over-engineered", "reduce this", "tighten this", or asks to review a diff, PR, or recent edits for bloat, dead code, needless abstractions, deep nesting, or readability, even if they never say the word "simplify".
---

# Simplify

Shrink code to the smallest surface area that still does the same job. Less code means fewer bugs and faster reviews, so every line you remove or flatten is a win, as long as behavior stays identical.

## Core rules

1. **Preserve behavior.** Never change functional behavior, public contracts, or what tests expect. A simplification that alters output is a bug, not a cleanup.
2. **Strip indirection.** Inline single-use helpers, speculative interfaces, and pass-through wrappers. An abstraction only earns its place if it has more than one real caller.
3. **Keep diffs surgical.** Touch only code that benefits. Reformatting unrelated lines buries the real changes and makes review harder.
4. **Use guard clauses.** Flip deeply nested `if/else` into early returns so the happy path reads top to bottom.
5. **Delete dead code.** Remove unused imports, variables, and unreachable branches, including ones your own edits just orphaned.

## Workflow

1. **Find the scope.** Use the git diff if a repo is available (`git diff` or `git diff HEAD~1`). If the user pasted code or named files, use that. If there is no clear scope, ask which files to look at.
2. **Spot over-engineering.** Look for:
   - 200 lines doing what 50 can do cleanly
   - Redundant state, needless memoization, premature abstraction
   - Duplicate logic that one small function or loop would replace
   - Comments that restate the code
3. **Apply the smallest refactor that fixes each issue.** Do one kind of change at a time so each is easy to verify.
4. **Verify.** If a test suite exists and you can run it, run it and confirm zero regressions. If you can't run tests, say so and list which behaviors you reasoned about instead.

## Output

Give the simplified code, then a short change list: what was removed or flattened and why. Keep it to a line per change. If the code was already lean, say so and leave it alone rather than inventing edits.

Flag anything that looks wasteful but that you left because removing it might change behavior (for example, a wrapper that adds error handling, or an "unused" export that may be imported elsewhere).
