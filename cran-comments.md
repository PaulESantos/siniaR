## Resubmission

This is a resubmission of 'siniaR' version 0.1.0 in response to reviewer comments (Uwe Ligges):

* **Web access timeouts and graceful exit**:
  - All web requests now use `curl` with an explicit default timeout of 5 seconds (configurable via `options(siniaR.timeout = ...)`).
  - Implemented graceful exit on network timeouts, HTTP errors, or unavailable remote services: functions now emit informative warnings/messages and return empty tibbles or `invisible(NULL)` instead of aborting abruptly.
  - Moved `curl` to `Imports` in `DESCRIPTION`.
  - Added `skip_on_cran()` for live API integration tests.

* **API references in DESCRIPTION**:
  - Added explicit web reference to the SINIA API (<https://sinia.minam.gob.pe/>) in the `Description` field of `DESCRIPTION`.

* **Example CPU/Elapsed time**:
  - Streamlined examples (notably `sinia_buscar()`) to run single fast queries under `@examplesIf curl::has_internet()` and wrapped secondary queries in `\donttest{}`, ensuring all example checks run in < 2 seconds.

## Test environments

* local Windows 11, R 4.6.1
* Debian GNU/Linux (R-devel)
* Windows Server 2022 (R-devel ucrt)
* GitHub Actions:
  * windows-latest (release)
  * macOS-latest (release)
  * ubuntu-latest (release, devel)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release (initial submission).

## Method References

The package accesses the public REST API of Peru's National Environmental Information System (SINIA / Ministry of the Environment, <https://sinia.minam.gob.pe/>). There are no published external academic method references for the API client implementation.
