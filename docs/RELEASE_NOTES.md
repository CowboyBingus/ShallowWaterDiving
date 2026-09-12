# Release notes

## data-v2 — publication candidate

- Rename the public project and mod-manager package to **Shallow Water Diving**.
- Add a matching coastal banner and square cover.
- Preserve the existing manager GUID, Lua resource name and runtime singleton for upgrades.
- Wait through native initialization instead of permanently stopping on missing pointers or avatar records.
- Keep the airborne water-reference policy and its local write boundaries unchanged.

Offline regression, startup recovery and package checks pass. In-game first-frame timing, successful shallow-water escape dives and host/client behavior still require validation. This is not a gameplay-verified release.

## data-v1 — initial candidate

Implemented the temporary standing water reference during an accepted airborne dive, with restoration at landing or deeper-water entry. The first installed run stopped on unavailable native state before observing any dives; data-v2 addresses that startup failure.
