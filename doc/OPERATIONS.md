# Operations (Short)

## First run (repo)

```sh
make init
make test
```

## Generate passphrase

```sh
make gen-pass
```

## Push code

```sh
make push
```

## Publish to pub.dev

1) Update version in `pubspec.yaml`.
2) Update `CHANGELOG.md` - update version in `pubspec.yaml`.
3) Commit code changes.
4) Validate: `dart pub publish --dry-run`
5) Publish: `dart pub publish`
