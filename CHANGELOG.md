# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [3.0.2](https://www.github.com/terraform-google-modules/terraform-google-org-policy/compare/v3.0.1...v3.0.2) (2020-02-05)


### Bug Fixes

* Allow for provider 3.x ([#28](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/28)) ([bbcf4c1](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/bbcf4c1c14597c8ba51480d928fcb748d9355051))

## [Unreleased]

Please add new unreleased features here.

## [3.1.0] - 2019-12-05

### Added

- submodules `bucket_policy_only`, `domain_restricted_sharing`, `restrict_vm_external_ips`, `skip_default_network` [#15]

## [3.0.1] - 2019-10-31 :jack_o_lantern:

### Fixed

- The logic controlling the interaction bentween the variables `enforce`, `allow`, and `deny`. [#12]

## [3.0.0] - 2019-10-17
v3.0.0 is a backwards-incompatible release. Please see the [upgrading guide](./docs/upgrading_to_v3.0.md).
### Changed

- **Breaking**: Fixed combining with folders/projects creation by adding `policy_for` input variable. [#19]

## [2.0.0] - 2019-07-25

### Changed

 - Supported version of Terraform is 0.12. [#11]

## [1.0.0]

This is the initial release of the module, with full support for org policy management.

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v3.1.0...HEAD
[3.1.0]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v3.0.1...v3.1.0
[3.0.1]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-org-policy/releases/tag/v1.0.0

[#12]: https://github.com/terraform-google-modules/terraform-google-org-policy/issues/12
[#11]: https://github.com/terraform-google-modules/terraform-google-org-policy/pull/11
[#18]: https://github.com/terraform-google-modules/terraform-google-org-policy/pull/18
[#19]: https://github.com/terraform-google-modules/terraform-google-org-policy/pull/19
[#15]: https://github.com/terraform-google-modules/terraform-google-org-policy/issues/15
