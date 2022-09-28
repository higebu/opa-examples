# VyOS config evaluation with OPA

## Generate JSON formatted config

```shell
show configuration json pretty > config.json
```

See https://docs.vyos.io/en/latest/cli.html#opcmd-show-configuration-json-pretty

## Evaluate a VyOS config with OPA

```console
$ opa eval -i config.json -d policy/violation.rego "data.main.violation[x]"
{
  "result": [
    {
      "expressions": [
        {
          "value": "static route contains not allowed cidrs: {\"0.0.0.0/0\"}",
          "text": "data.main.violation[x]",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ],
      "bindings": {
        "x": "static route contains not allowed cidrs: {\"0.0.0.0/0\"}"
      }
    }
  ]
}
```

## Evaluate a VyOS config with conftest

```console
$ conftest test config.json
FAIL - config.json - main - static route contains not allowed cidrs: {"0.0.0.0/0"}

1 test, 0 passed, 0 warnings, 1 failure, 0 exceptions
```
