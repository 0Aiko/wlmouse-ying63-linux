# wlmouse-ying63-linux
WLmouse Ying63 Linux udev Fix
This repository provides a simple `udev` rule to grant your browser access to the WLmouse Ying63 keyboard so you can use the configuration website under Linux.

---

## ⚙️ Instructions

### 1. Find Vendor ID and Product ID (most likely they will be the same as mine, but if something doesn’t work it’s worth checking)

Open a terminal and run:

```bash
lsusb
