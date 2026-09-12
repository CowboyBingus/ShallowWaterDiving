# Publication privacy review

The initial public source inventory contains only authored code, synthetic regression tests, build scripts, dependency pins, documentation and the two reviewed artwork assets. Personal paths and identifiers, local logs/profiles, research captures, extracted game resources, crash dumps, dependency binaries and build caches are excluded. A fresh Git repository avoids importing private workspace history.

`scripts/privacy_audit.py` defines the exact source inventory and checks text in UTF-8 and both UTF-16 byte orders. It looks for personal home and network-share paths, local account/machine identifiers, email and phone formats, account identifiers, network addresses, private keys and common credential patterns. It verifies the staged inventory and installable ZIP when requested. Generated reports contain relative paths and hashes, never matched sensitive values.

The PNG assets were visually reviewed and stripped of ancillary metadata without altering their encoded pixels. Only image-critical chunks remain. ZIP entries use fixed timestamps and ordinary file permissions, without comments or extra fields. The Lua module uses stripped bytecode. Public project names, GitHub links, resource hashes, synthetic addresses, build versions and the stable manager GUID are intentional technical/public identifiers.

The publication commit uses the public CowboyBingus GitHub noreply identity. No personal email or machine identity is required. The repository does not include surrounding research or its history.

Automated pattern checks and manual review cover the stated inventory; they cannot guarantee the absence of every conceivable identifying value. The installable candidate remains subject to gameplay validation, independently of this privacy review.
