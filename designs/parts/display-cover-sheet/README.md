# Display cover sheet (stand-in)

A flat sheet with the outline of the monitor's body, 6 mm thick, lying on the
front of the screen. It stands in for the acrylic sheet the brief sets the
bowls on, so that the [bowls](../bowl/README.md) and the
[bowl frame](../bowl-frame/README.md) have something to rest on in the
assembly [monitor-with-bowls](../../assemblies/monitor-with-bowls/README.md).

**It is not the design of that sheet.** The brief says only that there is an
acrylic sheet. Its thickness, its outline, whether one sheet covers both
monitors, what carries it and what keeps water from running off it onto the
monitors are all open. When they are known this part is replaced, and the
frame, which takes its outline from it, is built again.

`build.py` takes the body's outline from the monitor's `interface.json` and
grows it by `overhang` (0 here). The frame is the monitor's: the sheet's
underside is Z = 0, the front of the screen, and the sheet lies in positive Z.

```sh
make part KEY=display-cover-sheet        # after the monitor
```
