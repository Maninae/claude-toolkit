---
name: share
description: Deploy the last visualization to Vercel and get a live URL. Requires the Vercel CLI to be installed.
argument-hint: [path to HTML file or directory, defaults to last visualization]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch
---

# Share

Deploy a visualization to Vercel for a shareable live URL.

## Invocation

```
/share                            # Share the last visualization
/share ~/.visualize/2024-03-15/dashboard/
/share ./my-report/index.html
```

## Workflow

1. **Locate the visualization**:
   - Explicit path → use it
   - No path → find the most recently modified directory under `~/.visualize/`
   - Verify `index.html` exists in the target directory

2. **Check prerequisites**:
   - Verify `vercel` CLI is installed: `which vercel`
   - If not installed, tell the user: `npm i -g vercel`
   - Verify user is authenticated: `vercel whoami`
   - If not authenticated, tell the user: `vercel login`

3. **Deploy**:
   ```bash
   cd <visualization-directory>
   vercel --prod --yes
   ```

4. **Report**: Show the live URL returned by Vercel.

## Notes

- Vercel free tier supports unlimited static deployments
- Each deploy gets a unique URL — safe to share publicly
- The visualization is fully self-contained (no external dependencies except CDN libs)
- To take down a deployment: `vercel rm <url>`
