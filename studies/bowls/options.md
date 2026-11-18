# Which bowls fit a monitor

Written by `studies/bowls/derive.py --options` from `studies/bowls/study.json`; do not edit.

3 × 2 bowls over a lit area of 589.97 × 332.93 mm, spaced as evenly as
the limits allow: every opening at least 0 mm inside the lit area, at least
1 mm between two flanges, and at least 6 mm of frame between two
holes and between a hole and the plate's edge. Everything else as in the study: a wall of 1 mm, 10° of draft, a frame of 6 mm.

| Opening, mm | Flange, mm | Fits | Pitch x / y, mm | Opening inside the lit area, y, mm | Between flanges, y, mm | Flat floor, mm | To the rim, ml |
| ---: | ---: | --- | ---: | ---: | ---: | ---: | ---: |
| 140 | 3 | yes | 196.66 / 166.47 | 13.23 | 20.47 | 116.2 | 293 |
| 140 | 5 | yes | 196.66 / 166.47 | 13.23 | 16.47 | 116.2 | 293 |
| 140 | 8 | yes | 196.66 / 166.47 | 13.23 | 10.47 | 116.2 | 293 |
| 145 | 3 | yes | 196.66 / 166.47 | 10.73 | 15.47 | 121.2 | 314 |
| 145 | 5 | yes | 196.66 / 166.47 | 10.73 | 11.47 | 121.2 | 314 |
| 145 | 8 | yes | 196.66 / 166.47 | 10.73 | 5.47 | 121.2 | 314 |
| 150 | 3 | yes | 196.66 / 166.47 | 8.23 | 10.47 | 126.2 | 337 |
| 150 | 5 | yes | 196.66 / 166.47 | 8.23 | 6.47 | 126.2 | 337 |
| 150 | 8 | yes | 196.66 / 174.97 | 3.98 | 8.97 | 126.2 | 337 |
| 155 | 3 | yes | 196.66 / 166.47 | 5.73 | 5.47 | 131.2 | 360 |
| 155 | 5 | yes | 196.66 / 166.47 | 5.73 | 1.47 | 131.2 | 360 |
| 155 | 8 | yes | 196.66 / 174.97 | 1.48 | 3.97 | 131.2 | 360 |
| 160 | 3 | yes | 196.66 / 169.97 | 1.48 | 3.97 | 136.2 | 385 |
| 160 (the study) | 5 | yes | 196.66 / 171.97 | 0.48 | 1.97 | 136.2 | 385 |
| 160 | 8 | **no**: along y, 2 bowls need a pitch of at least 177.00 mm and the lit area allows 172.93 mm: short by 4.07 mm in all | | | | | |
| 165 | 3 | **no**: along y, 2 bowls need a pitch of at least 172.00 mm and the lit area allows 167.93 mm: short by 4.07 mm in all | | | | | |
| 165 | 5 | **no**: along y, 2 bowls need a pitch of at least 176.00 mm and the lit area allows 167.93 mm: short by 8.07 mm in all | | | | | |
| 165 | 8 | **no**: along y, 2 bowls need a pitch of at least 182.00 mm and the lit area allows 167.93 mm: short by 14.07 mm in all | | | | | |
| 170 | 3 | **no**: along y, 2 bowls need a pitch of at least 177.00 mm and the lit area allows 162.93 mm: short by 14.07 mm in all | | | | | |
| 170 | 5 | **no**: along y, 2 bowls need a pitch of at least 181.00 mm and the lit area allows 162.93 mm: short by 18.07 mm in all | | | | | |
| 170 | 8 | **no**: along y, 2 bowls need a pitch of at least 187.00 mm and the lit area allows 162.93 mm: short by 24.07 mm in all | | | | | |

The largest opening that fits, for each flange:

| Flange, mm | Largest opening, mm |
| ---: | ---: |
| 3 | 162.9 |
| 5 | 160.9 |
| 8 | 157.9 |

The most bowls that fit, with the study's flange of 5 mm:

| Opening, mm | Most bowls | as columns × rows |
| ---: | ---: | --- |
| 80 | 18 | 6 × 3 |
| 100 | 15 | 5 × 3 |
| 120 | 8 | 4 × 2 |
| 140 | 6 | 3 × 2 |
| 145 | 6 | 3 × 2 |
| 150 | 6 | 3 × 2 |
| 155 | 6 | 3 × 2 |
| 160 | 6 | 3 × 2 |
| 165 | 3 | 3 × 1 |
| 170 | 3 | 3 × 1 |

The water is that of a cone's frustum between the floor and the rim, without the two radii: a little more than
the bowl holds. The exact figure for the study's bowl is in `summary.md`.
