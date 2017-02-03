# Change Log

## [v0.8.0](https://github.com/fastly/fastly-rails/tree/v0.8.0) (2017-02-03)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.7.1...v0.8.0)

**Fixed bugs:**

- Failing purges with fastly-ruby v1.1.5 [\#35](https://github.com/fastly/fastly-rails/issues/35)

**Closed issues:**

- "See note on cookies below" link in the Readme goes to 404. [\#65](https://github.com/fastly/fastly-rails/issues/65)
- Rails 5 Support [\#64](https://github.com/fastly/fastly-rails/issues/64)
- soft\_purge fails with - ArgumentError - wrong number of arguments \(given 2, expected 1\) [\#61](https://github.com/fastly/fastly-rails/issues/61)
- Does not work with rails-api [\#38](https://github.com/fastly/fastly-rails/issues/38)

**Merged pull requests:**

- Support stale-while-revalidate and stale-if-error [\#73](https://github.com/fastly/fastly-rails/pull/73) ([lanej](https://github.com/lanej))
- test: use WebMock to disable live connections [\#72](https://github.com/fastly/fastly-rails/pull/72) ([lanej](https://github.com/lanej))
- chore: remove mime-types dependency [\#71](https://github.com/fastly/fastly-rails/pull/71) ([lanej](https://github.com/lanej))
- add rails-api support [\#70](https://github.com/fastly/fastly-rails/pull/70) ([lanej](https://github.com/lanej))
- remove generator configuration from railtie [\#69](https://github.com/fastly/fastly-rails/pull/69) ([lanej](https://github.com/lanej))
- Add Rails 5 support [\#68](https://github.com/fastly/fastly-rails/pull/68) ([lanej](https://github.com/lanej))

## [v0.7.1](https://github.com/fastly/fastly-rails/tree/v0.7.1) (2016-07-29)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/0.7.0...v0.7.1)

**Closed issues:**

- purging\_enabled not considered [\#59](https://github.com/fastly/fastly-rails/issues/59)
- Soft Purge fails on 0.7.0 [\#57](https://github.com/fastly/fastly-rails/issues/57)

**Merged pull requests:**

- Bump fastly-ruby to 1.6 [\#60](https://github.com/fastly/fastly-rails/pull/60) ([blithe](https://github.com/blithe))
- fix ArgumentError for FastlyRails::Client\#purge\_by\_key [\#58](https://github.com/fastly/fastly-rails/pull/58) ([lanej](https://github.com/lanej))

## [0.7.0](https://github.com/fastly/fastly-rails/tree/0.7.0) (2016-06-02)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.6.0...0.7.0)

**Merged pull requests:**

- Adds soft purging from fastly-ruby client [\#56](https://github.com/fastly/fastly-rails/pull/56) ([gschorkopf](https://github.com/gschorkopf))

## [v0.6.0](https://github.com/fastly/fastly-rails/tree/v0.6.0) (2016-05-10)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.5.0...v0.6.0)

**Closed issues:**

- Enable use of current version of mime-types [\#52](https://github.com/fastly/fastly-rails/issues/52)

**Merged pull requests:**

- Bump fastly-ruby to 1.4.0 [\#55](https://github.com/fastly/fastly-rails/pull/55) ([blithe](https://github.com/blithe))
- bumping fastly dependency to 1.3.0 [\#54](https://github.com/fastly/fastly-rails/pull/54) ([caueguerra](https://github.com/caueguerra))

## [v0.5.0](https://github.com/fastly/fastly-rails/tree/v0.5.0) (2016-04-04)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.4.1...v0.5.0)

**Merged pull requests:**

- Depend on railties instead of rails [\#51](https://github.com/fastly/fastly-rails/pull/51) ([clupprich](https://github.com/clupprich))

## [v0.4.1](https://github.com/fastly/fastly-rails/tree/v0.4.1) (2016-03-02)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.3.0...v0.4.1)

**Closed issues:**

- purging\_enabled isn't supported in gem version 0.3.0 [\#46](https://github.com/fastly/fastly-rails/issues/46)
- FastlyRails shouldn't raise error when api key isn't set [\#44](https://github.com/fastly/fastly-rails/issues/44)

**Merged pull requests:**

- Fixed link to finding API keys documentation [\#50](https://github.com/fastly/fastly-rails/pull/50) ([phantomwhale](https://github.com/phantomwhale))
- Update fastly-ruby gem to 1.2.1 [\#49](https://github.com/fastly/fastly-rails/pull/49) ([phantomwhale](https://github.com/phantomwhale))
- bump gem version [\#48](https://github.com/fastly/fastly-rails/pull/48) ([set5think](https://github.com/set5think))
- use static title instead of faker [\#45](https://github.com/fastly/fastly-rails/pull/45) ([set5think](https://github.com/set5think))
- Remove unneccessary attr\_readers [\#43](https://github.com/fastly/fastly-rails/pull/43) ([sobbybutter](https://github.com/sobbybutter))
- add link to docs for service ids and api keys [\#41](https://github.com/fastly/fastly-rails/pull/41) ([thommahoney](https://github.com/thommahoney))
- Allow purging to be toggled [\#39](https://github.com/fastly/fastly-rails/pull/39) ([gingermusketeer](https://github.com/gingermusketeer))

## [v0.3.0](https://github.com/fastly/fastly-rails/tree/v0.3.0) (2015-03-13)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.2.0...v0.3.0)

**Closed issues:**

- Incompatibilities with "service\_id" as a column name [\#36](https://github.com/fastly/fastly-rails/issues/36)

**Merged pull requests:**

- Rename service\_id to fastly\_service\_identifier [\#40](https://github.com/fastly/fastly-rails/pull/40) ([set5think](https://github.com/set5think))

## [v0.2.0](https://github.com/fastly/fastly-rails/tree/v0.2.0) (2014-10-02)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.7...v0.2.0)

**Merged pull requests:**

- Skey purge authentication [\#29](https://github.com/fastly/fastly-rails/pull/29) ([mmay](https://github.com/mmay))

## [v0.1.7](https://github.com/fastly/fastly-rails/tree/v0.1.7) (2014-10-01)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.6...v0.1.7)

**Merged pull requests:**

- Fix purge method receiver regression [\#30](https://github.com/fastly/fastly-rails/pull/30) ([jumph4x](https://github.com/jumph4x))

## [v0.1.6](https://github.com/fastly/fastly-rails/tree/v0.1.6) (2014-09-23)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.5...v0.1.6)

**Merged pull requests:**

- Add optional middleware for removing `Set-Cookie` [\#28](https://github.com/fastly/fastly-rails/pull/28) ([jessieay](https://github.com/jessieay))
- Purge without fetching the service first [\#27](https://github.com/fastly/fastly-rails/pull/27) ([mmay](https://github.com/mmay))
- Rename SurrogateControlHeaders to SurrogateKeyHeaders [\#26](https://github.com/fastly/fastly-rails/pull/26) ([mmay](https://github.com/mmay))

## [v0.1.5](https://github.com/fastly/fastly-rails/tree/v0.1.5) (2014-09-04)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.4...v0.1.5)

**Closed issues:**

- Version 0.1.3 breaks Namespaced routes in my app [\#23](https://github.com/fastly/fastly-rails/issues/23)

**Merged pull requests:**

- Index action should join resource keys [\#25](https://github.com/fastly/fastly-rails/pull/25) ([jessieay](https://github.com/jessieay))

## [v0.1.4](https://github.com/fastly/fastly-rails/tree/v0.1.4) (2014-06-12)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.2...v0.1.4)

**Fixed bugs:**

- Internal Server Error [\#19](https://github.com/fastly/fastly-rails/issues/19)

**Closed issues:**

- rake fastly:purge\_everything task [\#16](https://github.com/fastly/fastly-rails/issues/16)
- Consider enforcing a Ruby style guide with Hound [\#13](https://github.com/fastly/fastly-rails/issues/13)

**Merged pull requests:**

- ensure configuration test never fails due to randomization [\#22](https://github.com/fastly/fastly-rails/pull/22) ([set5think](https://github.com/set5think))
- add service\_id as a configuration attribute, and fix purge [\#21](https://github.com/fastly/fastly-rails/pull/21) ([set5think](https://github.com/set5think))

## [v0.1.2](https://github.com/fastly/fastly-rails/tree/v0.1.2) (2014-05-08)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.1...v0.1.2)

**Closed issues:**

- Opt-in vs Opt-out for Edge Caching [\#2](https://github.com/fastly/fastly-rails/issues/2)

**Merged pull requests:**

- Add Rails v4.1.0 to appraisal [\#17](https://github.com/fastly/fastly-rails/pull/17) ([ezkl](https://github.com/ezkl))
- Add surrogate key adapter for Mongoid [\#15](https://github.com/fastly/fastly-rails/pull/15) ([joshfrench](https://github.com/joshfrench))
- Don't encourage use of hard-coded credentials [\#14](https://github.com/fastly/fastly-rails/pull/14) ([harlow](https://github.com/harlow))

## [v0.1.1](https://github.com/fastly/fastly-rails/tree/v0.1.1) (2014-04-28)
[Full Changelog](https://github.com/fastly/fastly-rails/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- Clarify surrogate key definition in readme [\#12](https://github.com/fastly/fastly-rails/pull/12) ([aspires](https://github.com/aspires))
- Move to opt-in edge caching [\#11](https://github.com/fastly/fastly-rails/pull/11) ([mmay](https://github.com/mmay))
- Use `self.method` instead of `extend self` [\#10](https://github.com/fastly/fastly-rails/pull/10) ([gabebw](https://github.com/gabebw))
- Add some more documentation [\#9](https://github.com/fastly/fastly-rails/pull/9) ([gabebw](https://github.com/gabebw))
- remove purgeable and fastly dir - not used at all, and not implemented [\#8](https://github.com/fastly/fastly-rails/pull/8) ([set5think](https://github.com/set5think))
- Clarify logic around authentication [\#6](https://github.com/fastly/fastly-rails/pull/6) ([gabebw](https://github.com/gabebw))
- Remove unnecessary InstanceMethods module [\#5](https://github.com/fastly/fastly-rails/pull/5) ([gabebw](https://github.com/gabebw))
- remove unnecessary items in test book model [\#4](https://github.com/fastly/fastly-rails/pull/4) ([set5think](https://github.com/set5think))
- clean up Configuration implementation [\#3](https://github.com/fastly/fastly-rails/pull/3) ([chaslemley](https://github.com/chaslemley))
- Update broken README link [\#1](https://github.com/fastly/fastly-rails/pull/1) ([harlow](https://github.com/harlow))

## [v0.1.0](https://github.com/fastly/fastly-rails/tree/v0.1.0) (2014-04-17)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*