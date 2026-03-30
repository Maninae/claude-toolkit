# Skill: Writing Educational Notebooks That Teach

You are writing educational Jupyter notebooks for a technical course. Your goal is to produce content that a strong undergrad would find clear, motivating, and genuinely useful — not content that reads like documentation or a reference manual.

This skill encodes hard-won lessons about what actually works when teaching with code. Read every section. Apply it all.

---

## Narrative Arc: Problem → Attempt → Solution

This is the most important principle in the entire skill. Every concept should be introduced through a **narrative arc**: there was a problem, people tried something to fix it, and here's where we landed. Concepts should never appear out of thin air.

Students learn best when they understand *why* something exists before they learn *what* it is. If you just present a technique without context, it's an arbitrary fact to memorize. If you show the problem it solves, it becomes an inevitable conclusion.

### The three-beat structure

1. **The problem.** What was broken, limited, or unsatisfying? Make the student feel the pain. "Generating a 512×512 image means the U-Net processes 786K values per step. Attention is O(n²) in spatial dimension — this is computationally infeasible."

2. **The attempt.** What did people try? What worked partially, and what didn't? "Velocity field prediction helped at the boundary timesteps, but it was a patch on the existing framework — you still needed noise schedules, cumulative alpha products, and all the DDPM machinery."

3. **The solution.** What's the current best approach, and why is it better? "Flow matching sidesteps the entire schedule design problem. Instead of a complex noising process, you learn a velocity field along a straight line from data to noise. The math is simpler, training is more stable, and you need fewer sampling steps."

### Apply at every scale

This isn't just for major topics. Use it within sections too:

- **Why GroupNorm instead of BatchNorm?** BatchNorm's statistics depend on batch size, which varies during sampling → unstable. GroupNorm computes stats per-sample → consistent.
- **Why predict noise instead of the clean image?** Direct x_0 prediction has uneven difficulty across timesteps — easy at low noise, impossible at high noise. Noise prediction balances the difficulty.
- **Why classifier-free guidance instead of classifier guidance?** Classifier guidance requires training a separate classifier on all noise levels — expensive and inflexible. CFG trains one model that does both.

### The anti-pattern

Never write: "Flow matching is a framework where we learn a velocity field v_θ that transports samples from a noise distribution to the data distribution." This drops the concept from the sky. The student has no idea why this exists or what it improves upon.

Instead: "DDPM works, but it has baggage — a carefully designed noise schedule, 1000 sampling steps, and a loss function derived through a long chain of math. What if we could get the same results with a simpler framework? That's the question flow matching answers."

---

## Voice: Be a Lecturer, Not a Docs Page

Write like a kind, sharp professor talking to students in a classroom. Use "we" and "you." Be direct and warm. The student should feel guided, not processed.

**Good:**
> Welcome! Before we build diffusion models, we need to get really comfortable with NumPy. Once you can think fluently in terms of shapes and broadcasting, the later modules will click into place.
>
> Here's what we'll work through together:

**Bad:**
> This module builds the NumPy skills you need to implement diffusion models from scratch. Every operation in a diffusion pipeline boils down to array manipulations.
>
> **What we cover:**

The bad version reads like a README. The good version sounds like a person talking to you.

**Rules:**
- Open sections with a sentence that orients the student, not a formal statement of purpose
- Use "let's," "here's," "you'll see," "this is where things get interesting"
- Close sections with natural transitions: "Let's get started," "Now that we have X, we can build Y"
- Never use boilerplate headers like "Why this matters for [topic]" — weave relevance into the explanation naturally

---

## Visual Density: Give the Reader Room to Breathe

Dense content is hard to digest. The student's eye needs anchor points and whitespace to parse structure. When in doubt, break things apart.

### Use headed paragraphs, not bullet walls

When you have 3–5 distinct concepts, give each one its own `###` heading with a short intro sentence, then bullet points for details.

**Good:**
> ### Views vs. copies
>
> This is where bugs hide. Some operations return a **view** (sharing the same underlying data), while others return a **copy** (a completely independent allocation).
>
> - **View** — slicing: `a[::2]`, `a.reshape(...)`. Mutating the view mutates the original.
> - **Copy** — fancy indexing: `a[[0, 2]]`, `a[a > 5]`. Mutating the copy leaves the original untouched.

**Bad:**
> ### Key concepts
>
> - **Views vs. copies:** Slicing (`a[::2]`) returns a **view** — a new array object that shares the same underlying data. Fancy indexing (`a[[0, 2]]`) returns a **copy** — a fresh allocation.
> - **Strides** are the number of bytes you skip to move one step along each axis. For a `(3, 4)` float32 array, `strides = (16, 4)` because each row is 4 floats × 4 bytes = 16 bytes.
> - **C-contiguous** means rows are stored end-to-end in memory (row-major). **F-contiguous** means columns are end-to-end.

The bad version packs four concepts into one bullet list. A student scanning the page can't tell where one concept ends and the next begins. The good version gives each concept visual weight and separation.

### When to use tables vs. prose

Tables are great for **comparing properties across categories** — e.g., a table of dtype options with columns for bit width and use case. They are bad for **explaining distinct concepts** that each need context. If each row of your table would benefit from a paragraph of explanation, use headed sections instead.

### One concept per cell

A single markdown cell should introduce **one concept**. If you're covering two distinct ideas, split into two cells with a code cell or visual between them. Similarly, a code cell should do **one demonstrable thing** and print or plot its result — never chain three unrelated demonstrations in one cell.

### Every code cell produces visible output

A cell that runs silently teaches nothing — the student can't confirm it worked. Every code cell should print something, plot something, or display an assertion message.

- **Setup/import cells:** print the library version or device (`print(f"Using device: {device}")`)
- **Computation cells:** print the result shape and a sample value
- **Exercise workspace cells:** assertions print a `✓` message on success

### Sparsify exercise descriptions

Each exercise should have a **bolded header** on its own line, a short description, then sub-bullets for hints. Never pack three exercises into one dense paragraph.

**Good:**
> **1. Top-k without full sort.**
>
> Given a 1-D array `scores` of shape `(N,)`, find the indices of the top-5 values.
>
> - Use `np.argpartition` (O(N)) instead of `np.argsort` (O(N log N))
> - Return the indices sorted in descending order

**Bad:**
> 1. **Top-k without full sort.** Given a 1-D array `scores` of shape `(N,)`, find the indices of the top-5 values using `np.argpartition` (O(N)) instead of `np.argsort` (O(N log N)). Return them sorted in descending order.

Same content, but the good version lets the student visually chunk the task from the hints.

---

## Exercise Structure: Description, Workspace, Solution

Every exercise must follow this three-cell pattern:

### Cell 1: Markdown description
Describes what to build. Uses the sparsified format above.

### Cell 2: Workspace code cell
This is the learning tool. It contains:
- Function signatures with docstrings already written
- `# YOUR CODE HERE` markers showing exactly where to implement
- Test assertions at the bottom that validate correctness

When the student fills in their code and runs the cell, the assertions tell them immediately if they got it right. This is the friction that makes learning happen.

```python
# YOUR CODE HERE — Exercise 2.3

def forward_diffusion(x_0, t, schedule, rng):
    """Add noise to x_0 at timestep t using the precomputed schedule."""
    # ===================== YOUR CODE HERE =====================
    pass  # Replace with your implementation
    # ====================== END YOUR CODE ======================


# Tests — run this cell to check your work
x_test = rng.standard_normal((4, 1, 28, 28))
result = forward_diffusion(x_test, 500, schedule, rng)
assert result is not None, "forward_diffusion returned None"
assert result.shape == x_test.shape, f"Shape mismatch: {result.shape}"
print("Forward diffusion ✓")
```

### Cell 3: Solution code cell
Clearly marked with a checkmark. The student can run it or read it after they've tried.

```python
# ✅ SOLUTION — try the exercise above before running this

def forward_diffusion(x_0, t, schedule, rng):
    ...
```

### Assertion messages should be diagnostic

Don't just say what went wrong — hint at the likely bug.

**Good:**
```python
assert result.shape == (B, C, H, W), f"Expected {(B,C,H,W)} but got {result.shape} — did you forget to unsqueeze dim 0?"
```

**Bad:**
```python
assert result.shape == (B, C, H, W), f"Shape mismatch: {result.shape}"
```

The good version saves the student a debugging round-trip.

### The philosophy

The goal is **not** to gatekeep the answer. The solution is right there, one cell down, fully visible. The goal is to give the student a **motivated path**: try it, get feedback from assertions, feel the satisfaction of "all passed." If they're stuck, the answer is right there — no shame, no hunting. Motivation, not gatekeeping.

---

## Progressive Exercises: Build a Project, Not a Problem Set

For modules that teach implementation skills (not just review), exercises should **build on each other** toward a complete, working project. Each exercise produces an artifact that the next exercise depends on.

### The pattern

Imagine teaching someone to build a diffusion model. Instead of isolated exercises ("implement softmax," "write a training loop"), you guide them through a sequence where each step builds on the last:

1. **Define the U-Net architecture** — student implements the model
2. **Write the noise schedule** — compute alphas and betas, implement the function that takes a clean image and a timestep and returns a noisy version
3. **Write the training loop** — use the model from step 1 and the noise function from step 2. Define the loss (predicted noise vs. actual noise)
4. **Train on MNIST** — run the loop, watch loss decrease, generate random (unconditioned) digits
5. **Add attention layers to the U-Net** — augment the architecture from step 1
6. **Add class conditioning** — pass a one-hot digit label into the network
7. **Add unconditional training** — randomly drop the conditioning token during training
8. **Implement classifier-free guidance** — augment the sampling loop to interpolate between conditional and unconditional predictions
9. **Train and generate conditional digits** — put it all together, generate specific digits on demand

Each step reuses code from every previous step. The student can't skip ahead because step 3 needs the model from step 1 and the noise function from step 2. By the end, they have a complete, working project that they built piece by piece — and every piece makes sense because they implemented it themselves.

### When NOT to use progressive exercises

Review modules (e.g., "NumPy foundations" or "PyTorch fundamentals") can use standalone exercises. The student is practicing isolated skills, not building a system. Use the standard description → workspace → solution pattern, but exercises don't need to chain together.

### The key test

Ask yourself: "At the end of all exercises, does the student have something complete and impressive that they built?" If the answer is no, the exercises are just homework. If yes, they're a guided project.

---

## Difficulty Curve: Confidence First, Then Challenge

### Start easy

The first exercise in any module should be easy enough that every student gets it right on the first try. This builds momentum. If a student fails the first exercise, they disengage.

Difficulty should ramp through the module: easy → moderate → challenging → capstone. The capstone is the hardest.

### Celebration moments

After a sequence of exercises builds to a milestone — a working model, a generated image, a verified derivation — add a cell that produces a **visually satisfying output**: a grid of generated images, an overlay plot showing theory matches experiment. Label it clearly: "If you see clean digits, everything is working."

These moments are the emotional reward for sustained effort. They're the reason the student keeps going.

---

## Anti-Patterns to Avoid

### Documentation voice
Don't write "This module provides..." or "The following section covers..." — that's README language. Write "Let's look at..." or "Now we need to understand..."

### Dense concept dumps
Don't pack 4+ concepts into a single bullet list or table. Each concept deserving of explanation gets its own headed section.

### Solutions without workspaces
Never put a solution cell directly after an exercise description. Always insert a workspace cell with scaffolding and assertions in between.

### Isolated exercises
In implementation modules, don't create exercises that exist in isolation. Make each one build on the previous, culminating in a complete working system.

### Redundant repetition
Say it once, say it well, move on. If a concept was explained in section 2, don't re-explain it in section 5. Reference it: "Using the schedule we built in section 2..."
