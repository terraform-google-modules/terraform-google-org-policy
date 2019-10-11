# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Please add new unreleased features here.

## [3.0.0] - 2019-XX-YY
v3.0.0 is a backwards-incompatible release. Please see the [upgrading guide](./docs/upgrading_to_v3.0.md).
### Changed

- **Breaking**: Fixed combining with folders/projects creation [#19] by adding `policy_for` input variable.

## [2.0.0] - 2019-07-25

### Changed

 - Supported version of Terraform is 0.12. [#11]

## [1.0.0]

This is the initial release of the module, with full support for org policy management.

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v3.0.0...HEAD
[3.0.0]: https://github.com/teHEADrraform-google-modules/terraform-google-org-policy/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-org-policy/releases/tag/v1.0.0

[#11]: https://github.com/terraform-google-modules/terraform-google-org-policy/pull/11
[#18]: https://github.com/terraform-google-modules/terraform-google-org-policy/pull/18
