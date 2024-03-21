# Pkl Rules

[Pkl][] is an embeddable configuration language with rich support for data templating and
validation. It can be used from the command line, integrated in a build pipeline, or embedded in a
program. Pkl scales from small to large, simple to complex, ad-hoc to repetitive configuration
tasks.

For further information about Pkl, check out the [official PKL documentation][].

[official PKL documentation]: https://pkl.apple.com/main/current/index.html
[pkl]: https://pkl.apple.com


## Quick Start

### Setup

To use `rules_pkl` enable `bzlmod` within your project, and then add the following to your `MODULE.bazel`:

```starlark
# Please check the releases page on GitHub for the latest released version
bazel_dep(name = "rules_pkl", version = "1.0.0")
```

## Examples

See the `example/` directory for complete examples of how to use `rules_pkl`.

## Ruleset Docs
For further information on the rules provided, check out [rules_pkl_doc]
[rules_pkl_doc]: https://github.pie.apple.com/bazel-mirror/rules_pkl/blob/main/docs/rules_pkl_docs.md