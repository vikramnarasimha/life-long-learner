# Exercise: Build a Simple Cloud Storage Manager

## 🎯 Objective

Build a command-line tool to manage files in Google Cloud Storage.

## 📋 Requirements

Create a Python CLI tool that can:

1. List all files in a bucket
2. Upload a file to a bucket
3. Download a file from a bucket
4. Delete a file from a bucket
5. Show file metadata (size, created date, etc.)

## 🚀 Getting Started with AI

### Step 1: Planning

Ask Copilot:
```
"I want to build a CLI tool for managing GCP Cloud Storage. 
What's the best structure for this project? 
Should I use argparse or click for the CLI?"
```

### Step 2: Setup

Ask Copilot:
```
"Show me the basic project structure and 
how to set up the GCP storage client"
```

### Step 3: Implementation

Write comments for each function and let Copilot help:

```python
# Create a CLI command to list all files in a bucket
# Use click library for the CLI
# Show file name, size, and last modified date

# Create a CLI command to upload a file
# Add progress indicator for large files
# Handle errors gracefully
```

### Step 4: Enhancement

Ask Copilot:
```
"How can I add features like:
- Progress bars for uploads/downloads
- Parallel uploads for multiple files
- Caching to avoid repeated API calls
- Better error messages"
```

## ✅ Acceptance Criteria

- [ ] Code is well-structured and documented
- [ ] Error handling is implemented
- [ ] Help messages are clear
- [ ] Works with real GCP bucket
- [ ] Includes examples in README

## 🎓 Learning Goals

- Practice using GCP Python SDK
- Learn CLI development
- Understand error handling
- Work with file I/O
- Use AI for code generation and review

## 💡 Extension Ideas

1. Add batch operations (upload/download multiple files)
2. Implement file syncing (like rsync)
3. Add support for setting storage classes
4. Create a web UI version
5. Add encryption for sensitive files

## 📝 Hints

If stuck, ask Copilot:
- "Show me examples of click CLI commands"
- "How do I handle large file uploads efficiently?"
- "What's the best way to structure this code?"
- "Review my code for improvements"

## 🔗 Resources

- GCP Storage Python Client: https://googleapis.dev/python/storage/latest/
- Click Documentation: https://click.palletsprojects.com/
- Example CLI tools for inspiration
