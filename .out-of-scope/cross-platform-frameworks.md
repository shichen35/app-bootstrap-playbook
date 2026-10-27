# Cross-platform frameworks

This repo does not accept processes or skills for building both platforms from one codebase with Flutter, React Native or Kotlin Multiplatform.

## Why

The goal of this process is a native experience on every platform: widgets, background tasks, notifications and the system design language are each built with the APIs that platform currently recommends. The platforms share requirement numbers, the glossary, the reasoning behind ADRs and the test ideas, not a code framework. Core logic in the same language can be copied, with the upstream commit hash recorded (see `app-platform-port`).

Projects that use a cross-platform framework are welcome to borrow the requirements, ADR and task loop pieces, but the porting and platform-specific skills will not change to accommodate them.
