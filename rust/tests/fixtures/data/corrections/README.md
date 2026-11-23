# The fixture's corrections

The data build's corrections for the fixture builds: a folder of section files, laid out like
`forever-db/corrections` (a missing file is an empty section). It is empty on purpose. The fixture builds
read it instead of the checkout's corrections, which grow with every data fix and would add their records to
every count and list the fixture tests check. A test about the checkout's own corrections points its build
at `forever-db/corrections` itself.
