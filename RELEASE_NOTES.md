# Release Notes

Release notes for various versions of RSpec::GraphQLResponse

See [the upgrade guide](/UPGRADE.md) for details on changes between versions and how to upgrade.

## v0.2.0 - GraphQL Configuration DSL and Refactorings

Misc changes and corrections, some new features, and generally trying to create a more robust
and usable experience, right out of the box.

### New Features

- Significantly improved documentation
- `have_operation` matcher
- GraphQL configuration DSL
  - `graphql_query`
  - `graphql_variables`
  - `graphql_context`
- Describe/Context level RSpec helper methods via `.add_context_helper` DSL

### Breaking Changes

This release changes the graphql query, variables and context configuration away from `let` vars
and into a proper DSL.

### Bug Fixes

Lots of misc bug fixes, including caching of values, ensuring things work in nested contexts, etc.

## v0.1.0 - Initial Release

Early beta work to get this out the door and begin adoption

- `have_errors` matcher
- `operation` helper
- `response` helper
- `execute_graphql` helper
- DSL for adding custom matchers, validators, and helpers
