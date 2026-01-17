---
name: developing-shell-scripts
description: Provide guidelines on how to develop bash shell scripts that are compliant with project standards.  Should be used when generating, modifying, or reviewing bash scripts.
---

# The developing-shell-scripts skill

This skill provides guidelines on how to develop bash shell scripts that are compliant with project standards.  It should be used when generating, modifying, or reviewing bash scripts.

## Bash coding style

The following coding style guidelines should be followed when writing Bash scripts:

### Shebang

Use `#!/usr/bin/env bash` as the shebang line for portability across different environments.

### Parameter naming

* Use lowercase letters and underscores for variable names (e.g., `my_variable`) to enhance readability.
* Only use uppercase letters for variables whose values are sourced from the environment.

### Parameter expansion

Use `${var}` instead of `$var` for variable references to improve readability and avoid ambiguity.

This also applies to positional parameters, e.g., use `${1}` instead of `$1`.

### Message reporting

* If the program's output is intended to be used as input for other programs, avoid implementing non-error messages at all.
* Use `printf` instead of `echo` for formatted output.
* Prepend log level tags in the following format(except for help text):
    + `Info:`
    + `Warning:`
    + `Error:`
    + `FATAL:`
    + `DEBUG:`

### Linting

Use ShellCheck for linting.

### Defensive interpreter behavior

The following shell options should be set at the beginning of each script to ensure robust error handling:

```bash
set -o errexit   # Exit on most errors (see the manual)
set -o nounset   # Disallow expansion of unset variables
```

Do not set `pipefail`.

If the script contains functions, also include:

```bash
set -o errtrace  # Ensure the error trap is inherited
```

### Conditional constructs

* When using `if...else` constructs, always check the incorrect condition first.  For example:

    ```bash
    if ! is_port_valid "${user_input}"; then
        printf \
            'Error: Invalid port number, please try again.\n' \
            1>&2
        return 1
    else
        # Do something when the condition is expected
    fi
    ```

* Use the `test` shell built-in for conditional expressions.  For example, use `if test -f "file"` instead of `if [[ -f "file" ]]`.

  The only exception is when using regex matching, which requires `[[ ... ]]`.  When doing so always define a regex_pattern variable instead of embedding the regex directly in the conditional expression.

### Pattern matching

* Use the `[[ ... ]]` construct for validating user inputs when applicable.

  Store the regex pattern in a `regex_` prefix variable instead of embedding it in the conditional expression.  For example:

   ```bash
    local regex_digits='^[[:digit:]]+$'
    if [[ "${user_input}" =~ ${regex_digits} ]]; then
        # Do something when the input is a number
    fi
    ```

### Passing data to subprocesses

* Using the Here Strings syntax (`<<<`) is preferred when passing small amounts of data to subprocesses.  For example:

    ```bash
    grep 'pattern' <<< "${data_variable}"
    ```

### Functions

* Use `function_name(){ ... }` syntax for defining functions. Do not use the `function` keyword.
* Always use `local` for function-local variables.
* Do not use global variables inside functions. Instead, pass them as arguments.
* Use the following pattern to retrieve function arguments:

    ```bash
    local var="${1}"; shift
    ```

  Always use `${1}` parameter expansion and append `shift` command even when the function only has one parameter. This allows cleaner diffs when adding or removing arguments.

* Validate input parameters at the beginning of functions
* Always use `return` to return an exit status from functions.  Only use the `exit` builtin in the `init`/`main` function as it is the main logic of the script.
* Place all non `init`/`main` functions _after_ the `init`/`main` function in the script. This allows script readers to access the main script logic easily.
* Use imperative tense for function names.

### Error Handling

* Always check the exit status of commands and handle errors appropriately, don't rely solely on the ERR trap.
* Do not use AND/OR lists syntax.

### Script template

[The template script](template.sh) script should be used for creation of new scripts.

For the following placeholders in the template:

* `_copyright_holder_name_`
* `_copyright_holder_contact_`

use the `user.name` and `user.email` from git config respectively.
