Slideshare Downloader
=====================

This small script downloads a slideshare presentation and converts it to PDF.

Disclaimer
----------

This code is made for fun, when i had a cup of coffee more then usual and i
couldn't sleep.  Using this code you may violate Slideshare terms and
conditions.

Usage
-----

Is super easy:

    chmod +x slideshare-dl.sh
    ./slideshare-dl.sh URL

where `URL` is the link to the presentation.

Requirements
------------

It requires `wget`, `swftools` and `imagemagick`.

Features
--------

Both download and conversion are done in parallel, speeding up the total
execution time.  The DPI used for the conversion is easily configurable, in
case you need better definition or smaller files.

Limitations
-----------

Is not currently possible to extract (copy) text contents from the slides,
since each slide is rendered to an image. An OCR option or a different
conversion may be included in the future.
