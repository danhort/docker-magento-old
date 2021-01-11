# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.4] - 2021-01-10
### Fixed
- Downgrade composer to version 1 (Magento does not support composer 2)

## [0.5.3] - 2020-12-18
### Fixed
- Makefile db import and export bug

## [0.5.2] - 2020-11-10
### Added
- patch library ro PHP7.4 

## [0.5.1] - 2020-11-10
### Fixed
- Makefile conflict error

## [0.5.0] - 2020-10-30
### Added
- Varnish
- Ioncube to PHP 7.3 container
- Add base_static_url and base_media_url and elastic host to env.php sample
- Add fastcgi_buffer_size to nginx
- Added PHP 7.4
### Changed
- Updated elasticsearch to 7.6
### Removed
- Remove unused bin script

## [0.4.0] - 2020-05-19
### Added
- npm to PHP 7.0, 7.1, 7.2 and 7.3
- npm and grunt commands to makefile

## [0.3.0] - 2020-05-18
### Fixed
- Swapped clear-assets src path with env path
### Changed
- Removed www from env sample default urls
### Added
- config file update method to update bin script

## [0.2.0] - 2020-05-06
### Added
- PHP7.3

## [0.1.0] - 2020-04-29
### Changed
- The update command now checks for the latest tag
- The magento-docker bash tool now initiates the latest tag

## [0.0.1] - 2020-04-29
### Added
- This CHANGELOG file to hopefully serve as an evolving example of a
  standardized open source project CHANGELOG.

[Unreleased]: https://github.com/danhort/docker-magento/compare/0.5.4...HEAD
[0.5.4]: https://github.com/danhort/docker-magento/compare/0.5.3...0.5.4
[0.5.3]: https://github.com/danhort/docker-magento/compare/0.5.2...0.5.3
[0.5.2]: https://github.com/danhort/docker-magento/compare/0.5.1...0.5.2
[0.5.1]: https://github.com/danhort/docker-magento/compare/0.5.0...0.5.1
[0.5.0]: https://github.com/danhort/docker-magento/compare/0.4.0...0.5.0
[0.4.0]: https://github.com/danhort/docker-magento/compare/0.3.0...0.4.0
[0.3.0]: https://github.com/danhort/docker-magento/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/danhort/docker-magento/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/danhort/docker-magento/compare/0.0.1...0.1.0
[0.0.1]: https://github.com/danhort/docker-magento/releases/tag/0.0.1
