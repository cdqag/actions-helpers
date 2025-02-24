# actions-helpers

Helpers for Bash-based GitHub Actions

## Installation

```sh
git submodule add --name helpers -b v1 https://github.com/cdqag/actions-helpers.git your/path/helpers
```

## Usage

Currently, the following helpers are available:

- `job_helpers.sh` - Helpers for job-level operations, like `set_env`, `set_output`, etc.
- `json_helpers.sh` - Helpers for JSON operations, like `is_json`, etc.
- `log_helpers.sh` - Helpers for logging, like `log_info`, `log_warning`, etc.
- `yaml_helpers.sh` - Helper for getting values from YAML files with `log_helpers.sh` integration.

Please check the source code for more details.
