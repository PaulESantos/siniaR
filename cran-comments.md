## Test environments

* local Windows 11, R 4.6.1
* GitHub Actions:
  * windows-latest (release)
  * macOS-latest (release)
  * ubuntu-latest (release, devel)

## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a new release (initial submission).
* Note on example elapsed time for `sinia_buscar`: the example queries the public live REST API of Peru's SINIA; elapsed time (> 5s) depends on remote network latency.

## Method References

The package accesses the public REST API of Peru's National Environmental Information System (SINIA / Ministry of the Environment). There are no published external academic method references for the API client implementation.
