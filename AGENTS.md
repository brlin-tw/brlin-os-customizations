# AI agent instruction file

This file contains instructions and guidelines for AI agents interacting with this repository. It outlines the expected behavior, coding standards, and collaboration protocols to ensure effective and efficient contributions.

## Agent Skills Overview

This project make use of [Agent Skills](https://agentskills.io/), which are modular capabilities that AI agents can utilize to perform specific tasks.

If you don't have the concept of Agent Skills, refer to the following instructions to make use of them:

1. List the leading directories of the following sub-directories to understand which skills are available:
    + `.claude/skills/`
    + `~/.claude/skills/`
    + `.gemini/skills/`
    + `~/.gemini/skills/`
    + `.github/skills/`
    + `~/.copilot/skills/`
1. Read the `description` key of the YAML front matter of the SKILL.md file under each leading directory to understand its purpose and when to use it.
1. Fully read the SKILL.md file of a skill only if its trigger condition matches the task.  For example, code-review tasks must load `skills/code-review/SKILL.md`.  Once loaded, follow the process and output format defined in the skill file so that the final response remains consistent.

**Response contract**:

* Explicitly state which skills and rules are in effect.
* Provide findings, recommendations, or code while enforcing all loaded constraints. If any conflicts arise, ask for clarification before diverging.
