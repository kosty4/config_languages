
# Configuration languages

This repo shows an implementation of gitlab-ci.yaml file that is generated using KCL.

Config languages are designed to simplify and improve the management of configurations for software systems. For example, instead of writing YAML's
by hand, you can automate their generation with a config language.
By doing so, you also increase the maintainability of your configurations. 

Why not use a high-level language for creating configs?

- Not a bad idea but not secure
- Basel/Starlark
  - Python without side effects (like writing to FS/ do network calls)
  - More secure

Some properties of configuratiuon languages:
- Designed to generate data 
- Designed to produce correct YAML
- For various reasons can't be fully replaced by general-purpose programming languages

Config languages examples:

- cue (Written in GO, no difference between values and types, functional)
- dhall (JSON + functions + types + imports, functional)
- pkl (OOP Friendly, strong typing)
- kcl (OOP Friendly)
- jsonnet
- timoni


Steps to run the example:

```
brew install kcl-lang/tap/kcl

cd gitlab-ci
kcl kcl/gitlab_main.k -o yaml/gitlab-ci-output.yaml

```






