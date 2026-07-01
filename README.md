# example

A reference DollarDeploy custom service. It shows the full contract:

- `prepare.sh` — required, idempotent, runs on every host prepare.
- `uninstall.sh` — optional, runs once when the service is removed.
- Emitting a **custom env var** back to DollarDeploy so it persists across
  prepares and is injected into your app's environment.

## What it does

This sample installs a tiny demo CLI (`jq` as a stand-in for "your software"),
generates a random API token **once**, and reports two values back to
DollarDeploy:

- `EXAMPLE_GREETING` — a static value emitted from the service.
- `EXAMPLE_API_TOKEN` — a secret generated on first prepare and reused on
  every subsequent prepare (so it stays stable).

These become available to your app as `EXAMPLE_GREETING` and `EXAMPLE_API_TOKEN`.

## Use it

1. Push this repo **public** to `github.com/<owner>/service-example`.
2. On your host → **Services** tab → add a **Custom** service → paste the repo URL.
3. **Prepare** the host. The repo clones into `~/services/example` and
   `prepare.sh` runs.
4. To remove: delete the service and prepare again — `uninstall.sh` runs.
