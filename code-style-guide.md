Code Style Guide
================

General advise for writing code across all languages.

Advice for Code Readability
---------------------------

There’s no such thing as a specifically `temp` variable, they’re all temporary. Use names appropriate to the content of the variable, rather than the purpose.

Where possible, boolean flags (for example, in the database) should be positive (e.g. `visible` over `hidden`).

Using `args` or `params` as a variable is not recommended as that is somewhat implied. A variable name should include what’s in the variable, rather than its purpose.
