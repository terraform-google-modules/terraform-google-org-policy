# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [5.3.0](https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v5.2.2...v5.3.0) (2023-11-14)


### Features

* support inheritance for list constraints on v2 module ([#104](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/104)) ([c4c4663](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/c4c4663aa56bacd72b19354747a117848f0ec955))


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#106](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/106)) ([d482c74](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/d482c743950df6b1d23285fdee4027f782c8e818))

## [5.2.2](https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v5.2.1...v5.2.2) (2023-01-04)


### Bug Fixes

* relax null provider constraint ([#79](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/79)) ([0ba6c56](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/0ba6c56303ec8d92762e41662a609e52a038af30))
* specify rules variable type in org_policy_v2 ([#73](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/73)) ([8ef6e1f](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/8ef6e1fb6a4028cb9b69c07fd0f92cb5bfda2cc0))

## [5.2.1](https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v5.2.0...v5.2.1) (2022-12-29)


### Bug Fixes

* fix folder and project exclusions ([#71](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/71)) ([182c272](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/182c27202c90d087a405f252884fce434cbdfd3a))
* fixes lint issues and generates metadata ([#72](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/72)) ([b800144](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/b80014487aba21ea1ff534f16d4dc3936af89dae))

## [5.2.0](https://github.com/terraform-google-modules/terraform-google-org-policy/compare/v5.1.0...v5.2.0) (2022-09-01)


### Features

* added org_policy_v2 as a submodule supporting conditions ([#58](https://github.com/terraform-google-modules/terraform-google-org-policy/issues/58)) ([af5e9de](https://github.com/terraform-google-modules/terraform-google-org-policy/commit/af5e9dee506032c8daa8f86ddab6fa07672750e2))

## [5.1.0](https://www.github.com/terraform-google-modules/terraform-google-org-policy/compare/v5.0.0...v5.1.0) (2021-12-20)


### Features

* update TPG version constraints to allow 4.0 ([#52](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/52)) ([2d39ed9](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/2d39ed989b09841aacc738121d0909f5e94efa22))

## [5.0.0](https://www.github.com/terraform-google-modules/terraform-google-org-policy/compare/v4.0.0...v5.0.0) (2021-03-19)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#43)

### Features

* add Terraform 0.13 constraint and module attribution ([#43](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/43)) ([61cd430](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/61cd4309985c32707e19e5de9016e6feec6ecefa))


### Bug Fixes

* Change exclusion variables in submodules to accept sets ([#44](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/44)) ([20b6a30](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/20b6a30f0d6590b3d70c20d5c024d6c39adab722))

## [4.0.0](https://www.github.com/terraform-google-modules/terraform-google-org-policy/compare/v3.0.2...v4.0.0) (2020-12-08)


### ⚠ BREAKING CHANGES

* The exclusions have had their state location changed and will be recreated (this is a no-op).

### Features

* Make exclude_folders and exclude_projects use sets and use for_each to avoid unnecessary resource updates ([#32](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/32)) ([5d552af](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/5d552afaf5523dd1434066a047824e09b96cf42f))


### Bug Fixes

* relax version constraints to enable terraform 0.13.x compatibility ([#37](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/37)) ([d29507e](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/d29507eeea8a4aa15713c435f4c15cc24254d1f9))
* use correct module names in documentation ([#30](https://www.github.com/terraform-google-modules/terraform-google-org-policy/issues/30)) ([235338d](https://www.github.com/terraform-google-modules/terraform-google-org-policy/commit/235338d6e9e1fcfad703be1c67ca8de2df1928a4))

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
