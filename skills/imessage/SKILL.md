---
name: imessage
description: Use when the user asks to send a text, message, note, file, or reminder to themselves or someone via iMessage. Also for reading message history and watching for incoming messages.
---

# iMessage

Send, read, and watch iMessages via the `imsg` CLI tool.

## Owner's Number

(510)402-7694 — use this when the user says "text me", "send to myself", "message me", etc.

## Commands

```bash
# Send a text
imsg send --to "(510)402-7694" --text "Your message here"

# Send a file
imsg send --to "(510)402-7694" --file /absolute/path/to/file

# Send text + file
imsg send --to "(510)402-7694" --text "Check this out" --file /absolute/path/to/file

# List recent chats
imsg chats --json

# Read message history for a chat
imsg history --chat-id <id> --limit <n> --json

# Watch for incoming messages
imsg watch --json
```

## Notes

- Messages.app must be signed in and running
- Use absolute paths for file attachments
- Works with phone numbers or email addresses as the recipient
- Use `imsg chats --json` to find the chat-id for history lookup
- `imsg` is installed at `~/bin/imsg`
